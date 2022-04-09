# syntax=docker/dockerfile:1

FROM python:3.10.4-slim-bullseye

#SSH
RUN apt-get update && apt-get install -y \
                            ssh \
                            git

# Add SSH keys and assure the domain is in the known_hosts
ARG SSH_PRIVATE_KEY
RUN mkdir -p /root/.ssh/ &&\
    echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa &&\
    touch /root/.ssh/known_hosts &&\
    ssh-keyscan git.ks2.co >> /root/.ssh/known_hosts &&\
    ssh -T git@git.ks2.co

WORKDIR /app

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install dependencies:
COPY requirements.txt .
RUN pip install -r requirements.txt

# REMOVED KEY
RUN rm /root/.ssh/*

# Copy only app.py
COPY app.py .

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
