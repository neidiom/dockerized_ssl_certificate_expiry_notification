FROM ruby:2.7.8-buster as base
ARG TZ
ENV TZ=${TZ}

FROM base as install_packages
RUN apt-get update && apt-get -y install --allow-downgrades --allow-remove-essential --allow-change-held-packages cron
RUN gem update --system && gem install bundler

FROM install_packages as gem_install

ENV BUNDLE_CACHE /usr/src/cache

WORKDIR /srv/app

COPY ./Gemfile .

RUN bundle config set --local path $BUNDLE_CACHE && \
    bundle check || bundle install && bundle lock && \
    bundle cache && gem clean

RUN find $BUNDLE_CACHE -type f -name "*.gem"

FROM gem_install as app
RUN  bundle config list

# Keep BUNDLE_CACHE directory preserved between builds
RUN --mount=type=cache,target=$BUNDLE_CACHE

COPY . .

RUN find $BUNDLE_CACHE -type f -name "*.gem"
RUN bundle config set --local path $BUNDLE_CACHE && \
    bundle install --local

RUN bundle exec whenever -f /srv/app/whenever/config/schedule.rb --update-crontab
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata
CMD ["cron", "-f", "-l", "15"]
