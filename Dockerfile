FROM centos
RUN yum install java-11-openjdk.x86_64 -y
RUN yum install wget -y
RUN yum install sudo -y
RUN sudo wget -O /etc/yum.repos.d/jenkins.repo  https://pkg.jenkins.io/redhat-stable/jenkins.repo
RUN sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

RUN sudo yum install jenkins -y 

RUN sudo curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

RUN sudo chmod +x kubectl
RUN sudo mv kubectl /usr/bin

RUN sudo yum install python3 -y
RUN sudo yum install httpd -y
RUN sudo yum install net-tools -y
RUN sudo yum install php -y
RUN sudo yum install git -y
RUN sudo echo "jenkins 	ALL=(ALL)     NOPASSWD: ALL" >> /etc/sudoers
RUN sudo mkdir .kube/

COPY Alert_mail.py /
COPY ca.crt /root/
COPY client.crt /root/
COPY client.key /root/
COPY config /root/.kube/
COPY deployment/* /root/deployment/
 
EXPOSE 8080
CMD /usr/sbin/httpd -DFOREGROUND 
CMD java -jar /usr/lib/jenkins/jenkins.war
 



