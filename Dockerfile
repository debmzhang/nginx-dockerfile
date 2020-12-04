FROM centos:centos7
MAINTAINER nerd

COPY depends/* /tmp/env/

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && cp /tmp/env/CentOS7-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo && yum clean all && yum makecache fast && yum -y update \
    && cp /tmp/env/nginx.repo /etc/yum.repos.d/ \
    && yum install -y nginx \
    && cp /tmp/env/fastcgi.conf /etc/nginx/ \
    && rm -rf /tmp/env/

EXPOSE 80
EXPOSE 443

VOLUME ["/www/", "/etc/nginx/conf.d/", "/var/log/nginx/", "/tmp/"]

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
