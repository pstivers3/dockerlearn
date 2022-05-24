# for experimantal purposes only
# ssh is not recommended in a docker container
FROM nginx:latest
EXPOSE 22 80 443
ENV user=deploy 
ENV ssh_path=/home/$user/.ssh
RUN adduser --system --disabled-password --disabled-login --group --shell /bin/bash $user && \
    apt-get update && \
    apt-get install vim -y && \
    apt-get install openssh-server -y && \
    apt-get install openssh-client -y
USER $user
RUN mkdir $ssh_path && chmod 700 $ssh_path && \ 
    touch $ssh_path/authorized_keys && \
    chmod 600 $ssh_path/authorized_keys && \
    ssh-keygen -N '' -f $ssh_path/id_rsa -q && cat $ssh_path/id_rsa.pub > $ssh_path/authorized_keys
USER root
# problem: container is not yet recognizing /etc/profile.d/
COPY ["aliases.sh", "start_services.sh", "/etc/profile.d/"]
COPY ["index.html", "/usr/share/nginx/html/"]

