# GitLab-CICD (Laravel-Todo)

##### 1.Create gitlab account <br>
##### 2.Create gitlab repo `laravel todo` <br>
##### 3.Create project > Import project > Repository form url > form https://github.com/devktops/laravel-todo/ <br>
![alt text](<source/Screenshot 2024-10-16 at 1.17.37 PM.png>)

##### 4.Create EC2 Instance and Install dependencies


```bash
#!/bin/bash

sudo apt update
sudo apt install nginx
sudo apt -y install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install -y php8.3
sudo apt install -y php8.3-fpm php8.3-cli php8.3-common php8.3-mbstring php8.3-gd php8.3-intl php8.3-xml php8.3-mysql php8.3-zip php8.3-bcmath php8.3-soap php8.3-redis php8.3-curl php8.3-imagick php8.3-xmlrpc php8.3-xsl
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install nodejs -y
sudo apt install mysql-server
```
```bash
sudo mysql_secure_installation 
```
```bash
sudo mysql
CREATE USER 'laravel'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
CREATE DATABASE laravel;
GRANT ALL PRIVILEGES ON laravel.* TO 'laravel'@'localhost';
FLUSH PRIVILEGES;
exit
```

##### 5.Gitlab pull from server <br>
###### 5.1 Create gitlab access with token
`Project > Settings > Access tokens > Add new token`
![alt text](<source/Screenshot 2024-10-16 at 4.32.33 PM.png>)

![alt text](<source/Screenshot 2024-10-16 at 4.46.19 PM.png>)

###### 5.2 Git clone

```bash
sudo usermod -aG www-data ubuntu
sudo chown -R ubuntu:www-data /var/www/
cd /var/www
git clone https://token-name:token-access-key@gitlab.com/pyonecho86/laravel-todo.git
cd laravel-todo/
composer install
npm install
npm run build
cp .env.example .env
vim .env
php artisan key:generate
php artisan db           //for test db
sudo chown -R ubuntu:www-data /var/www/

```
###### Git clone form

```bash
git clone https://username:password@gitlab.com/...
git clone https://token-name:access-key@gitlab.com/...
```

#### 6.Nginx Config deploy<br>

```bash
sudo apt install nginx -y
sudo mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.old
sudo vi /etc/nginx/sites-available/default
---                                                                                                                                    11,24         All
server {
    listen 80;
    listen [::]:80;
    server_name kpcio.site;
    root /var/www/laravel-todo/public;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-Content-Type-Options "nosniff";

    error_log /var/log/nginx/kpcio-error.log;
    access_log /var/log/nginx/kpcio-access.log;

    index index.php;

    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    error_page 404 /index.php;

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.3-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
        fastcgi_hide_header X-Powered-By;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}
---
sudo nginx -t
sudo systemctl restart nginx
sudo systemctl status nginx
```

call domain
![alt text](source/917bf6f0-87f9-48f4-9e9d-15531762866f.png)


#### 7.Git clone to local and add cicd file <br>

```bash
ssh-add your-github-ssh-key
git clone git@gitlab.com:pyonecho86/laravel-todo.git
cd laravel-todo
vi .gitlab-ci.yml
---
image: php:8.3-alpine

stages:
  - build
  - test
  - deploy

variables:
  SSH_USER: 'ubuntu'
  APP_DIR: '/var/www/wd-laravel'
  
  # PROD_SERVER: '192.168.1.1'
  # SSH_PRIVATE_KEY: '-----BEGIN'

before_script:
  - echo "Running before script..."

build-prod:
  stage: build
  when: manual
  only:
    - master
  script:
    - echo "Building the application..."
    - curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
    # - composer install --no-dev --optimize-autoloader
    - composer install
    - apk add --no-cache nodejs npm
    - npm install
    - npm run build
  artifacts:
    paths:
      - vendor
      - node_modules
      - public

test-prod:
  stage: test
  needs: 
    - job: build-prod
      artifacts: true
  when: on_success
  only:
    - master
  script:
    - echo "Running tests..."
    - cp .env.example .env
    - php artisan key:generate
    - sed -i 's/DB_CONNECTION=mysql/DB_CONNECTION=sqlite/' .env
    - php artisan migrate --force
    - php artisan db:seed --force
    - php artisan test

deploy-prod:
  image: alpine:latest
  stage: deploy
  needs: 
    - job: build-prod
      artifacts: true
    - job: test-prod
  when: manual
  only:
    - master
  script:
    - echo "Configuring SSH..."
    - apk add --no-cache openssh-client
    - mkdir -p ~/.ssh
    - echo "$SSH_PRIVATE_KEY" | tr -d '\r' > ~/.ssh/id_ed25519
    - chmod 600 ~/.ssh/id_ed25519
    - '[[ -f /.dockerenv ]] && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config'
    - echo "Deploying the application..."
    - ssh $SSH_USER@$PROD_SERVER "cd $APP_DIR && php artisan down"
    - ssh $SSH_USER@$PROD_SERVER "cd $APP_DIR && git pull origin master"
    - ssh $SSH_USER@$PROD_SERVER "cd $APP_DIR && composer install --no-dev --optimize-autoloader"
    - ssh $SSH_USER@$PROD_SERVER "cd $APP_DIR && php artisan optimize:clear"
    - ssh $SSH_USER@$PROD_SERVER "cd $APP_DIR && npm install"
    - ssh $SSH_USER@$PROD_SERVER "cd $APP_DIR && npm run build"
    - ssh $SSH_USER@$PROD_SERVER "cd $APP_DIR && php artisan migrate --force"
    - ssh $SSH_USER@$PROD_SERVER "cd $APP_DIR && php artisan up"
    - ssh $SSH_USER@$PROD_SERVER "cd $APP_DIR && php artisan optimize"
    - ssh $SSH_USER@$PROD_SERVER "cd $APP_DIR && php artisan event:cache"
    - echo "Application deployed successfully!"
---
git add .gitlab-ci.yml
git config --local user.email "pyonecho86@gmail.com" 
git config --local user.name "Pyone Cho"
git commit -m "upload gitlab ci file"
git push -u origin master

git rm -fr tests/Feature/Auth/
git rm -fr tests/Feature/ProfileTest.php
git commit -m "delete incomplete test file"
git push
```

#### 8.Put Server SSH Key to git lab

Your_repo > Settings > CI/CD > Variables >
![alt text](<source/Screenshot 2024-10-18 at 12.31.11 AM.png>)

#### 9. Run CI/CD
Your_repo > Build > Pipelines
![alt text](<source/Screenshot 2024-10-18 at 12.49.14 AM.png>)





