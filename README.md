## dock_project/


### ubuntu_apache2/
        apache2/
            sites-available/
                000-default.conf
                default-ssl.conf
            envvars
            ports.conf
        Dockerfile



   ### ubuntu_nginx/
        nginx/
            sites-available/
                    default
            nginx.conf
        Dockerfile


### ubuntu_nginx_loadbalancer/
                    nginx/
                        sites-available/
                                default
                                loadbalancer
                        nginx.conf
                    Dockerfile


### yaml 코드
docker-compose.yaml