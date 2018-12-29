## Ansible Playbook

This folder contains all devops scripts of Heurilyze.

> Note: ONLY support CentOS now!

### Environment Setup

Install Python dependencies:

```
$ pip install requirements.txt
```

_MacOS_: install [sshpass](https://stackoverflow.com/questions/32255660/how-to-install-sshpass-on-mac).

```
$ brew install http://git.io/sshpass.rb
```

### How to Prepare a Machine

#### Bootstrap Server

```
$ ansible-playbook bootstrap.yml -b -k -e 'ansible_ssh_user=root' -e 'username=new_create_username' -e 'password=raw_password'
```

This playbook make sure ansible can be run on the server, it install required software, create devops account, synchronize time 
with NTP server, update `firewalld` by configuration, etc.

### Miscs Tasks

#### Create New User

This step creates new user on target machines, it also configure `sudo` file to grant `devops` privilege.

```
$ CLOUD_TO_USE="static" ./prepare_users.sh --extra-vars="username=dding"
```

The following tasks will need the newly created user.

See: [Issues#4622](https://github.com/ansible/ansible/issues/4622) which explains why we need `-e 'ansible_ssh_user=root'` in the command line.

#### Synchronize time

As the newly created user can `sudo` to `root` without password, we can avoid `-K` here.

```
$ ansible-playbook deploy_ntp.yml -b -k
```

### Details

Components module list in `roles`.

#### `check_config_static`

`check_config_static` check `inventory.ini` and make sure there is no old SSH connection.

#### `pre-ansible`

`pre-ansible` is called before any Ansible tasks, it check disk space, Linux distribution, and whether Python is installed on host.
Install Python and NTP if needed.

#### `bootstrap`

`bootstrap` set hostname, and setup `firewalld` using `inventory.ini`, it also install basic binaries e.g. `ntp`, `ntpdate`, etc.

#### `create-user`

`create-user` assumes `username` and `password` is defined, and create new user account, and add the user to `sudoer` file.

#### `sync-time`

`sync-time` synchronize time with NTP Server.

#### `docker-engine`

`docker-engine` remove old docker version, and install docker engine from predefined docker repository. It also
enable docker as a service.
