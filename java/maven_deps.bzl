load("@rules_jvm_external//:defs.bzl", "maven_install")
load("@rules_jvm_external//:specs.bzl", "maven")

def selenium_java_deps():
    netty_version = "4.1.84.Final"
    opentelemetry_version = "1.19.0"
    junit_jupiter_version = "5.9.1"
    junit_platform_version = "1.9.1"

    maven_install(
        artifacts = [
            "com.beust:jcommander:1.82",
            "com.github.javaparser:javaparser-core:3.24.7",
            maven.artifact(
                group = "com.github.spotbugs",
                artifact = "spotbugs",
                version = "4.7.3",
                exclusions = [
                    "org.slf4j:slf4j-api",
                ],
            ),
            "com.google.code.gson:gson:2.9.1",
            "com.google.guava:guava:31.1-jre",
            "com.google.auto:auto-common:1.2.1",
            "com.google.auto.service:auto-service:1.0.1",
            "com.google.auto.service:auto-service-annotations:1.0.1",
            "com.graphql-java:graphql-java:19.2",
            "com.graphql-java:java-dataloader:3.2.0",
            "io.grpc:grpc-context:1.50.2",
            "io.lettuce:lettuce-core:6.2.1.RELEASE",
            "io.netty:netty-buffer:%s" % netty_version,
            "io.netty:netty-codec-haproxy:%s" % netty_version,
            "io.netty:netty-codec-http:%s" % netty_version,
            "io.netty:netty-codec-http2:%s" % netty_version,
            "io.netty:netty-common:%s" % netty_version,
            "io.netty:netty-handler:%s" % netty_version,
            "io.netty:netty-handler-proxy:%s" % netty_version,
            "io.netty:netty-transport:%s" % netty_version,
            "io.netty:netty-transport-classes-epoll:%s" % netty_version,
            "io.netty:netty-transport-classes-kqueue:%s" % netty_version,
            # Start - Needed to support unix domain sockets
            "io.netty:netty-transport-native-epoll:%s" % netty_version,
            "io.netty:netty-transport-native-epoll:jar:linux-x86_64:%s" % netty_version,
            "io.netty:netty-transport-native-kqueue:%s" % netty_version,
            "io.netty:netty-transport-native-kqueue:jar:osx-aarch_64:%s" % netty_version,
            "io.netty:netty-transport-native-kqueue:jar:osx-x86_64:%s" % netty_version,
            # End - Needed to support unix domain sockets
            "io.netty:netty-transport-native-unix-common:%s" % netty_version,
            "io.opentelemetry:opentelemetry-api:%s" % opentelemetry_version,
            "io.opentelemetry:opentelemetry-context:%s" % opentelemetry_version,
            "io.opentelemetry:opentelemetry-exporter-logging:%s" % opentelemetry_version,
            "io.opentelemetry:opentelemetry-semconv:%s" % opentelemetry_version + "-alpha",
            "io.opentelemetry:opentelemetry-sdk:%s" % opentelemetry_version,
            "io.opentelemetry:opentelemetry-sdk-common:%s" % opentelemetry_version,
            "io.opentelemetry:opentelemetry-sdk-extension-autoconfigure:%s" % opentelemetry_version + "-alpha",
            "io.opentelemetry:opentelemetry-sdk-extension-autoconfigure-spi:%s" % opentelemetry_version,
            "io.opentelemetry:opentelemetry-sdk-testing:%s" % opentelemetry_version,
            "io.opentelemetry:opentelemetry-sdk-trace:%s" % opentelemetry_version,
            "io.ous:jtoml:2.0.0",
            "it.ozimov:embedded-redis:0.7.3",
            "javax.servlet:javax.servlet-api:4.0.1",
            maven.artifact(
                group = "junit",
                artifact = "junit",
                version = "4.13.2",
                exclusions = [
                    "org.hamcrest:hamcrest-all",
                    "org.hamcrest:hamcrest-core",
                    "org.hamcrest:hamcrest-library",
                ],
            ),
            "org.junit.jupiter:junit-jupiter-api:%s" % junit_jupiter_version,
            "org.junit.jupiter:junit-jupiter-engine:%s" % junit_jupiter_version,
            "org.junit.jupiter:junit-jupiter-params:%s" % junit_jupiter_version,
            "org.junit.platform:junit-platform-launcher:%s" % junit_platform_version,
            "org.junit.platform:junit-platform-reporting:%s" % junit_platform_version,
            "org.junit.platform:junit-platform-commons:%s" % junit_platform_version,
            "org.junit.platform:junit-platform-engine:%s" % junit_platform_version,
            "org.junit.platform:junit-platform-suite-engine:%s" % junit_platform_version,
            "org.junit.platform:junit-platform-suite-api:%s" % junit_platform_version,
            "net.bytebuddy:byte-buddy:1.12.18",
            "dev.failsafe:failsafe:3.3.0",
            "net.sourceforge.htmlunit:htmlunit-core-js:2.65.0",
            "org.apache.commons:commons-exec:1.3",
            "org.assertj:assertj-core:3.23.1",
            maven.artifact(
                group = "org.asynchttpclient",
                artifact = "async-http-client",
                version = "2.12.3",
                exclusions = [
                    "io.netty:netty-transport-native-epoll",
                    "io.netty:netty-transport-native-kqueue",
                ],
            ),
            "org.eclipse.mylyn.github:org.eclipse.egit.github.core:2.1.5",
            "org.hamcrest:hamcrest:2.2",
            "org.hsqldb:hsqldb:2.7.1",
            "org.mockito:mockito-core:4.8.1",
            "org.slf4j:slf4j-api:2.0.3",
            "org.slf4j:slf4j-jdk14:2.0.3",
            "org.testng:testng:7.6.1",
            "org.zeromq:jeromq:0.5.2",
            "xyz.rogfam:littleproxy:2.0.13",
            "org.seleniumhq.selenium:htmlunit-driver:4.5.2",
            "org.redisson:redisson:3.17.7",
            "com.github.stephenc.jcip:jcip-annotations:1.0-1",
        ],
        excluded_artifacts = [
            "org.hamcrest:hamcrest-all",  # Replaced by hamcrest 2
            "org.hamcrest:hamcrest-core",
            "io.netty:netty-all",  # Depend on the actual things you need
        ],
        override_targets = {
            "org.seleniumhq.selenium:selenium-api": "@//java/src/org/openqa/selenium:core",
            "org.seleniumhq.selenium:selenium-remote-driver": "@//java/src/org/openqa/selenium/remote:remote",
            "org.seleniumhq.selenium:selenium-support": "@//java/src/org/openqa/selenium/support",
        },
        fail_on_missing_checksum = True,
        fail_if_repin_required = True,
        fetch_sources = True,
        strict_visibility = True,
        repositories = [
            "https://repo1.maven.org/maven2",
            "https://maven.google.com",
        ],
        maven_install_json = "@selenium//java:maven_install.json",
        version_conflict_policy = "pinned",
    )
