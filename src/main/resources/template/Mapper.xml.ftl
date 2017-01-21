<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${daoPackageName}.${model.entityName}Mapper">

    <select id="findObj" resultType="${model.packageName}.${model.entityName}" parameterType="java.lang.Long">
        <![CDATA[
        SELECT * FROM ${model.tableName} where ${model.columnKey.name} = ${r'#{'}${model.columnKey.javaName}}
        ]]>
    </select>

    <select id="findList" resultType="${model.packageName}.${model.entityName}" parameterType="${model.packageName}.${model.entityName}">
        <![CDATA[
        SELECT * FROM ${model.tableName}
        ]]>
        <where>
			<#list model.columns as field>
				<#if !(field.columnKey)??>
					<#if field.dataType == "String">
            <if test="${model.lowerEntityName}.${field.javaName} != null and ${model.lowerEntityName}.${field.javaName} != ''">
                and ${field.name} like concat("%",${r'#{'}${model.lowerEntityName}.${field.javaName}},"%")
            </if>
					<#elseif field.dataType == "Integer">
            <if test="${model.lowerEntityName}.${field.javaName} != null">
                and ${field.name} = ${r'#{'}${model.lowerEntityName}.${field.javaName}}
            </if>
					<#elseif field.dataType == "Date">
            <if test="${model.lowerEntityName}.start${field.javaName?cap_first} != null and ${model.lowerEntityName}.start${field.javaName?cap_first} != ''">
                and ${field.name} >= ${r'#{'}${model.lowerEntityName}.start${field.javaName?cap_first}}
            </if>
            <if test="${model.lowerEntityName}.end${field.javaName?cap_first} != null and ${model.lowerEntityName}.end${field.javaName?cap_first} != ''">
                and ${field.name} <= ${r'#{'}${model.lowerEntityName}.end${field.javaName?cap_first}}
            </if>
					</#if>
				</#if>
			</#list>
        </where>
        ORDER BY ${model.columnKey.name} DESC
    </select>

    <update id="updateObj" parameterType="${model.packageName}.${model.entityName}">
        update ${model.tableName}
        set
		    <#list model.columns as field>${field.name} = ${r'#{'}${field.javaName}}<#if (field_has_next)>,</#if><#if (field_index % 5 = 4) >${"\r\t\t\t"}</#if></#list>
        where ${model.columnKey.name} = ${r'#{'}${model.columnKey.javaName}}
    </update>

    <insert id="addObj" parameterType="${model.packageName}.${model.entityName}">
        <![CDATA[
        insert into ${model.tableName} (
		    <#list model.columns as field>${field.name}<#if (field_has_next)>,</#if><#if (field_index % 9 = 8) >${"\r\t\t\t"}</#if></#list>
		)
        values (
		    <#list model.columns as field>${r'#{'}${field.javaName}}<#if (field_has_next)>,</#if><#if (field_index % 9 = 8) >${"\r\t\t\t"}</#if></#list>
		);
        ]]>
    </insert>

    <delete id="delObj" parameterType="${model.packageName}.${model.entityName}">
        <![CDATA[
        delete from ${model.tableName} where ${model.columnKey.name} = ${r'#{'}${model.columnKey.javaName}}
        ]]>
    </delete>

</mapper>
