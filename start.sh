#!/bin/bash
# export PYTHONOPTIMIZE=1
# export ANSIBLE_HOST_KEY_CHECKING=false
# cd /opt/ansible-rest-api
# nohup celery worker --app=celerytask.celeryapp.app -l info &
# nohup python runserver.py &
# supervisord -c /data/supervisord.conf

ansible_setting() {

    if [ $MONGO_HOST ]
    then
        sed -i "s/127.0.0.1/$MONGO_HOST/g" /opt/ansible-rest-api/app/config.py
    fi

    if [ $MONGO_PORT ]
    then
        sed -i "s/27017/$MONGO_PORT/g" /opt/ansible-rest-api/app/config.py
    fi

    if [ $MONGO_NAME ]
    then
        sed -i "s#^MONGO_NAME.*#MONGO_NAME = \"$MONGO_NAME\"#g" /opt/ansible-rest-api/app/config.py
    fi

    if [ $MONGO_USER ]
    then
        sed -i "s#^MONGO_USER.*#MONGO_USER = \"$MONGO_USER\"#g" /opt/ansible-rest-api/app/config.py
    fi

    if [ $MONGO_PASSWORD ]
    then
        sed -i "s#^MONGO_PASSWORD.*#MONGO_PASSWORD = \"$MONGO_PASSWORD\"#g" /opt/ansible-rest-api/app/config.py
    fi

}

ansible_setting
supervisord -c /etc/supervisord.conf