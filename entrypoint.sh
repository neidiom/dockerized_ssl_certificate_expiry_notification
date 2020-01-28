#!/bin/sh

## Do whatever you need with env vars here ...
/etc/init.d/cron start

# Hand off to the CMD
exec "$@"
