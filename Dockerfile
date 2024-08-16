FROM centos:centos7
RUN sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo && \
    sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo && \
    sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo && \
    yum -y install gcc make && \
    curl -LO https://github.com/fujita/tgt/archive/v$(curl -s https://api.github.com/repos/fujita/tgt/tags | grep '"name":' | awk -F '"' '{print $4}' | sort -Vr | head -n 1 | sed 's/^v//').tar.gz && \
    tar xfz v$(curl -s https://api.github.com/repos/fujita/tgt/tags | grep '"name":' | awk -F '"' '{print $4}' | sort -Vr | head -n 1 | sed 's/^v//').tar.gz && \
    cd tgt-$(curl -s https://api.github.com/repos/fujita/tgt/tags | grep '"name":' | awk -F '"' '{print $4}' | sort -Vr | head -n 1 | sed 's/^v//') && \
    make install-programs install-scripts && \
    cd - && \
    rm -rf v$(curl -s https://api.github.com/repos/fujita/tgt/tags | grep '"name":' | awk -F '"' '{print $4}' | sort -Vr | head -n 1 | sed 's/^v//').tar.gz v$(curl -s https://api.github.com/repos/fujita/tgt/tags | grep '"name":' | awk -F '"' '{print $4}' | sort -Vr | head -n 1 | sed 's/^v//') && \
    yum remove -y $(awk '/Installed/{print $NF;}' /var/log/yum.log) && \
    yum -y install libiscsi libiscsi-utils && \
    yum clean all
WORKDIR /
COPY ./start.sh .
RUN chmod +x start.sh
EXPOSE 3260
CMD ["/bin/bash","-c","/start.sh"]
