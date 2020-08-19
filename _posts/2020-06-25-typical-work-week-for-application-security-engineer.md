---
layout: post
title: How a typical work week look like for an Application Security Engineer
date: 2020-06-25 22:43:00 +0100
excerpt: |
    Working as an application security engineer can be very exciting and ridiculously boring at the same time. If your are to be an application security
     engineer, hope you get some ideas.
categories: [tech]
tags: [application-security]
---

Working as an application security engineer can be very exciting and ridiculously boring at the same time. Here are the list of things we did on daily basis
. If your are to be an application security engineer, hope you get some ideas.

### Tool Integration

Integrating different security tooling in CI/CD pipelines is one of the major task. We used -

#### Veracode:
 - It's source code vulnerability finder.
 - Uploaded jar/wars/js to Vercode server.
 - Fetched reports using APIs and feed it to internal reporting tool.
 
#### Blackduck:
 - It find vulnerable opensource components (aka jar).
 - Attach with CI and CD pipelines.
 - Successful build triggered Blackduck scan.
 - Blackduck got two types of scans
   - Signature scan (useful when you have forked code or copied code from opensource software)
   - Dependency scan (aka pom.xml)
 - Fetched reports using APIs and feed it to internal reporting tool.

#### Github Code Search:
 - Home grown tool to find exposed code on Github.
 - Fetched reports and feed it to internal reporting tool.

#### Docker Image Vulnerability:
 - Trivy with Harbor registry.
 - Fetched reports using APIs and feed it to internal reporting tool.

### Code Review

Reviewing all vulnerability finding reports, see if it's false positive or not. If it's not a false positive, define the impact of the issue, suggest and
 guide team to fix it.
 
### Threat Modeling

Define threats in the application design phase and help development teams to add address those threats. Sounds like a nice idea if you are building the
 application from scratch, but tricky if the application is already built. Worst part is - tools around threat modeling is ridiculously boring.

### Educate Developers

Talks around different ASVS (Web, Mobile, Cloud, Container) and explaining security concepts.

### Pentesting

Learn how to use different tools(Kali toolset, trending tools on Github) and exploit application security.

### Security Presentation

Understanding the security in application platform and present/answer to clients.

### Learn Security

Apart from above, you gotta keep upto date yourself. Reading write-ups and prepare for certification are also part of daily activity.

Working in security could be handful, but it's exciting. We had around 80 Java microservices, frontend built on Angular, cloud native apps with Docker and
 Kubernetes, mobile SDKs for both Android and iOS. Keeping your head above the water is a challenge!

Cheers!

<br/>
<br/>

### Related Posts
- [How to find security vulnerabilities in source code]({% post_url 2020-08-19-how-to-find-security-vulnerabilities-in-source-code %})
- [Application security homelab setup on docker-compose]({% post_url 2019-12-25-application-security-homelab-setup-on-docker-compose %})