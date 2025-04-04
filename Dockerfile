# syntax = docker/dockerfile:1
ARG RUBY_VERSION=3.2.8
FROM ruby:$RUBY_VERSION-slim
LABEL maintainer="Frank Camp <frank@frankcamp.tech>"
LABEL description="Dockerfile for Apple Survey Application (rails 7.1.2, ruby 3.2.8)"
LABEL version="1.0"

WORKDIR /rails

RUN rm -rf /rails/tmp/pids/server.pid

# Install dependencies
RUN apt-get update -qq && apt-get install --no-install-recommends -y \
    build-essential \
    git \
    curl \
    libsqlite3-dev \
    sqlite3 \
    nodejs \
    yarn \
    jq \
    libvips \
    pkg-config \
    libyaml-dev && \
    rm -rf /var/lib/apt/lists/*


# Install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs=4 --retry=3

# Copy the rest of the code
COPY . .

# Allow local development with editable files
EXPOSE 3000
RUN rm -rf /rails/tmp/pids/server.pid
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
