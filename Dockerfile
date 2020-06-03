FROM ruby:2.7.1-buster as base
ARG TZ
ENV TZ=${TZ}

FROM base as ff_install_debian_packages
RUN apt-get update && apt-get -y install --allow-downgrades --allow-remove-essential --allow-change-held-packages cron

FROM ff_install_debian_packages as gem_install
COPY ./app/. /srv/app/
WORKDIR /srv/app
RUN gem update --system
RUN gem install bundler
RUN bundle install
RUN whenever -f /srv/app/whenever/config/schedule.rb --update-crontab
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata
CMD ["cron", "-f", "-l", "15"]
