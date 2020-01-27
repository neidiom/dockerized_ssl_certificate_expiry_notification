# Docker service for daily SSL expiriy SLACK notifications.

## Setup instructions

Follow the steps below.

### 1. Create the variable file.

* crete the `vars.yml` file from the example one.

````
cp app/vars.yml.example app/vars.yml
````
### 1. Edit the variable file.

Edit the `vars.yml` file and put your Slack webhook and domains.

### 3. Build the container

````
./build.sh
````

That's it.
