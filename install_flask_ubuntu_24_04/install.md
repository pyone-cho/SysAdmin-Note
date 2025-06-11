# Install Flask in ubuntu 24.04 LTS
## Set Up the Flask Project Environment
1. Update repo and upgrade
```
apt update && apt upgrade -y
```

2. Create New User<br>
    2.1 copy Create_user.sh to server<br>
    2.2 change exe
    ```
    # chmod +x Create_user.sh
    ```
    2.3 Create User
    ```
    # ./Create_user.sh      \\ username = linuxuser
    ```
    2.4 Add ssh_key<br>
    ```
    # su - linuxuser
    mkdir .ssh && chmod 700 .ssh && touch .ssh/authorized_keys && chmod 600 .ssh/authorized_keys && vim .ssh/authorized_keys
    ```
    copy and paste your ssh_public_key<br>

3. View the installed python version<br>
`$ python3 --version`

4. Install python3-pip<br>
`$ sudo apt install python3-pip`<br>
`$ pip --version`<br>

5. Install the venv Python virtual environment module.<br>
`$ sudo apt install python3-venv -y`

6. Create a new directory for your Flask project and switch to it.<br>
`$ mkdir flask_project`<br>
`$ cd flask_project`

7. Create a new flaskenv virtual environment <br>
`$ python3 -m venv flaskenv`<br>
Note: The above python3 -m venv flaskenv command creates a new isolated flaskenv environment to install and manage Python packages on the server.

8. Activate the flaskenv virtual environment.<br>
`$ source flaskenv/bin/activate`<br>

9. Verify that your shell prompt changes to the flaskenv virtual environment.<br>
`(flaskenv) example_user@server_namme:/flask_project$`<br>

## Install Flask on Ubuntu 24.04
Follow the steps below to install Flask in the active flaskenv virtual environment on your server.

1. Install Flask using Pip.<br>
`(flaskenv) example_user@server_namme:/flask_project$ pip install flask`

link : [How to Install Flask on Ubuntu 24.04](https://docs.vultr.com/how-to-install-flask-on-ubuntu-24-04)