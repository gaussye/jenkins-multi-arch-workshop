#!/bin/bash

cat /root/.ecr/cache.json
repos=$(jq .Registries /root/.ecr/cache.json | jq -r 'keys[]')

mkdir /root/.docker
cat <<EOF > /root/.docker/config.json
{
    "auths": {
EOF

for repoid in $repos
do
AuthorizationToken=$(jq --arg repoid $repoid '.Registries[$repoid].AuthorizationToken' /root/.ecr/cache.json)
ProxyEndpoint=$(jq --arg repoid $repoid '.Registries[$repoid].ProxyEndpoint' /root/.ecr/cache.json)
echo "      $ProxyEndpoint: {"
echo "        \"auth\": $AuthorizationToken"
echo "       },"
done | tee -a /root/.docker/config.json

sed -i '$ s/,$//' /root/.docker/config.json

cat <<EOF >> /root/.docker/config.json
  }
}
EOF

echo "----------------------------"
cat /root/.docker/config.json