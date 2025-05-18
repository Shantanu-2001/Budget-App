# Use Ruby 3.1.2 to match the Gemfile
FROM ruby:3.1.2

# Install essential packages
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  yarn \
  postgresql-client

# Set working directory inside the container
WORKDIR /app

# Install dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy entire app into the container
COPY . .

# Precompile assets (optional - for production builds)
# RUN bundle exec rake assets:precompile

# Expose port (optional - usually done in docker-compose.yml)
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
