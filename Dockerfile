# Base docker image
FROM debian:jessie
MAINTAINER François Billant <fbillant@gmail.com>

RUN sed -i.bak 's/jessie main/jessie main contrib non-free/g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
tmux \
git \
vim-nox \
wget

RUN cd /root && \
git clone --recursive https://github.com/FrancoisBillant/dotfiles.git && \
cp -r /root/dotfiles/. /root && \
rm -Rf /root/scripts && \
rm -Rf /root/dotfiles && \
rm -f /root/README.md

# Install Oracle JDK
RUN cd /opt && \
mkdir /opt/jdk && \
cd /opt/jdk && \
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u73-b02/jdk-8u73-linux-x64.tar.gz && \
tar -xvzf jdk-*

RUN update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_73/bin/java 100 && \
update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_73/bin/javac 100 && \
java -version

# Install eclipse
RUN apt-get update && apt-get install -y \
libswt-gtk-3-jni \
libswt-gtk-3-java

RUN cd /opt && \
wget 'https://eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/mars/1/eclipse-java-mars-1-linux-gtk-x86_64.tar.gz&r=1' && \
tar -xvzf download* && \
rm download*

RUN ln -s /opt/eclipse/eclipse /usr/local/bin/eclipse 

CMD ["/usr/local/bin/eclipse"]
