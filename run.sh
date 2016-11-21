
#!/bin/bash
# 该脚本启动一个ansible-api容器，并使用sqlite作为Cerely的broker和backend，建议用于开发测试环境或是小规模环境。

set -e

docker run -d \
    -p 8000:8000 \
    --name="ansible2.0-rest-api" \
    -v /data/ansible/playbooks:/data/ansible/playbooks \
    -v /data/ansible/projects:/data/ansible/projects \
    ansible2.0-rest-api
