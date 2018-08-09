FROM ruby:2.5-stretch

MAINTAINER Ryan Moore <moorer@udel.edu>

# Update package manager
RUN apt-get update
RUN apt-get upgrade -y

# Has stuff like gcc, make, and libc6-dev
RUN apt-get install -y build-essential

# Valgrind!
RUN apt-get install -y valgrind

RUN gem install ceedling

WORKDIR /home

# Run it as if it were valgrind
ENTRYPOINT ["/bin/bash"]
