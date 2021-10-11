version: '3'

web:
  image: 'gitlab/gitlab-ce:latest'
  restart: always
  hostname: 'version-control.home'
  environment:
    GITLAB_OMNIBUS_CONFIG: |
      external_url 'https://version-control.home'
      # Add any other gitlab.rb configuration here, each on its own line
  ports:
    - '80:80'
    - '443:443'
    - '22:22'
  volumes:
    - './config:/etc/gitlab'
    - './logs:/var/log/gitlab'
    - './data:/var/opt/gitlab'