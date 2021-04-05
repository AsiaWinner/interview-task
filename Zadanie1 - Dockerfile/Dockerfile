FROM ubuntu:focal
# Naprawiłam timezone error problem
ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get -y install nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
