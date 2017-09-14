FROM ruby:2.2.3
MAINTAINER gavin.deschutter@mac.com

RUN apt-get update && \
    apt-get install -y net-tools

CMD ["/bin/bash"]

# Install gems
ENV APP_HOME /citygram-sacramento-api
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN bundle install

# Upload source
COPY . $APP_HOME

# Start server
ENV PORT 1850
EXPOSE 1850
CMD ["ruby", "app.rb"]
