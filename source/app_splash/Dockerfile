FROM nginx:latest
# EXPOSE 80 443
RUN apt update && apt install dnsutils -y \
    && apt install vim -y
COPY ["aliases.sh", "/etc/profile.d/"]
COPY ["index.html", "/usr/share/nginx/html/"]

