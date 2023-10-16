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
crontab -e
```
```
@reboot /usr/sbin/ethtool -s enp2s0 wol g
```

### Tune using powertop
```
crontab -e
```
```
@reboot /usr/sbin/powertop --auto-tune
```

### CPU frequency scaling
Check if CPU frequency scaling is available
```
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
```
If it does, add a cron entry
```
crontab -e
```
```
@reboot echo "powersave" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor >/dev/null 2>&1
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