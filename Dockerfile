FROM xenonnt/base-environment:el8.2026.03.1

RUN yum -y clean all && yum -y --skip-broken upgrade && \
    yum -y install \
            avahi-compat-libdns_sd-devel \
            cfitsio-devel \
            compat-openssl10 \
            expat \
            expat-devel \
            fftw-devel \
            ftgl-devel \
            gcc-gfortran \
            glew-devel \
            graphviz-devel \
            gsl-devel \
            libX11-devel \
            libXdmcp \
            libXdmcp-devel \
            libXext-devel \
            libXft-devel \
            libxml2-devel \
            libXmu-devel \
            libXpm-devel \
            mesa-libGL-devel \
            mesa-libGLU-devel \
            motif \
            mysql-devel \
            openldap-devel \
            openmotif-devel \
            openssl-devel \
            pcre-devel \
            qt5-qtbase-devel \
            redhat-lsb-core \
            xerces-c \
            xerces-c-devel \
    && yum clean all

ADD create-env /tmp/
ADD thisroot.sh /tmp/

RUN cd /tmp && \
    bash create-env /opt/geant4 && \
    rm -f create-env

RUN ldconfig && \
    /opt/geant4/bin/root-config --version && \
    ldd /opt/geant4/lib/libNet.so | tee /tmp/libNet.ldd && \
    ! grep -q "not found" /tmp/libNet.ldd && \
    rm -f /tmp/libNet.ldd

RUN rpm -q compat-openssl10 && \
    ls -l /usr/lib64/libssl.so.10 /usr/lib64/libcrypto.so.10 && \
    /opt/geant4/bin/root-config --version

# build info
RUN echo "Timestamp:" `date --utc` | tee /image-build-info.txt

