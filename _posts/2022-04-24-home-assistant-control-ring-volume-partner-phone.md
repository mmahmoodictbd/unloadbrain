---
layout: post
title: Home Assistant control the ring volume of your partner's phone
date: 2022-04-24
excerpt: |
    Wife / husband / partner not picking up phone? Here is the HA way to control ring volume.
categories: [tech]
tags: [home-assistant, home-automation]
---

### HA dashboard buttons
![image](/assets/images/2022-04/HA-ring-volume-control-24042022.png)


### What I wanted to do
When I go to the store to do the grocery, I need to ask something to my wife, and she is not pick up the 
phone because she is in the garden and ring sound is not reaching her.
**This is an example use case. Please understand the gravity of this feature and implement this feature 
with your partner's consent and based on mutual agreement.**


### Example usecase
- Emergency button
- Find your phone feature


### My Solution
- My wife and I both use HA Companion App.
- Create a button on the HA dashboard and call the script.
- Once HA script set ring volume to 100%, make a normal call.

![image](/assets/images/2022-04/Yoda-says-Power-comes-with-responsibility.jpeg)


### HA dashboard button to call script
```
- type: button
  name: Nishi Phone volume to 100
  show_state: false
  icon: hass:volume-high
  tap_action:
    action: call-service
    service: script.nishi_phone_volume_100
```

### HA script
```
nishi_phone_volume_100:
  alias: Set Nishi Phone volume to 100
  sequence:
  - service: notify.mobile_app_pixel_4_xl
    data:
      message: "command_ringer_mode"
      title: "normal"
  - service: notify.mobile_app_pixel_4_xl
    data:
      message: "command_volume_level"
      title: 10
      data:
        channel: "ring_stream"
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