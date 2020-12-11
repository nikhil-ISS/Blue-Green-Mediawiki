#! /bin/bash
sudo apt-get update
sudo apt-get -y install docker.io
sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker sed -i '$acomplete -F _docker docker' 
/etc/bash_completion.d/docker.io
update-rc.d docker.io defaults
docker pull nginx
docker run -d -p 80:80 --name nginx nginx