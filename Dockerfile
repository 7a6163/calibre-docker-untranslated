FROM lscr.io/linuxserver/calibre:latest

# Install required packages for downloading and extracting
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Get the latest version number from the releases (currently v7.24.0)
ENV PATCH_VERSION="v7.24.0"

# Add build argument for architecture
ARG TARGETARCH

# Download and apply the patch based on architecture
RUN if [ "$TARGETARCH" = "arm64" ]; then \
        wget https://github.com/Cirn09/calibre-do-not-translate-my-path/releases/download/${PATCH_VERSION}/linux-arm64-patch-backend-${PATCH_VERSION}.zip \
        && unzip linux-arm64-patch-backend-${PATCH_VERSION}.zip \
        && cp lib/calibre-extensions/python-lib.bypy.frozen /opt/calibre/lib/calibre-extensions/ \
        && rm -rf linux-arm64-patch-backend-${PATCH_VERSION}.zip lib; \
    else \
        wget https://github.com/Cirn09/calibre-do-not-translate-my-path/releases/download/${PATCH_VERSION}/linux-x64-patch-backend-${PATCH_VERSION}.zip \
        && unzip linux-x64-patch-backend-${PATCH_VERSION}.zip \
        && cp lib/calibre-extensions/python-lib.bypy.frozen /opt/calibre/lib/calibre-extensions/ \
        && rm -rf linux-x64-patch-backend-${PATCH_VERSION}.zip lib; \
    fi

ENTRYPOINT ["/init"]
