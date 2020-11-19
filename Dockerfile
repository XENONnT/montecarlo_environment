FROM xenonnt/base-environment:development

RUN yum -y clean all && yum -y --skip-broken upgrade && \
    yum -y install centos-release-scl && \
    yum -y install \
            avahi-compat-libdns_sd-devel \
            cfitsio-devel \
            devtoolset-8 \
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
    && \
    yum clean all

ADD create-env /tmp/
ADD thisroot.sh /tmp/

RUN source scl_source enable devtoolset-8 && \
    cd /tmp && \
    bash create-env /opt/geant4 && \
    rm -f create-env 

# build info
RUN echo "Timestamp:" `date --utc` | tee /image-build-info.txt

