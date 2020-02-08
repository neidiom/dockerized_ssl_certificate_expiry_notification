# Docker service for daily SSL expiriy SLACK notifications.

## Setup instructions

Follow the steps below.

### 1. Create the variable file.

* crete the `vars.yml` file from the example one.

````
cp app/vars.yml.example app/vars.yml
````

### 2. Edit the variable file.

Edit the `vars.yml` file and put your Slack webhook and domains.

### 3. Build the container

````
./build.sh
````

That's it.

## Custom ports

To check for certificated on custom ports use the format below.

````
---
ssl_expiry_days_check: 30
slack_webhook: 'https://hooks.slack.com/services/xxxxxx/xxxxx/xxxxxxx'
domains:
- github.com
- gitlab.com
- my-domain-with-custom-port.com:8080
````

## Troubleshoot

Enter the container, check the cron job, manually run the script.

````
sudo docker exec -it ssl_certificate_expiry_check /bin/bash
crontab -l
/bin/bash -l -c 'ruby /srv/app/ssl_check.rb'
````
