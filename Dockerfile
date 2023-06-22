FROM ubuntu:20.04
# IMPORTANT FOR MAP DOCKER SOCK
ARG DOCKER_GID=998 
ARG DEBIAN_FRONTEND=noninteractive

# set the github runner version
ARG RUNNER_VERSION="2.298.2"

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y unzip && apt-get install -y zip
# update the base packages and add a non-sudo user

RUN apt-get update -y && apt-get upgrade -y && groupadd -g $DOCKER_GID docker && useradd -m -g docker docker

RUN  apt install apt-transport-https ca-certificates curl software-properties-common -y
RUN  curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  apt-key add -
RUN  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
RUN  apt install docker-ce -y
# install python and the packages the your code depends on along with jq so we can parse JSON
# add additional packages as necessary
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    curl jq build-essential libssl-dev libffi-dev python3 python3-venv python3-dev python3-pip

# cd into the user directory, download and unzip the github actions runner
RUN cd /home/docker && mkdir actions-runner && cd actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz


# install some additional dependencies
RUN DEBIAN_FRONTEND=noninteractive chown -R docker ~docker && /home/docker/actions-runner/bin/installdependencies.sh     

# copy over the start.sh script
COPY start.sh start.sh

RUN ls
RUN chmod +x start.sh

# since the config and run script for actions are not allowed to be run by root,
# set the user to "docker" so all subsequent commands are run as the docker user
USER docker

# set the entrypoint to the start.sh script
ENTRYPOINT ["./start.sh"]
