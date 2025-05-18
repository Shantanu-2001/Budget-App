# Dockerfile

FROM ruby:3.1.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y curl gnupg2 \
  && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
  && apt-get install -y nodejs postgresql-client \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install -y yarn \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Add Gemfiles and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Add rest of the application code
COPY . .

# Expose port 3000 for the Rails app
EXPOSE 3000

