FROM elixir:latest

WORKDIR /app

RUN apt-get update -y && \
  curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
  apt-get install -y nodejs inotify-tools

RUN mix local.hex --force && \
  mix local.rebar --force && \
  mix archive.install hex phx_new 1.5.1 --force

COPY mix.exs mix.exs
COPY mix.lock mix.lock
RUN mix deps.get && mix deps.compile

COPY . .
