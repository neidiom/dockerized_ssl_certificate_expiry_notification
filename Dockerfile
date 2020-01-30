FROM ruby:2.7.0-buster
RUN apt-get update && apt-get -y install --allow-downgrades --allow-remove-essential --allow-change-held-packages cron
COPY ./app/. /srv/app/
WORKDIR /srv/app
RUN gem update --system
RUN gem install bundler
RUN bundle install
RUN whenever -f /srv/app/whenever/config/schedule.rb --update-crontab
#ENV TZ=America/Los_Angeles
ARG TZ
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo "$TZ" > /etc/timezone
#RUN dpkg-reconfigure -f noninteractive tzdata
CMD ["cron", "-f", "-l", "15"]
