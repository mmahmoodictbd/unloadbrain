---
layout: post
title: Attach Java agent in Java apps deployed in Kubernetes
date: 2020-02-27 23:23:00 +0100
excerpt: |
    I needed to attach Java agent to my Java process to find security vulnerabilities. App is running in k8s and this is how I did it.
categories: [tech]
tags: [java, java-agent, kubernetes, contrast-security]
---

Contrast security provide Dynamic Application Security Testing (DAST) tooling to find security vulnerabilities. They provided a Java agent that needed to be attached with my Java application.

My Java application is running in kubernetes and this is how I did it.
- Added Java agent in a docker image.
- Copy the agent to persistent volume using `initContainers`.
- My Java app has the same persistent volume.
- Attach Java agent from that path.


Checkout this [Github repo](https://github.com/mmahmoodictbd/contrast-security-poc).

**Dockerfile-contrast-agent**
```
FROM alpine:latest
RUN mkdir /usr/agent
COPY ./contrast-resource/contrast.jar /usr/agent
```

**Application Dockerfile**
```
FROM adoptopenjdk/openjdk11-openj9:alpine-jre
VOLUME /tmp
ARG JAR_FILE
COPY ${JAR_FILE} /app.jar
CMD ["java", "-jar", "/app.jar"]
```

**k8s all-in-one yaml**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: pocapp-service
  labels:
    appName: pocapp
spec:
  type: NodePort
  selector:
    app: pocapp
  ports:
    - nodePort: 30080
      port: 8080
      targetPort: 8080

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: pocapp-deployment
  labels:
    appName: pocapp
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pocapp
  template:
    metadata:
      labels:
        app: pocapp
    spec:
      initContainers:
        - name: contrast-java-agent
          image: mmahmood/contrast-agent:latest
          imagePullPolicy: Always
          volumeMounts:
          - mountPath: /contrast/agent
            name: contrast-agent
          command: ['cp', '-v', '/usr/agent/contrast.jar', '/contrast/agent']
      containers:
        - name: pocapp
          image: mmahmood/contrast-security-poc:latest
          imagePullPolicy: Always
          ports:
            - containerPort: 8080
          env:
          - name: JAVA_TOOL_OPTIONS
            value: -javaagent:/contrast/agent/contrast.jar -Dcontrast.application.name=contrast-security-poc -Dcontrast.rootapp=contrast-security-poc
          - name: contrast.standalone.appname
            value: contrast-security-poc
          volumeMounts:
          - name: contrast-agent
            mountPath: /contrast/agent
          - name: contrast-security-yaml-file
            mountPath: /etc/contrast/java
      volumes:
      - name: contrast-agent
        emptyDir: {}
      - name: contrast-security-yaml-file
        configMap:
          name: contrast-security-yaml-configmap
---

apiVersion: v1
kind: ConfigMap
metadata:
  name: contrast-security-yaml-configmap
data:
  contrast_security.yaml: |
    api:
      url: https://ce.contrastsecurity.com/Contrast
      api_key: 4EYA78sPefB9jETL1fUVeyhUMYEipUq9
      service_key: KYLLK4J9EFGE6T31
      user_name: agent_af2a5b84-2e8d-4296-9638-9afd41ddf5b5@MossaddequesOrg
    java:
      standalone_app_name: contrast-security-poc
      scan_all_classes: true
    application:
      name: contrast-security-poc
      path: k8s
    server:
      name: k8s-env
    agent:
      logger:
        level: ALL
```

Cheers!