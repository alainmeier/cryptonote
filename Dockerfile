FROM alpine:3.5

ENV RAILS_ENV="docker" \
    RACK_ENV="docker" \
    BUNDLE_SILENCE_ROOT_WARNING=1

RUN mkdir /app
WORKDIR /app
ADD . /app

RUN apk update && \
    apk upgrade && \
    apk --no-cache add --update --virtual .build \
        build-base \
        libressl-dev \
        libffi-dev \
        libxml2-dev \
        libxslt-dev \
        ruby-dev && \
    apk --no-cache add --update \
        ca-certificates \
        libressl \
        nodejs \
        ruby \
        ruby-bigdecimal \
        ruby-bundler \
        ruby-json \
        sqlite-dev \
        tzdata && \
    bundle install --clean --deployment --without production && \
    bundle exec rake db:drop && \
    bundle exec rake db:migrate && \
    bundle exec rake assets:precompile && \
    bundle exec rake assets:clean && \
    apk del --purge .build && \
    rm -rf /usr/share/doc/* \
        /var/cache/apk \
        /var/lib/{apt,dpkg,cache,log}/* \
        /root/.bundle/* \
        /root/.gem/* \
        /usr/lib/node_modules/npm/node_modules/ \
        /app/vendor/bundle/ruby/*/cache

CMD bundle exec rails server -b 0.0.0.0 -p 3000
EXPOSE 3000