# Docker Tomcat

Docker Image for [apache tomcat](http://tomcat.apache.org/)

Purpose of this image is:

- provide apache tomcat images

We currently testing v8.0.41 installation with native library.


Links:
- http://tomcat.apache.org/
- https://satishchilukuri.com/blog/entry/installing-java-8-and-tomcat-8-on-debian-wheezy
- https://github.com/docker-library/tomcat


# Tags

- latest


# Change Log

## current (latest)

- initial project
- install APR library
- install apache v8.0.41 under /srv/java/tomcat
- install apache native library
- use java:java user to launch all stuff
- openssl 1.1.0e-1


# MIT License

```
The MIT License (MIT)

Copyright (c) 2015 Airdock.io

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
