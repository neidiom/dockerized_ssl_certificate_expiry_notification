FROM ruby:2.7.0-buster
RUN apt-get update && apt-get -y install --force-yes cron
COPY ./app/. /srv/app/
WORKDIR /srv/app
RUN bundle exec gem update --system
RUN bundle exec gem install whenever
RUN bundle exec gem install slack-notifier
RUN bundle exec gem install ssl_expiry
RUN whenever -f /srv/app/whenever/config/schedule.rb --update-crontab
CMD ["cron", "-f"]
