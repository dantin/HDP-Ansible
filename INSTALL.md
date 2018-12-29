## Installation Guide

This Ansible playbook will deploy a Hortonworks cluster (either Hortonworks Data Platform or Hortonworks
DataFlow) using Ambari Blueprint.

All nodes should be already built and accessible via SSH.

### Workstation Setup

Before deploying anything, the build node / workstation from where Ansible will run should be prepared.

This node must be able to connect to the clusters via SSH.

It can even be one of the cluster nodes.

#### CentOS/RHEL 7

1. Install the required packages

```
$ sudo yum -y install epel-release || sudo yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
$ sudo yum -y install gcc gcc-c++ python-virtualenv python-pip python-devel libffi-devel openssl-devel libyaml-devel sshpass git vim-enhanced
```

2. Create and source the Python virtual environment

```
$ virtualenv ~/.venv
$ source ~/.venv/bin/activate
```

3. Install the required Python packages inside the virtualenv

```
$ pip install setuptools --upgrade
$ pip install pip --upgrade
$ pip install ansible
```

4. (Optional) Generate the SSH private key

The build node / workstation will need to login via SSH to the cluster nodes.

To generate a new key, run the following:

```
$ ssh-keygen -q -t rsa -f ~/.ssh/id_rsa
```

### User Prepare

The following playbook create a devops user(`dantin`) on each node of the hadoop cluster.

```
$ CLOUD_TO_USE=static ./prepare_users.sh --extra-vars="username=dantin" -k -e 'ansible_user=root'
```

As the devops user is unavaiable before creation, so you must use the `root`(annotated by `-e 'ansible_user=root'`)

### Software Prepare

#### Download J2SDK

Hadoop and Ambari is based on `Java` related technology, before we go, we need to download J2SDK first.

we do this via:

```
$ CLOUD_TO_USE=static ./local_prepare.sh
```

The downloaded binaries are located on `playbooks/resources/bin`.

#### Upload J2SDK Binary to cluster

```
$ CLOUD_TO_USE=static ./deploy.sh
```

Binaries are uploaded to `$HOME/<deploy_user>/oraclejdk`.

## Install Cluster

### Prepare Nodes

```
$ CLOUD_TO_USE=static ./prepare_nodes.sh
```

### Install Ambari

```
$ CLOUD_TO_USE=static ./install_ambari.sh
```

### Config Ambari

```
$ CLOUD_TO_USE=static ./configure_ambari.sh
```


### Apply Blueprint

```
$ CLOUD_TO_USE=static ./apply_blueprint.sh
```

### Post Install

```
$ CLOUD_TO_USE=static ./post_install.sh
```
