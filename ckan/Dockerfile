FROM ckan/ckan-base:2.11

# Install any extensions needed by your CKAN instance
# See Dockerfile.dev for more details and examples

USER root
RUN mkdir /srv/app/.local && chown ckan /srv/app/.local
USER ckan

### Scheming ###
RUN  pip3 install -e git+https://github.com/ckan/ckanext-scheming.git@release-3.1.0#egg=ckanext-scheming

### Pages ###
RUN  pip3 install -e git+https://github.com/belgium-its-steering-committee/ckanext-pages.git@CKAN-2.11-upgrade#egg=ckanext-pages

### Fluent ### 
RUN  pip3 install -e git+https://github.com/belgium-its-steering-committee/ckanext-fluent.git@MobilityDCAT/root#egg=ckanext-fluent

### Transportdata ### 
RUN  pip3 install -e git+https://github.com/belgium-its-steering-committee/ckanext-transportdata.git#egg=ckanext-transportdata

### Benap ###
RUN  pip3 install -e git+https://github.com/belgium-its-steering-committee/ckanext-benap.git@CKAN-2.11-upgrade#egg=ckanext-benap

### Hidegroups ###
RUN  pip3 install -e git+https://github.com/belgium-its-steering-committee/ckanext-hidegroups.git@development#egg=ckanext-hidegroups

### Mailchimp ###
RUN  pip3 install -e git+https://github.com/belgium-its-steering-committee/ckanext-mailchimp.git@CKAN-2.11-upgrade#egg=ckanext-mailchimp

### YTP Request ###
RUN  pip3 install -e git+https://github.com/belgium-its-steering-committee/ckanext-ytp-request.git@CKAN-2.11-upgrade#egg=ckanext-ytp-request

### DCAT ###
RUN  pip3 install -e git+https://github.com/ckan/ckanext-dcat.git@v2.4.0#egg=ckanext-dcat

# Copy custom initialization scripts
COPY --chown=ckan-sys:ckan-sys docker-entrypoint.d/* /docker-entrypoint.d/

# Apply any patches needed to CKAN core or any of the built extensions (not the
# runtime mounted ones)
COPY --chown=ckan-sys:ckan-sys patches ${APP_DIR}/patches

USER ckan

RUN for d in $APP_DIR/patches/*; do \
        if [ -d $d ]; then \
            for f in `ls $d/*.patch | sort -g`; do \
                cd $SRC_DIR/`basename "$d"` && echo "$0: Applying patch $f to $SRC_DIR/`basename $d`"; patch -p1 < "$f" ; \
            done ; \
        fi ; \
    done
