FROM xenonnt/base-environment:2023.09.1

RUN yum -y clean all && yum -y --skip-broken upgrade && \
    yum -y install \
            avahi-compat-libdns_sd-devel \
            cfitsio-devel \
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
            libXdmcp \
            libXdmcp-devel \
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
    && \
    yum clean all

ADD create-env /tmp/
ADD thisroot.sh /tmp/

RUN cd /tmp && \
    bash create-env /opt/geant4 && \
    rm -f create-env 

# build info
RUN echo "Timestamp:" `date --utc` | tee /image-build-info.txt

