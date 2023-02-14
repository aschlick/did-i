# syntax=docker/dockerfile:1
FROM ruby:3.2.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
WORKDIR /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

ENV BINDING=0.0.0.0

# RUN useradd -m rails
# RUN chown rails:rails /app
# RUN chown rails:rails /usr/local/bundle
# USER rails

CMD ["rails", "server"]
