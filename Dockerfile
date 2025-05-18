FROM ruby:3.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn

# Set working directory
WORKDIR /app

# Copy Gemfiles
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy app source
COPY . .

# Precompile assets and setup
RUN bundle exec rake assets:precompile

# Expose port
EXPOSE 3000

# Start the app
CMD ["rails", "server", "-b", "0.0.0.0"]
