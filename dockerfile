FROM ruby:3.2

RUN apt-get update -y && \
    apt-get install -y \
    build-essential \
    nodejs \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

RUN gem install bundler && \
bundle install

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]