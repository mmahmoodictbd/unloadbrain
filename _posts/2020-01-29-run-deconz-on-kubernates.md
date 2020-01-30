---
layout: post
title: Run deCONZ on Kubernetes
date: 2020-01-29 18:00:00 +0100
excerpt: |
    Running deCONZ application for ConBee II gateway on can be a challenge. Check out how I did it.
categories: [tech]
tags: [iot, deconz, zigbee-gateway, kubernetes]
---

The deCONZ application is a tool to configure, control and monitor Zigbee networks with the ConBee II. I have couple
 of Zigbee sensors that uses ConBee II as their gateway and I like kubernetes to manage my apps.
 
Here is the all-in-one.yaml for deCONZ. I have single node kubernetes cluster that runs on an old laptop, usage local
 storage of the node in /data/deconz directory.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: deconz-service
  labels:
    appName: deconz
spec:
  type: ClusterIP
  selector:
    app: deconz
  ports:
    - port: 8124
      targetPort: 8124

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: deconz-deployment
  labels:
    appName: deconz
spec:
  replicas: 1
  selector:
    matchLabels:
      app: deconz
  template:
    metadata:
      labels:
        app: deconz
    spec:
      containers:
        - name: deconz
          image: marthoc/deconz:latest
          ports:
            - containerPort: 8124
          env:
            - name: DECONZ_WEB_PORT
              value: "8124"
            - name: DECONZ_WS_PORT
              value: "4443"
            - name: DECONZ_VNC_PORT
              value: "5930"
            - name: DECONZ_VNC_PASSWORD
              value: "2P&Ns5hjdFiS"
            - name: DECONZ_VNC_MODE
              value: "1"
            - name: DECONZ_UPNP
              value: "0"
            - name: DECONZ_DEVICE
              value: "/dev/ttyACM0"
            - name: DEBUG_INFO
              value: "1"
            - name: DEBUG_APS
              value: "1"
            - name: DEBUG_ZCL
              value: "1"
            - name: DEBUG_ZDP
              value: "1"
            - name: DEBUG_OTAU
              value: "1"
            - name: TZ
              value: "Europe/Amsterdam"
          securityContext:
            privileged: true
          volumeMounts:
            - name: deconz-vol
              mountPath: /root/.local/share/dresden-elektronik/deCONZ
            - name: ttyacm
              mountPath: /dev/ttyACM0
      volumes:
        - name: deconz-vol
          persistentVolumeClaim:
            claimName: deconz-pvc
        - name: ttyacm
          hostPath:
            path: /dev/ttyACM0
---

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: deconz-pvc
  labels:
    appName: deconz
spec:
  storageClassName: deconz-storage
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10M

---

apiVersion: v1
kind: PersistentVolume
metadata:
  name: deconz-pv
  labels:
    appName: deconz
spec:
  storageClassName: deconz-storage
  capacity:
    storage: 10M
  accessModes:
    - ReadWriteOnce
  local:
    path: /data/deconz
  persistentVolumeReclaimPolicy: Retain
  nodeAffinity:
    required:
      nodeSelectorTerms:
        - matchExpressions:
            - key: kubernetes.io/hostname
              operator: In
              values: # Put your node names here and delete mine.
                - minikube
                - vostro-ubuntu

```