# Use Ruby 3.1.2 to match the Gemfile
FROM ruby:3.1.2

# Install Node.js (latest LTS), Yarn, and PostgreSQL client
RUN apt-get update -qq && apt-get install -y curl gnupg2 \
  && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
  && apt-get install -y nodejs postgresql-client \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install -y yarn \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory inside the container
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the app
COPY . .

# Optional: precompile assets (uncomment for production builds)
# RUN bundle exec rake assets:precompile

# Optional: skip development and test gems in production (uncomment for production)
# RUN bundle config set without 'development test' && bundle install --deployment

# Expose Rails default port
EXPOSE 3000

# Entrypoint for running commands, allows easier extension
ENTRYPOINT ["rails"]

# Default command to start the server binding to all interfaces
CMD ["server", "-b", "0.0.0.0"]

