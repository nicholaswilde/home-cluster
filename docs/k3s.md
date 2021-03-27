# K3S

My cluster runs the [K3S] version of kubernetes due to its lightness in
weight.

## :passenger_ship:&nbsp; Deployment

I'm currently using the [k3s-ansible] repo to deploy K3S on my cluster.

My plan is eventually create my own ansible playbook and save it in this repo.

After making a copy of the inventory directory, be sure to change the values in
`group_vars/all.yaml` file.

The easiest way to see the latest `k3s_version` is to browse the
[k3s upgrade channels].

```yaml
# group_vars/all.yml
---
k3s_version: v1.17.5+k3s1
ansible_user: pi
```

I also add the following `extra_server_args` to ensure that pods don't bog down
my master.

```yaml
# group_vars/all.yml
---
extra_server_args: "--node-taint CriticalAddonsOnly=true:NoExecute"
```

Update the `hosts.ini` file with the ip addresses of your nodes.

Deploy k3s:

```shell
ansible-playbook site.yml
```

## :leftwards_arrow_with_hook:&nbsp; Reset

The cluster may be reset by running the `reset.yml` file.

```shell
ansible-playbook reset.yml
```

[K3S]: https://k3s.io/
[k3s-ansible]: https://github.com/k3s-io/k3s-ansible
[k3s upgrade channels]: https://update.k3s.io/v1-release/channels
