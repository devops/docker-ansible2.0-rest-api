
#!/bin/bash
# 该脚本启动ansible-mongo和ansible-api两个容器，并自动完成数据库的配置，建议用于开发测试环境。
# 如果仅需要启动ansible-api，请使用docker-compose(需要提前配置好mongodb，启用auth并赋予ansible用户dbOwner的权限).

set -e

mongo_setup() {
    docker run --name ansible-mongo -d mongo --auth
    docker exec -it ansible-mongo mongo admin --eval 'db.createUser({ user: "admin", pwd: "ansible", roles: [ { role: "userAdminAnyDatabase", db: "admin" } ] });'
    docker exec -it ansible-mongo mongo ansible -u admin -p ansible --authenticationDatabase admin --eval 'db.createUser({ user: "ansible", pwd: "ansible", roles: [ { role: "dbOwner", db: "ansible" } ] });'

}

mongo_setup

docker run -d \
    -p 8000:8000 \
    --link ansible-mongo:mongo \
    --name="ansible2.0-rest-api" \
    -e MONGO_HOST=mongo \
    -e MONGO_NAME=ansible \
    ansible2.0-rest-api
