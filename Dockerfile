FROM centos:7

RUN yum update -y && yum --quiet install -y epel-release
RUN yum --quiet install -y python-pip python-devel gcc make libffi-devel openssl-devel git supervisor

RUN git clone https://github.com/devops/ansible-rest-api.git /opt/ansible-rest-api
RUN pip install -r /opt/ansible-rest-api/requirements-v2.txt

ADD start.sh /start.sh
ADD supervisord.conf /etc/supervisord.conf
RUN chmod u+x /start.sh

RUN mkdir -p /data/ansible/{roles,projects,playbooks} \
        && cp /opt/ansible-rest-api/ansible.cfg /root/.ansible.cfg \
        && ansible-galaxy install -r /opt/ansible-rest-api/requirements.yml -p /data/ansible/roles/

VOLUME ["/data/ansible/roles", "/data/ansible/projects", "/data/ansible/playbooks"]
EXPOSE 8000
CMD ["/start.sh"]
