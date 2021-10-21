#!/usr/bin/env bash

# Follows same process as https://git.yrzr.tk/docker/gitlab-ce-arm64

# Fetch latest CI_COMMIT_TAG here: https://packages.gitlab.com/gitlab/gitlab-ce/
# Ex: 14.3.3-ce.0
CI_COMMIT_TAG=14.3.3-ce.0

rm -rf omnibus-gitlab

git clone https://gitlab.com/gitlab-org/omnibus-gitlab.git

cd omnibus-gitlab/docker

echo "PACKAGECLOUD_REPO=gitlab-ce" > RELEASE && \
echo "RELEASE_PACKAGE=gitlab-ce" >> RELEASE && \
echo "RELEASE_VERSION=${CI_COMMIT_TAG}"  >> RELEASE && \
echo "DOWNLOAD_URL=https://packages.gitlab.com/gitlab/gitlab-ce/packages/ubuntu/focal/gitlab-ce_${CI_COMMIT_TAG}_arm64.deb/download.deb" >> RELEASE

# ubuntu:focal as base image
sed -i 's/^FROM ubuntu.*/FROM ubuntu\:focal/' Dockerfile

# missing package libatomic1 after version 13
sed -i 's/\-recommends/\-recommends libatomic1/' Dockerfile

# debian has /etc/os-release instead of /etc/lsb-release
sed -i 's/lsb-release/os-release/' assets/setup

docker build -t scm .

cd ../..

echo "Docker build complete: ${CI_COMMIT_TAG}"
