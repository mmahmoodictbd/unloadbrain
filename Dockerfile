FROM ruby:3.2.0

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Set working directory
WORKDIR /usr/src/app

# Copy Gemfile and Gemfile.lock
COPY Gemfile* ./

# Install bundler and gems
RUN gem install bundler && bundle install

# Copy the rest of the application code
COPY . .

# Copy the entrypoint script
COPY entrypoint.sh /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh

# Expose port 4000 for Jekyll server
EXPOSE 4000

# Set the entrypoint
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]

# Default command
CMD ["jekyll", "serve", "--host", "0.0.0.0"]