package ${model.packageName};
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

<#if model.extendName?if_exists!="">import com.nk.emis.frame.common.${model.extendName};</#if>

<#if model.tableRemarks?exists>
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
		
	<#if field.columnKey??>
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "HIBERNATE_SEQUENCE")
	@SequenceGenerator(name = "HIBERNATE_SEQUENCE", allocationSize = 1, sequenceName = "HIBERNATE_SEQUENCE")
	@Column(name="${field.name}")
	public ${field.type} get${field.getSetName}() {
		return ${field.javaName};
	}
	
	public void set${field.getSetName}(${field.type} ${field.javaName}) {
		this.${field.javaName} = ${field.javaName};
	}
	<#else>
	/**
	 * @return <#if field.comments?exists>${field.comments}<#else>${field.javaName}</#if>
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
	</#if>
	</#list>
 	
}
