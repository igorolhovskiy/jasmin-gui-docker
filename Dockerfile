FROM python:2.7
MAINTAINER Andrey Maslov <am@fitel.io>

# System requirements
RUN apt-get update \
    && apt-get --yes --no-install-recommends install \
    	build-essential \
    	locales \
        telnet

# Project requirements
RUN mkdir /app
COPY JasminWebPanel/requirements.pip /app/requirements.pip
RUN pip install --upgrade pip \
    && pip install \
    	gunicorn==19.6.0 \
    	whitenoise==3.3.0 \
    && pip install --upgrade -r /app/requirements.pip \
    && rm -f /app/requirements.pip

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY /config/entry.sh /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]

WORKDIR /app
EXPOSE 8000
CMD ["gunicorn"]
