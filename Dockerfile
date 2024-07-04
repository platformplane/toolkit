FROM alpine

RUN apk add --no-cache ca-certificates curl wget git jq

# Install Docker CLI
ARG DOCKER_VERSION=26.1.4
RUN curl -fsSL "https://download.docker.com/linux/static/stable/$(uname -m)/docker-${DOCKER_VERSION}.tgz" | tar -zxf - --strip=1 -C /usr/local/bin/ docker/docker

# Kubenetes CLI
ENV KUBERNETES_VERSION=1.30.2
RUN arch=$(uname -m) && \
    if [ "${arch}" = "x86_64" ]; then \
    arch="amd64"; \
    elif [ "${arch}" = "aarch64" ]; then \
    arch="arm64"; \
    fi && \
    curl -Lo /usr/local/bin/kubectl https://dl.k8s.io/release/v${KUBERNETES_VERSION}/bin/linux/${arch}/kubectl && \
    chmod +x /usr/local/bin/kubectl 

# Helm CLI
ENV HELM_VERSION=3.15.2
RUN arch=$(uname -m) && \
    if [ "${arch}" = "x86_64" ]; then \
    arch="amd64"; \
    elif [ "${arch}" = "aarch64" ]; then \
    arch="arm64"; \
    fi && \
    curl -fsSL https://get.helm.sh/helm-v${HELM_VERSION}-linux-${arch}.tar.gz | tar -zxf - --strip=1 -C /usr/local/bin/ linux-${arch}/helm 
