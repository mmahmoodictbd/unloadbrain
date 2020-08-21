---
layout: post
title: How to find security vulnerabilities in source code
date: 2020-08-19 05:00:00 +0100
excerpt: |
     As a software developer, we write code on a daily basis. Here are some tips how to find security vulnerabilities in source code.
categories: [tech]
tags: [appsec, application-security, security-code-review]
---

I have worked in application security, had to deal with big codebase, hence came up with some tips on how to review codebase for security vulnerability.

Tools mentioned in this article that are related with Java because most of my programming experience is with Java. However, you can find similar tools in all
  major programming language.

### How to do it?
- SAST, DAST, IAST tools.
  - Tools are usually based on rules. They are not perfect, lots of false positives.
  - The idea behind using tools is to find the suspicious code and manually review it.
- Manual review.

### Dependency Management
- Modern application composed of tons of Open Source libraries. In Java, different build tools like Maven manage dependencies with pom.xml.
- Since open source libraries is open for all to see the code, people find the vulnerabilities within days/months.
  - Example of vulnerable [Fasterxml Jackson-databind](https://www.cvedetails.com/product/42991/Fasterxml-Jackson-databind.html?vendor_id=15866).
- There are different open source and commercial tools available that going to help you find these vulnerable libraries.
  - [OWASP Dependency-Check](https://github.com/jeremylong/DependencyCheck). Dependency-check has a command line interface, a Maven plugin, an Ant task, and
   a Jenkins plugin.
  - Paid services are also available, e.g. Blackduck, Checkmarx and lot others.
- Once one of your library is marked as vulnerable, you should assess the impact on your application.
  - If impact is higher, and you don't have any control (security controls are safeguards or countermeasures) in place, you should fix it immediately.
  - You could upgrade the library version if newer version does not have that vulnerability.
  - If version upgrade is too much to do, then find what other control you can put to remediate the risk.
- You should scan as part of 
  - CI pipeline, to prevent the inclusion of vulnerable version of a library.
  - Nightly, to find new vulnerability on the current version.

### Source code analyzer (e.g. .java files)
- Start with the static analyzer (SAST) tools. It will help you find some obvious security bugs.
- Open source static analyzers:
  - [OWASP Find Security Bugs](https://find-sec-bugs.github.io/)
  - [SonarQube security scan](https://rules.sonarsource.com/java/type/Security%20Hotspot)
- For advanced user, checkout [CodeQL](https://github.com/github/codeql). Watch [this video](https://www.youtube.com/watch?v=nvCd0Ee4FgE) to get a head start.
- Commercial tools are also available.

### Dynamic analyzer (e.g. class/jar/war/ear files)
- Goes by IAST/DAST tools too.
- Usually attach with the application OS process.
  - Using JavaAgent is one of most common practice.
- These type tools find anomalies in the program's call stack.
- I've only seen commercial tools.

### Manually review code in the following areas:
- Authentication and Authorization configurations.
  - Don't write your own Auth/AuthZ service, use framework/libraries.
- Web application CSRF configuration / CORS policy.
- Web API request parameters / headers / cookies.
  - Don't trust anything that come from client side. Validate every input, prefer whitelist instead of blacklist.
  - May leads to SQL injection, command injection, path traversal, XSS, etc.
- Cookies without the HttpOnly/secure flag.
  - Successful XSS could steal user session.
- Logging, be aware what you log.
  - May leads to log [injection](https://owasp.org/www-community/attacks/Log_Injection), sensitive data leak, etc.
- Reading/writing files from/to the disk.
  - Whenever you are reading/writing a file from/to a disk, make sure path is not user-provided.
  - May leads to path traversal.
- Dealing with Certificates?
  - Think of Man-in-the-middle attacks.
- Hash function, ciphers algorithm and TLS protocols.
  - Whenever you see a hash function or ciphers algorithm or a protocol, check if it's still okay to use.
  - E.g. MD5 / 3DES / TLS 1.0 is not okay to use for many use-cases.
- SQL statement / Hibernate HQL / JPQL.
  - Think parameter binding and SQL injection.
- Neutralize Output.
  - Sanitize HTML Markup with a library designed for the job.
  - Think encoding/escaping and XSS attach. See [OWASP Cross Site Scripting Prevention Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets
  /Cross_Site_Scripting_Prevention_Cheat_Sheet.html).
- Make sure you meet the [Application Security Verification Standard](https://github.com/OWASP/ASVS#latest-released-version) (ASVS).
  - Latest version (4.0.1, dated 2 March 2019) is 68 pages. Trust me, once you read these 68 pages, you will be bit more wise.

### What to build security related knowledge?
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [OWASP API Security Top 10](https://owasp.org/www-project-api-security/)
- [MITRE Top 25](http://cwe.mitre.org/top25/archive/2019/2019_cwe_top25.html)
- [SANS TOP 25](https://www.sans.org/top25-software-errors)
- [OWASP Cheat Sheet Series](https://cheatsheetseries.owasp.org/)
- [OWASP Security Knowledge Framework](https://www.securityknowledgeframework.org/)


<br/>

Live long and prosper! :vulcan_salute:

<br/>
<br/>

### Related Posts
- [How a typical work week look like for an Application Security Engineer]({% post_url 2020-06-25-typical-work-week-for-application-security-engineer %})
- [Application security homelab setup on docker-compose]({% post_url 2019-12-25-application-security-homelab-setup-on-docker-compose %})
- [Attach ContrastSecurity (DAST) tool JavaAgent in K8s]({% post_url 2020-02-27-attach-java-agent-in-java-apps-deployed-on-kubernates %})