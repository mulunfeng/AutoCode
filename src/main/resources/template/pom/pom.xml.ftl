<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>${packageName}</groupId>
    <artifactId>${projectName}</artifactId>
    <packaging>pom</packaging>
    <version>1.0-SNAPSHOT</version>
    <modules>
        <module>${projectName}-web</module>
        <module>${projectName}-service</module>
        <module>${projectName}-dao</module>
        <module>${projectName}-common</module>
    </modules>

    <properties>
        <modelVersoin>1.0-SNAPSHOT</modelVersoin>
        <sourceEncoding>UTF-8</sourceEncoding>
        <resteasy.version>2.2.1.GA</resteasy.version>
        <spring.version>3.2.0.RELEASE</spring.version>
        <slf4j.version>1.7.5</slf4j.version>
        <logback.version>1.1.2</logback.version>
    </properties>

    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>${packageName}</groupId>
                <artifactId>${projectName}-dao</artifactId>
                <version>${r'${'}modelVersoin}</version>
            </dependency>
            <dependency>
                <groupId>${packageName}</groupId>
                <artifactId>${projectName}-web</artifactId>
                <version>${r'${'}modelVersoin}</version>
            </dependency>
            <dependency>
                <groupId>${packageName}</groupId>
                <artifactId>${projectName}-service</artifactId>
                <version>${r'${'}modelVersoin}</version>
            </dependency>
            <dependency>
                <groupId>${packageName}</groupId>
                <artifactId>${projectName}-common</artifactId>
                <version>${r'${'}modelVersoin}</version>
            </dependency>

            <!-- logs -->
            <dependency>
                <groupId>log4j</groupId>
                <artifactId>log4j</artifactId>
                <version>1.2.17</version>
            </dependency>
            <dependency>
                <groupId>org.slf4j</groupId>
                <artifactId>jcl-over-slf4j</artifactId>
                <version>${r'${'}slf4j.version}</version>
                <scope>runtime</scope>
            </dependency>
            <dependency>
                <groupId>org.slf4j</groupId>
                <artifactId>log4j-over-slf4j</artifactId>
                <version>${r'${'}slf4j.version}</version>
                <scope>runtime</scope>
            </dependency>
            <dependency>
                <groupId>org.slf4j</groupId>
                <artifactId>jul-to-slf4j</artifactId>
                <version>${r'${'}slf4j.version}</version>
                <scope>runtime</scope>
            </dependency>
            <dependency>
                <groupId>org.slf4j</groupId>
                <artifactId>slf4j-api</artifactId>
                <version>${r'${'}slf4j.version}</version>
            </dependency>
            <dependency>
                <groupId>ch.qos.logback</groupId>
                <artifactId>logback-core</artifactId>
                <version>${r'${'}logback.version}</version>
            </dependency>
            <dependency>
                <groupId>ch.qos.logback</groupId>
                <artifactId>logback-classic</artifactId>
                <version>${r'${'}logback.version}</version>
            </dependency>

            <!--Spring核心组件-->
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-core</artifactId>
                <version>${r'${'}spring.version}</version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-test</artifactId>
                <version>${r'${'}spring.version}</version>
                <scope>test</scope>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-context</artifactId>
                <version>${r'${'}spring.version}</version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-context-support</artifactId>
                <version>${r'${'}spring.version}</version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-beans</artifactId>
                <version>${r'${'}spring.version}</version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-jdbc</artifactId>
                <version>${r'${'}spring.version}</version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-aop</artifactId>
                <version>${r'${'}spring.version}</version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-aspects</artifactId>
                <version>${r'${'}spring.version}</version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-tx</artifactId>
                <version>${r'${'}spring.version}</version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-web</artifactId>
                <version>${r'${'}spring.version}</version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-webmvc</artifactId>
                <version>${r'${'}spring.version}</version>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-orm</artifactId>
                <version>${r'${'}spring.version}</version>
            </dependency>

            <dependency>
                <groupId>javax.validation</groupId>
                <artifactId>validation-api</artifactId>
                <version>1.1.0.Final</version>
            </dependency>
            <dependency>
                <groupId>org.hibernate</groupId>
                <artifactId>hibernate-validator</artifactId>
                <version>4.3.0.Final</version>
            </dependency>

            <dependency>
                <groupId>com.google.code.gson</groupId>
                <artifactId>gson</artifactId>
                <version>2.2.4</version>
            </dependency>

            <!-- mybatis -->
            <dependency>
                <groupId>org.mybatis</groupId>
                <artifactId>mybatis</artifactId>
                <version>3.3.0</version>
            </dependency>
            <dependency>
                <groupId>org.mybatis</groupId>
                <artifactId>mybatis-spring</artifactId>
                <version>1.2.3</version>
            </dependency>
            <dependency>
                <groupId>org.apache.ibatis</groupId>
                <artifactId>ibatis-sqlmap</artifactId>
                <version>2.3.4.726</version>
            </dependency>

            <dependency>
                <groupId>commons-fileupload</groupId>
                <artifactId>commons-fileupload</artifactId>
                <version>1.3.1</version>
            </dependency>

            <dependency>
                <groupId>junit</groupId>
                <artifactId>junit</artifactId>
                <version>4.9</version>
                <scope>test</scope>
            </dependency>
            <!-- ali json tools -->
            <dependency>
                <groupId>com.alibaba</groupId>
                <artifactId>fastjson</artifactId>
                <version>1.1.23</version>
            </dependency>
            <dependency>
                <groupId>org.codehaus.jettison</groupId>
                <artifactId>jettison</artifactId>
                <version>1.3</version>
            </dependency>
            <dependency>
                <groupId>org.apache.httpcomponents</groupId>
                <artifactId>httpclient</artifactId>
                <version>4.3.3</version>
            </dependency>
            <dependency>
                <groupId>joda-time</groupId>
                <artifactId>joda-time</artifactId>
                <version>2.8.1</version>
            </dependency>

            <dependency>
                <groupId>mysql</groupId>
                <artifactId>mysql-connector-java</artifactId>
                <version>5.1.22</version>
            </dependency>

            <dependency>
                <groupId>mysql</groupId>
                <artifactId>mysql-connector-java</artifactId>
                <version>5.1.22</version>
                <scope>runtime</scope>
            </dependency>

            <!--servlet -->
            <dependency>
                <groupId>javax.servlet</groupId>
                <artifactId>servlet-api</artifactId>
                <version>2.4</version>
                <scope>provided</scope>
            </dependency>


            <!-- view -->
            <dependency>
                <groupId>org.apache.velocity</groupId>
                <artifactId>velocity</artifactId>
                <version>1.7</version>
            </dependency>
            <dependency>
                <groupId>org.apache.velocity</groupId>
                <artifactId>velocity-tools</artifactId>
                <version>2.0</version>
                <exclusions>
                    <exclusion>
                        <groupId>org.apache.struts</groupId>
                        <artifactId>struts-core</artifactId>
                    </exclusion>
                    <exclusion>
                        <groupId>org.apache.struts</groupId>
                        <artifactId>struts-taglib</artifactId>
                    </exclusion>
                    <exclusion>
                        <groupId>org.apache.struts</groupId>
                        <artifactId>struts-tiles</artifactId>
                    </exclusion>
                </exclusions>
            </dependency>
            <dependency>
                <groupId>javax.servlet</groupId>
                <artifactId>servlet-api</artifactId>
                <version>2.4</version>
                <scope>provided</scope>
            </dependency>

            <dependency>
                <groupId>aopalliance</groupId>
                <artifactId>aopalliance</artifactId>
                <version>1.0</version>
            </dependency>
            <dependency>
                <groupId>org.hibernate</groupId>
                <artifactId>hibernate-validator</artifactId>
                <version>4.3.0.Final</version>
            </dependency>

            <dependency>
                <groupId>org.apache.velocity</groupId>
                <artifactId>velocity</artifactId>
                <version>1.7</version>
            </dependency>

            <dependency>
                <groupId>com.jolbox</groupId>
                <artifactId>bonecp</artifactId>
                <version>0.7.1.RELEASE</version>
            </dependency>

            <!-- commons -->
            <dependency>
                <groupId>commons-lang</groupId>
                <artifactId>commons-lang</artifactId>
                <version>2.5</version>
            </dependency>
            <dependency>
                <groupId>commons-httpclient</groupId>
                <artifactId>commons-httpclient</artifactId>
                <version>3.1</version>
                <exclusions>
                    <exclusion>
                        <artifactId>commons-codec</artifactId>
                        <groupId>commons-codec</groupId>
                    </exclusion>
                    <exclusion>
                        <artifactId>commons-logging</artifactId>
                        <groupId>commons-logging</groupId>
                    </exclusion>
                </exclusions>
            </dependency>
            <dependency>
                <groupId>commons-codec</groupId>
                <artifactId>commons-codec</artifactId>
                <version>1.6</version>
            </dependency>

            <!-- Redis -->
            <dependency>
                <groupId>redis-common-data</groupId>
                <artifactId>redis-common-data</artifactId>
                <version>1.0.13-SNAPSHOT</version>
                <exclusions>
                    <exclusion>
                        <groupId>org.springframework</groupId>
                        <artifactId>spring</artifactId>
                    </exclusion>
                    <exclusion>
                        <groupId>log4j</groupId>
                        <artifactId>log4j</artifactId>
                    </exclusion>
                </exclusions>
            </dependency>

        </dependencies>
    </dependencyManagement>

    <build>
        <resources>
            <resource>
                <directory>src/main/resources</directory>
                <filtering>true</filtering>
            </resource>
        </resources>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.0</version>
                <configuration>
                    <source>1.6</source>
                    <target>1.6</target>
                    <encoding>UTF-8</encoding>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-resources-plugin</artifactId>
                <version>2.5</version>
                <configuration>
                    <encoding>UTF-8</encoding>
                </configuration>
            </plugin>
            <!-- Source attach plugin -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-source-plugin</artifactId>
                <version>2.2.1</version>
                <executions>
                    <execution>
                        <id>attach-sources</id>
                        <goals>
                            <goal>jar</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>2.9</version>
                <configuration>
                    <skip>true</skip>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>