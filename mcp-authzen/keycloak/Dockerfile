# Keycloak with the Cedar policy provider, used by docker-compose.cedar.yaml.
# https://github.com/embesozzi/keycloak-cedar-authorization
ARG KEYCLOAK_VERSION=26.7

# Download the provider jar and the native library for the build platform,
# checked against the release's SHA256SUMS.
FROM debian:bookworm-slim AS cedar
ARG CEDAR_PROVIDER_VERSION=0.1.0
ARG TARGETARCH
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /cedar
RUN ARCH=$([ "$TARGETARCH" = arm64 ] && echo aarch64 || echo x86_64) && \
    BASE=https://github.com/embesozzi/keycloak-cedar-authorization/releases/download/v${CEDAR_PROVIDER_VERSION} && \
    curl -fsSL --remote-name-all \
        "$BASE/keycloak-cedar-authorization-${CEDAR_PROVIDER_VERSION}.jar" \
        "$BASE/libcedar_java_ffi-linux-${ARCH}.so" \
        "$BASE/SHA256SUMS" && \
    sha256sum -c SHA256SUMS --ignore-missing && \
    mv keycloak-cedar-authorization-${CEDAR_PROVIDER_VERSION}.jar keycloak-cedar-authorization.jar && \
    mv libcedar_java_ffi-linux-${ARCH}.so libcedar_java_ffi.so

FROM quay.io/keycloak/keycloak:${KEYCLOAK_VERSION}
COPY --from=cedar /cedar/keycloak-cedar-authorization.jar /opt/keycloak/providers/
COPY --from=cedar /cedar/libcedar_java_ffi.so /opt/cedar/
ENV CEDAR_JAVA_FFI_LIB=/opt/cedar/libcedar_java_ffi.so
