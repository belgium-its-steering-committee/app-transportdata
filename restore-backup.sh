#!/bin/bash

./bin/ckan db clean --yes
./bin/compose exec -T db sh -c "cat prod-dump.dump | pg_restore -U postgres --clean --if-exists -d ckan_default"
# Delete duplicate users
./bin/compose exec -T db psql -U postgres -d ckan_default -c "
DELETE FROM public.user 
WHERE id NOT IN (
  SELECT MIN(id) 
  FROM public.user 
  GROUP BY email
)
AND email IN (
  SELECT email 
  FROM public.user 
  GROUP BY email 
  HAVING COUNT(*) > 1
);"

# can't remove orphaned resources if there are revisions, remove them first
./bin/compose exec -T db psql -U postgres -d ckan_default -c "
DELETE FROM resource_revision
WHERE id IN (
  SELECT id FROM resource
  WHERE package_id NOT IN (
    SELECT id FROM package
  )
);
"

# Remove orphaned resources
./bin/compose exec -T db psql -U postgres -d ckan_default -c "
DELETE FROM resource
WHERE package_id NOT IN (
  SELECT id FROM package
);
"
./bin/ckan db upgrade
./bin/ckan db upgrade -p pages
./bin/ckan search-index rebuild --clear

# TODO add activity migrations here
./bin/restart
./bin/compose logs -f --tail=100


# Activity needs an extra migration
# This is related to https://github.com/ckan/ckan/pull/8784
# UPDATE activity
# SET permission_labels = '{"public"}'
# WHERE (
#     activity_type LIKE '% package' AND
#     permission_labels IS NULL
# )