FROM python:3.9-alpine3.13
LABEL maintainer="sases.pl"

ENV PYTHONUNBUFERRED 1

COPY ./requrements.txt /tmp/requrements.txt
COPY ./requrements.dev.txt /tmp/requrements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requrements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requrements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user