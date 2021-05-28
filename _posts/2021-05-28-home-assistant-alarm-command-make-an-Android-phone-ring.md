---
layout: post
title: Home Assistant alarm/command to make an Android phone ring
date: 2021-05-28 22:30:00 +0200
excerpt: |
    Door/window sensors triggers night alarm / home away alarm on my Google Home device. I wanted to do something that make my 
    Android phone ring.
categories: [tech]
tags: [home-assistant, home-automation]
---

### Just adding some image to look beautiful
![image](/assets/images/2021-05/My-HA-random-snapshot-2805.png)


### What I wanted to do
- I've door/window sensors triggers night alarm / home away alarm on my Google Home device.
- I wanted to do something that make my Android phone ring.
  - I don't have any smart device in my bedroom other than my phone. Don't want spend money on a smart speaker.
  - When I am away from home, I need to hear the sound if someone breaks in.
  - I do get notifications, but notifications are easy to ignore due to outside noises.
  - I saw people use repeat notification to make audible sound using HA scripts.


### My Solution
- I use HA Companion App.
- HA Companion App does not have such a feature to ring the phone.
- I used **command_volume_level** message (to set the volume to MAX) from notify service.
- I used **command_activity** message (to set Timer to 1 second), after 1 second timer is up and phone start making sound at MAX volume.
- Check my HA automations below.


### HA automation to turn on boolean when I'm away from home and door/window opens
```
- alias: Door Window Opened Alarm
  description: Door Window Opened Alarm
  trigger:
    - type: opened
      platform: device
      device_id: ea25b0acfdbf11ea84d325a74f7ddefa
      entity_id: binary_sensor.main_door_sensor
      domain: binary_sensor
    - type: opened
      platform: device
      device_id: ea261d67fdbf11ea8e8fcb87b433b84d
      entity_id: binary_sensor.back_door_sensor
      domain: binary_sensor
  condition:
    condition: state
    entity_id: input_boolean.home_away
    state: 'on'
  action:
    - service: input_boolean.turn_on
      target:
        entity_id: input_boolean.play_alarm
  mode: single
```


### HA automation to set volume to MAX and Timer set to 1 second, timer makes lots of sound
```
- alias: Turn On Alarm
  description: Turn On Alarm
  trigger:
    - platform: state
      entity_id: input_boolean.play_alarm
      from: 'off'
      to: 'on'
  action:
    - service: notify.mobile_app_moto_g_5s_plus
      data:
        message: "command_volume_level"
        title: 20
        data:
          channel: "alarm_stream"
    - service: notify.mobile_app_moto_g_5s_plus
      data:
        message: command_activity
        data:
          channel: "com.google.android.deskclock"
          tag: "android.intent.action.SET_TIMER"
          group: "android.intent.extra.alarm.SKIP_UI:true,android.intent.extra.alarm.LENGTH:1"
  mode: single
```

<br/>

Live long and prosper! :vulcan_salute:

<br/>
<br/>

### Related Posts
- [How to manage grocery list in Home Assistant]({% post_url 2021-03-07-how-to-manage-grocery-list-in-home-assistant %})
- [Home Assistant in Docker hosts mode with Traefik 2 and Let's Encrypt]({% post_url 2020-12-08-home-assistant-in-docker-hosts-mode-with-traefik2-and-lets-encrypt-working-sample %})
- [Run deCONZ on Kubernetes]({% post_url 2020-01-29-run-deconz-on-kubernates %})