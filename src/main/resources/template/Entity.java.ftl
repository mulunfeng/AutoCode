package ${model.packageName}.entity;

<#if model.extendName?if_exists!="">import com.nk.emis.frame.common.${model.extendName};</#if>
<#list model.importDataType as dataType>
import ${dataType};
</#list>

<#if model.tableRemarks!="">
/**
 *
 * ${model.tableRemarks}
 *
 */
</#if>
public class ${model.entityName} <#if model.extendName?if_exists!="">extends ${model.extendName} <#else></#if>{

	<#list model.columns as field>
	<#if field.comments?if_exists!="">/** ${field.comments} **/ <#else> </#if>
	<#if field.columnKey??>
	private ${field.type} ${field.javaName};
	<#else>
	private ${field.type} ${field.javaName};
	</#if>
	</#list>

	<#list model.columns as field>
		<#if field.dataType == "Date">
	<#if field.comments?if_exists!="">/** 临时字段开始-${field.comments} **/ <#else> </#if>
	private ${field.type} ${field.javaName}Begin;
	<#if field.comments?if_exists!="">/** 临时字段结束-${field.comments} **/ <#else> </#if>
	private ${field.type} ${field.javaName}End;
		</#if>
	</#list>
	
	/** 无参的构造函数 **/
	public ${model.entityName}(){
		super();
	}
	
	/** 有参构造函数 **/
	public ${model.entityName}(<#list model.columns as field><#if field_index?if_exists=0><#else>,</#if>${field.type} ${field.javaName}</#list>){
		super();
		<#list model.columns as field>
		this.${field.javaName} = ${field.javaName};
		</#list>
	}
 	
	<#list model.columns as field>
	/**
	 * @return <#if field.comments!="">${field.comments}<#else>${field.javaName}</#if>
	 */
	public ${field.type} get${field.getSetName}() {
		return ${field.javaName};
	}
	/**
	 * @param <#if field.comments?exists>${field.javaName} ${field.comments}<#else>${field.javaName}</#if>
	 */
	public void set${field.getSetName}(${field.type} ${field.javaName}) {
		this.${field.javaName} = ${field.javaName};
	}
	</#list>

	<#list model.columns as field>
		<#if field.dataType == "Date">
     /**
	* @return <#if field.comments!="">${field.comments}<#else>${field.javaName}Begin</#if>
	*/
	public ${field.type} get${field.getSetName}Begin() {
		return ${field.javaName}Begin;
	}
	/**
	* @param <#if field.comments?exists>${field.javaName}Begin ${field.comments}<#else>${field.javaName}Begin</#if>
	*/
	public void set${field.getSetName}Begin(${field.type} ${field.javaName}Begin) {
		this.${field.javaName}Begin = ${field.javaName}End;
	}

	/**
	* @return <#if field.comments!="">${field.comments}<#else>${field.javaName}End</#if>
	*/
	public ${field.type} get${field.getSetName}End() {
		return ${field.javaName}End;
	}
	/**
	* @param <#if field.comments?exists>${field.javaName}End ${field.comments}<#else>${field.javaName}End</#if>
	*/
	public void set${field.getSetName}End(${field.type} ${field.javaName}End) {
		this.${field.javaName}End = ${field.javaName}End;
	}
		</#if>
	</#list>
 	
}
