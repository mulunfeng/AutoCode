<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${model.entityName}Mapper">
	
	<resultMap type="${model.packageName}.${model.entityName}" id="${model.entityName}Map">
		<id column="c_id" jdbcType="INTEGER" property="id"/>
		<#list model.columns as field>
		<result column="${field.name}" jdbcType="${field.typeDB}" property="${field.javaName}"/>
		</#list>
	</resultMap>
</mapper>
