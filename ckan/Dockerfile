FROM ckan/ckan-base:2.11.4

# Install any extensions needed by your CKAN instance
# See Dockerfile.dev for more details and examples

USER root
RUN mkdir /srv/app/.local && chown ckan /srv/app/.local
USER ckan

### Scheming ###
RUN  pip3 install -e git+https://github.com/ckan/ckanext-scheming.git@release-3.1.0#egg=ckanext-scheming

### Pages ###
RUN  pip3 install -e git+https://github.com/belgium-its-steering-committee/ckanext-pages.git@3.0.0#egg=ckanext-pages

### Fluent ### 
RUN  pip3 install -e git+https://github.com/belgium-its-steering-committee/ckanext-fluent.git@2.1.0#egg=ckanext-fluent

### Benap ###
RUN  pip3 install -e git+https://github.com/belgium-its-steering-committee/ckanext-benap.git@6.1.3#egg=ckanext-benap

### Hidegroups ###
RUN  pip3 install -e git+https://github.com/belgium-its-steering-committee/ckanext-hidegroups.git@2.0.0#egg=ckanext-hidegroups

### Mailchimp ###
RUN  pip3 install -e git+https://github.com/belgium-its-steering-committee/ckanext-mailchimp.git@3.1.0#egg=ckanext-mailchimp

### YTP Request ###
RUN  pip3 install -e git+https://github.com/belgium-its-steering-committee/ckanext-ytp-request.git@1.0.0#egg=ckanext-ytp-request

### DCAT ###
RUN  pip3 install -e git+https://github.com/belgium-its-steering-committee/ckanext-dcat.git@dcat-catalog-record#egg=ckanext-dcat

### custom DCAT (including MobilityDCAT) ###
RUN  pip3 install -e git+https://github.com/belgium-its-steering-committee/ckanext-dcat-be-napits.git@1.0.0#egg=ckanext-dcat-be-napits

### ClamAV ###
RUN pip3 install -e git+https://github.com/DataShades/ckanext-clamav.git@v1.1.1#egg=ckanext-clamav && \
    pip3 install -r ${APP_DIR}/src/ckanext-clamav/requirements.txt

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
