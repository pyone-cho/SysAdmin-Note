#Docker pull form docker hub 
docker pull ubuntu/apache2:2.4-20.04_beta

#docker run
docker run -d --rm --name cont_apache2 -e TZ=UTC -p 8080:80 ubuntu/apache2:2.4-20.04_beta

#Show debug log
docker logs -f cont_apache2

#To get interactive Shell
docker exec -it cont_apache2 /bin/bash

Link: https://hub.docker.com/r/ubuntu/apache2

