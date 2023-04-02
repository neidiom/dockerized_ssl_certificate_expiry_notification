# Docker service for daily SSL expiriy SLACK notifications.

## Setup instructions

Follow the steps below.

### 1. Build the configuration files.

````
./build.sh
````

### 2. Edit the configuration files.

* Edit the `vars.yml` file and put your Slack webhook and domains.
* Edit the `.env` file and set your timezone.

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

# Docker related

````
BUILDKIT_PROGRESS=plain docker compose build
````
