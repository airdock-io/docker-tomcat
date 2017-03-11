FROM airdock/oracle-jdk:jdk-7u80
LABEL maintainer Jerome Guibert <jguibert@gmail.com>

ENV CATALINA_HOME=/srv/java/tomcat \
    PATH=/srv/java/bin:${PATH} \
    TOMCAT_MAJOR=8 \
    TOMCAT_VERSION=8.0.41 \
    TOMCAT_NATIVE_LIBDIR=/srv/java/tomcat/native-jni-lib \
    LD_LIBRARY_PATH=${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}/srv/java/tomcat/native-jni-lib \
    OPENSSL_VERSION=1.1.0e-1


RUN echo 'deb http://deb.debian.org/debian stretch main' > /etc/apt/sources.list.d/stretch.list \
    && { \
        # add a negative "Pin-Priority" so that we never ever get packages from stretch unless we explicitly request them
		echo 'Package: *'; \
		echo 'Pin: release n=stretch'; \
		echo 'Pin-Priority: -10'; \
		echo; \
        # except OpenSSL, which is the reason we're here
		echo 'Package: openssl libssl*'; \
		echo "Pin: version $OPENSSL_VERSION"; \
		echo 'Pin-Priority: 990'; \
    } > /etc/apt/preferences.d/stretch-openssl \
    && apt-get update -qq && apt-get install -y --no-install-recommends ca-certificates libapr1 openssl="${OPENSSL_VERSION}" \
    && mkdir -p ${CATALINA_HOME} && cd ${CATALINA_HOME} \
    && curl -L -O "https://www.apache.org/dyn/closer.cgi?action=download&filename=tomcat/tomcat-$TOMCAT_MAJOR/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz" \
    && tar -xvf apache-tomcat-${TOMCAT_VERSION}.tar.gz --strip-components=1 \
    && rm bin/*.bat && rm apache-tomcat-${TOMCAT_VERSION}.tar.gz* \
    && apt-get install -y --no-install-recommends libapr1-dev libssl-dev gcc make \
    && tar -xvf bin/tomcat-native.tar.gz -C "/tmp" --strip-components=1 \
    && cd /tmp/native \
    && ./configure --libdir="$TOMCAT_NATIVE_LIBDIR" --prefix="${CATALINA_HOME}" --with-apr="$(which apr-1-config)" --with-java-home="${JAVA_HOME}" --with-ssl=yes \
    && make && make install \
    && ln -s /usr/local/apr/lib/libtcnative-1.so /usr/lib/libtcnative-1.so \
    && apt-get purge -y --auto-remove gcc libapr1-dev libssl-dev make \
    && chown -R java:java  ${CATALINA_HOME} \
    && /root/post-install

EXPOSE 8080

WORKDIR ${CATALINA_HOME}

CMD ["tini", "-g", "--", "gosu", "java:java", "/srv/java/tomcat/bin/catalina.sh", "run"]
