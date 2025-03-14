---
layout: post
title: Power consumption optimize Proxmox
date: 2023-10-09
excerpt: |
    Electricity costs a lot, reduce Proxmox power consumption
categories: [tech]
tags: [proxmox, power-consumption-optimize]
---

I am new to Proxmox, even new to running servers. I am documenting this for my own, use it in your own risk.

### My Proxmox Cluster
![image](/assets/images/2023-10/proxmox-cluster.png)

### Turn on/off machine
If machine is not in use, it's better to turn it off. Machine can be turned on using Wake-on-LAN
```
ls -la /dev/disk/by-id
```
```
lrwxrwxrwx 1 root root   9 Jan 14 15:54 wwn-0x5000cca2e1c06dd1 -> ../../sdb
lrwxrwxrwx 1 root root   9 Jan 14 15:54 wwn-0x5000cca2a6ceb623 -> ../../sdc
```

Create zpool:
```
zpool create rpool mirror /dev/disk/by-id/wwn-0x5000cca2e1c06dd1 /dev/disk/by-id/wwn-0x5000cca2a6ceb623
```
```
root@pve:~# zfs list
NAME    USED  AVAIL  REFER  MOUNTPOINT
rpool   420K  14.4T    96K  /rpool
```
```
root@pve:~# zpool status -v
  pool: rpool
 state: ONLINE
config:

	NAME                        STATE     READ WRITE CKSUM
	rpool                       ONLINE       0     0     0
	  mirror-0                  ONLINE       0     0     0
	    wwn-0x5000cca2e1c06dd1  ONLINE       0     0     0
	    wwn-0x5000cca2a6ceb623  ONLINE       0     0     0

errors: No known data errors
```

Set compression zpool:
```
root@pve:~# zfs get compression -r rpool
NAME   PROPERTY     VALUE           SOURCE
rpool  compression  on              default
```
```
root@pve:~# zfs set compression=lz4 rpool
root@pve:~# zfs get compression -r rpool
NAME   PROPERTY     VALUE           SOURCE
rpool  compression  lz4             local
```

Create datasets
```
zfs create rpool/vm-disks
zfs create rpool/iso-backup
zfs create rpool/photos
zfs create rpool/videos
zfs create rpool/shared
```

```agsl
pct set 100 -mp0 /rpool/shared,mp=/shared
```
<br/>

Live long and prosper! :vulcan_salute:
{% include buymeacoffee.html %}

<br/>
<br/>

### Related Posts
- [How to manage grocery list in Home Assistant]({% post_url 2021-03-07-how-to-manage-grocery-list-in-home-assistant %})
- [Home Assistant in Docker hosts mode with Traefik 2 and Let's Encrypt]({% post_url 2020-12-08-home-assistant-in-docker-hosts-mode-with-traefik2-and-lets-encrypt-working-sample %})
- [Run deCONZ on Kubernetes]({% post_url 2020-01-29-run-deconz-on-kubernates %})