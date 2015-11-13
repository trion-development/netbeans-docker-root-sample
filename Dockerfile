FROM gcc

MAINTAINER http://www.trion.de/

# Set environment
ENV \
  DEBIAN_FRONTEND=noninteractive \
  TERM=xterm-color

# sets evironment variables for central configuration
# tag::env[]
ENV USER_DIR      /home/user
ENV ROOT_VERSION  v6.04.02
ENV DOWNLOAD_URL  https://root.cern.ch/download/root_${ROOT_VERSION}.source.tar.gz
# end::env[]

ENV RUN_USER            user
ENV RUN_GROUP           user


#Install ssh and ROOT dependencies
RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends \
       xauth openssh-server \
       git \
       dpkg-dev \
       make \
       cmake \
       g++ \
       gcc \
       gdb \
       binutils \
       libx11-dev \
       libxpm-dev \
       libxft-dev \
       libxext-dev \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/


# set password for root user, add user account, add SSH login fix otherwise user is kicked off after login
RUN mkdir /var/run/sshd \
  && useradd -r -u 1000 -m -c "user role account" -d ${USER_DIR} -s /bin/bash user \
  && echo 'user:netbeans' | chpasswd \
  && echo 'root:netbeans' | chpasswd \
  && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
  && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
  && echo "export VISIBLE=now" >> /etc/profile

ENV NOTVISIBLE "in users profile"

WORKDIR /home/user
# Install root using multithreaded build for multiple cores (-j as option for GNU make)
# tag::install[]
RUN mkdir root-cern \
  && echo "download ${DOWNLOAD_URL}" \
  && curl -L --silent "${DOWNLOAD_URL}" | tar -xz --strip=1 -C "${USER_DIR}/root-cern" \
  && cd "${USER_DIR}/root-cern/build" \
  && cmake ../ \
  && cmake --build . -- -j$(($(nproc) + 1)) \
  && cmake --build . --target install \
  && ldconfig
#end::install[]

# Expose port for SSH access
# tag::ssh[]
EXPOSE 22
# end::ssh[]

#declare persistent volume / mountpoint
# tag::volume[]
VOLUME /home/user/data/sample
# end::volume[]

#run ssh daemon
CMD ["/usr/sbin/sshd", "-D"]
