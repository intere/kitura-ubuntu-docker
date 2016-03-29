##
# Copyright IBM Corporation 2016
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##

# Dockerfile to build a Docker image with all the dependencies to build and run
# the Kitura sample application.

FROM ibmcom/swift-ubuntu:latest
MAINTAINER IBM Swift Engineering at IBM Cloud
LABEL Description="Docker Ubuntu image with the all the dependencies to build and run the Kitura sample app."

# Expose default port for Kitura
EXPOSE 8090

# Variables
ENV HOME /root
ENV WORK_DIR /root
ENV KITURA_BRANCH master

# Linux OS utils and dependencies
RUN apt-get update
RUN apt-get install -y openjdk-7-jdk
RUN apt-get install -y libhttp-parser-dev
RUN apt-get install -y libhiredis-dev
RUN apt-get install -y libcurl4-openssl-dev

# Add utility build files to image
ADD clone_build_kitura.sh /root
ADD start_kitura_sample.sh /root
ADD run_tests_kitura.sh /root
ADD clone_build_test_kitura.sh /root

# Clone and build Kitura and sample app using utility script
RUN /root/clone_build_kitura.sh

USER root
CMD /root/start_kitura_sample.sh
