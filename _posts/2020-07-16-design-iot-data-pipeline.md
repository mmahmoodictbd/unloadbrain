---
layout: post
title: Design of an IoT Data pipeline.
date: 2020-07-15 18:02:00 +0100
excerpt: |
    Recently I worked on an assignment project where I tried to design an IoT data pipeline. Checkout the design and code.
categories: [tech]
tags: [java, iot, data-pipeline]
---

### Don't tell me what to do :angry:
![image](/assets/images/2020-07/dont-tell-me-what-to-do.gif)

<br/>

### The requirements
- Small low-powered IoT devices going to send measurement data.
- Scalable data flow and processing, something that handles backpressure.

### Design Decisions
- Accepting MQTT message from the IoT devices because making HTTP request would lead to higher power consumption for a low-powered IoT device.
- I could've picked OPC UA or some other protocol. However, the idea is to fire events from Message Broker (mosquitto) to Kafka.
- Kafka is the perfect choice because of high throughput, scaling, availability, storage, buffering and reprocessing of events.
- Picked InfluxDB because it's time series database. Could've used Prometheus.

### Data Flow
![image](/assets/images/2020-07/iot-data-pipeline-sequesnce-diagram.png)

### How to display data
- APIs can be built to fetch data from InfluxDB.
- Grafana dashboard can be built on top of InfluxDB data.

![image](/assets/images/2020-07/iot-data-pipeline-query-sequesnce-diagram.png)

### Stop talking and show me the code
:octocat: [Checkout the code on Github](https://github.com/mmahmoodictbd/iot-hub).

<br/>

Live long and prosper! :vulcan_salute: