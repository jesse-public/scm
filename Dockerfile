FROM 'debian'

RUN apt update && \
  apt upgrade -y && \
  apt install -y curl openssh-server ca-certificates perl

COPY ./add-repo.sh /add-repo.sh

RUN /add-repo.sh

ENV EXTERNAL_URL "$EXTERNAL_URL"

RUN echo "EXTERNAL_URL is set to: $EXTERNAL_URL"
RUN apt install gitlab-ce

# Initial password stored in /etc/gitlab/initial_root_password

ENTRYPOINT ["tail"]
CMD ["-f","/dev/null"]
