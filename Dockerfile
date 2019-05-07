FROM ubuntu

RUN apt-get -y update && \
  apt-get -y install curl

ARG helm_version

RUN : "${helm_version:?Must specify version}"

RUN curl -LO https://storage.googleapis.com/kubernetes-helm/helm-v${helm_version}-linux-amd64.tar.gz && \
  tar -zxvf helm-v${helm_version}-linux-amd64.tar.gz && \
  mv linux-amd64/helm /usr/local/bin/helm
