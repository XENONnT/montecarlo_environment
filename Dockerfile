FROM opensciencegrid/osgvo-xenon:development

RUN yum -y clean all && yum -y --skip-broken upgrade && \
    yum -y install \
            xerces-c \
            xerces-c-devel \
            qt5-qtbase-devel \
            expat \
            expat-devel \
            libXmu-devel \
            motif \
            openmotif-devel \
    && \
    yum clean all

ADD create-env /tmp/

RUN cd /tmp && \
    bash create-env /opt/geant4 && \
    rm -f create-env 

# build info
RUN echo "Timestamp:" `date --utc` | tee /image-build-info.txt

