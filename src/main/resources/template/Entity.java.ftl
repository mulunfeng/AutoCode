package ${model.packageName};

<#if model.extendName?if_exists!="">import com.nk.emis.frame.common.${model.extendName};</#if>
<#list model.importDataType as dataType>
import ${dataType}
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
	<#if field.comments?exists>/** ${field.comments} **/ <#else> </#if>
	<#if field.columnKey??>
	private ${field.type} ${field.javaName};
	<#else>
	private ${field.type} ${field.javaName};
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
 	
}
