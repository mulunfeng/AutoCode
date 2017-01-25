<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">

	<bean id="cfSqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
		<property name="configLocation" value="classpath:sqlmap-config.xml"/>
		<property name="dataSource" ref="businessDataSource"/>
	</bean>

	<bean id="abstractMapper" abstract="true" class="org.mybatis.spring.mapper.MapperFactoryBean">
		<property name="sqlSessionFactory" ref="cfSqlSessionFactory"/>
	</bean>

	<bean id="${entity?uncap_first}Mapper" parent="abstractMapper">
		<property name="mapperInterface" value="${packageName}.dao.${entity}Mapper"/>
	</bean>

</beans>
