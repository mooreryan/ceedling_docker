FROM ruby:2.5-stretch

MAINTAINER Ryan Moore <moorer@udel.edu>

# Update package manager
RUN apt-get update
RUN apt-get upgrade -y

# Build essential has stuff like gcc, make, and libc6-dev
RUN apt-get install -y build-essential
RUN apt-get install -y valgrind
RUN apt-get install -y cmake

RUN gem install ceedling

WORKDIR /home

ENTRYPOINT ["/bin/bash"]
