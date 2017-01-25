<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${daoPackageName}.${model.entityName}Mapper">

    <select id="findObj" resultType="${model.packageName}.entity.${model.entityName}" parameterType="java.lang.Long">
        <![CDATA[
        SELECT * FROM ${model.tableName} where ${model.columnKey.name} = ${r'#{'}${model.columnKey.javaName}}
        ]]>
    </select>

    <select id="findList" resultType="${model.packageName}.entity.${model.entityName}" parameterType="${model.packageName}.entity.${model.entityName}">
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
            <if test="${model.lowerEntityName}.${field.javaName?uncap_first}Begin != null">
                and ${field.name} >= ${r'#{'}${model.lowerEntityName}.${field.javaName?uncap_first}Begin}
            </if>
            <if test="${model.lowerEntityName}.${field.javaName?uncap_first}End != null">
                and ${field.name} &lt;= ${r'#{'}${model.lowerEntityName}.${field.javaName?uncap_first}End}
            </if>
					</#if>
				</#if>
			</#list>
        </where>
        ORDER BY ${model.columnKey.name} DESC
    </select>

    <update id="updateObj" parameterType="${model.packageName}.entity.${model.entityName}">
        update ${model.tableName}
        set
		    <#list model.columns as field>${field.name} = ${r'#{'}${field.javaName}}<#if (field_has_next)>,</#if><#if (field_index % 5 = 4) >${"\r\t\t\t"}</#if></#list>
        where ${model.columnKey.name} = ${r'#{'}${model.columnKey.javaName}}
    </update>

    <insert id="addObj" parameterType="${model.packageName}.entity.${model.entityName}">
        <![CDATA[
        insert into ${model.tableName} (
		    <#list model.columns as field>${field.name}<#if (field_has_next)>,</#if><#if (field_index % 9 = 8) >${"\r\t\t\t"}</#if></#list>
		)
        values (
		    <#list model.columns as field>${r'#{'}${field.javaName}}<#if (field_has_next)>,</#if><#if (field_index % 9 = 8) >${"\r\t\t\t"}</#if></#list>
		);
        ]]>
    </insert>

    <delete id="delObj" parameterType="java.lang.${model.columnKey.type}">
        <![CDATA[
        delete from ${model.tableName} where ${model.columnKey.name} = ${r'#{'}${model.columnKey.javaName}}
        ]]>
    </delete>

</mapper>
