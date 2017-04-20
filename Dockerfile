FROM ruby:2.3.0

RUN apt update && apt install -y build-essential libmysqlclient-dev nodejs

ENV APP_PATH /var/www/lotus

RUN mkdir -p $APP_PATH

WORKDIR $APP_PATH

COPY Gemfile Gemfile.lock ./

RUN bundle install --without development test

COPY . ./

EXPOSE 3000

RUN RAILS_ENV=production bundle exec rake assets:precompile

CMD ["bundle", "exec", 'puma', "-C", "config/puma.rb"]
