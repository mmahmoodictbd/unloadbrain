---
layout: post
title: Application security homelab setup on docker-compose
date: 2019-12-25 18:00:00 +0100
excerpt: |
    How I setup my homelab to learn security concepts.
categories: [tech]
tags: [appsec, security, homelab, docker]
---

Recently I started working on application security. Worked as a backend software engineer for my years, had some
 basics, but now I get to learn how to hack a system.

These are the vulnerable apps that helped me a lot to learn new concepts:
- [citizenstig-nowasp](https://github.com/mmahmoodictbd/dev-setup/blob/master/security/vulnerable-apps/docker-compose-citizenstig-nowasp.yml)
- [juiceshop](https://github.com/mmahmoodictbd/dev-setup/blob/master/security/vulnerable-apps/docker-compose-juiceshop.yml)
- [web-dvwa](https://github.com/mmahmoodictbd/dev-setup/blob/master/security/vulnerable-apps/docker-compose-web-dvwa.yml)
- [webgoat](https://github.com/mmahmoodictbd/dev-setup/blob/master/security/vulnerable-apps/docker-compose-webgoat.yml)

Checkout the docker-compose files: [dev-setup-security](https://github.com/mmahmoodictbd/dev-setup/tree/master/security)

To get my basics right, I used [Security Knowledge Framework](https://github.com/mmahmoodictbd/dev-setup/blob/master/security/docker-compose-security-knowledge-framework.yml).

<br/>
<br/>

### Related Posts
- [How to find security vulnerabilities in source code]({% post_url 2020-08-19-how-to-find-security-vulnerabilities-in-source-code %})
- [How a typical work week look like for an Application Security Engineer]({% post_url 2020-06-25-typical-work-week-for-application-security-engineer %})