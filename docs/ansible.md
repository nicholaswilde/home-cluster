# Ansible

I use [Ansible] to setup the nodes and deploy K3s to my cluster.

## Inventory

The inventory hosts and variables need to be updated to your environment.

```yaml
# ./server/ansible/inventory/cluster/hosts.yaml
---
all:
  children:
    main:
      hosts:
        turing-main:
          ansible_host: 192.168.1.201
    node:
      hosts:
        worker-02:
          ansible_host: 192.168.1.202
        worker-03:
          ansible_host: 192.168.1.203
...
```

Be sure to set the ansible version and the user name on the nodes to the
`group_vars`.

```yaml
# ./server/ansible/inventory/cluster/group_vars/all.yaml
...
k3s_version: v1.18.16+k3s1
ansible_user: pi
...
```

## Playbooks

All commands below are executed from the `./server/ansible` directory except
for the Task commands.

### Prepare

Prepare the nodes for the K3s installation by changing certain settings
and removing crufty packages.

```shell
ansible-playbook ./playbook/prepare.yaml
```

### Install

Install K3s

```shell
ansible-playbook ./playbook/install.yaml
```

!!! Note
    This only works with Raspberry Pi OS 64-bit.

### Nuke

Uninstall K3s from the cluster.

```shell
ansible-playbook ./playbook/nuke.yaml
```

### Upgrade

Perform an upgrade to the operatring system, not K3s.

```shell
ansible-playbook ./playbook/upgrade.yaml
```

## Other Commands

Other Ansible related commands can be found by running the following from the
root of the repository:

```shell
task -l
```

[Ansible]: https://www.ansible.com/
