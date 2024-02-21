#!/bin/bash 
      apt-get update -y
      apt-get install awscli -y
      apt-get install jq -y
      apt-get install htop -y
      apt-get install ca-certificates curl gnupg -y
      install -m 0755 -d /etc/apt/keyrings
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
      chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update -y

    apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

    docker run hello-world

    apt-get install docker-compose-plugin -y
    docker compose version

    aws secretsmanager get-secret-value --secret-id "${secret_id}" --region eu-north-1 --query SecretString --output text > /var/log/secret_test.env

    chmod 600 /var/log/secret_test.env