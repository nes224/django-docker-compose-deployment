FROM nginxinc/nginx-unprivileged:1-alpine
LABEL maintainer="londonappdeveloper.com"

COPY ./default.conf.tpl /etc/nginx/default.conf.tpl
COPY ./uwsgi_params /etc/nginx/uwsgi_params
COPY ./run.sh /run.sh

ENV LISTEN_PORT=8000
ENV APP_HOST=app
ENV APP_PORT=9000

USER root 
# chmod 755 change the permissions of that directory so the owner of it gets to read and write and make changes.
# chown nginx:nginx  -> we change the ownership of that empty file to the nginx user, And what this means is that user can overwrite
# the contents of the file 
RUN mkdir -p /vol/static && \
    chmod 755 /vol/static && \
    touch /etc/nginx/conf.d/default.conf && \
    chown nginx:nginx /etc/nginx/conf.d/default.conf && \
    chmod +x /run.sh

VOLUME /vol/static

# This switches back from the root user to the nginx user 
USER nginx

CMD ["/run.sh"]