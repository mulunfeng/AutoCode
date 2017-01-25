<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <settings>
        <setting name="mapUnderscoreToCamelCase" value="true"/>
        <setting name="logImpl" value="STDOUT_LOGGING"/>
    </settings>
    <plugins>
        <plugin interceptor="${packageName}.mybatis.PageStatementHandlerInterceptor">
            <property name="pageSqlId" value=".*List.*"/>
        </plugin>
    </plugins>
    <mappers>
        <mapper resource="sqlmap/mysql/${entity}_sqlmap.xml"/>
    </mappers>
</configuration>