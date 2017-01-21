package ${model.packageName};

import com.nk.emis.frame.common.PageView;
<#if model.entityName?if_exists!="">
import ${model.basePackage}.entity.${model.entityName};
</#if>

public interface ${model.serviceInterfaceName} {

	PageVO<${model.entityName}> find${model.entityName}Page(${model.entityName} ${model.entityName?uncap_first}, Page page);

	boolean add${model.entityName}(${model.entityName} ${model.entityName?uncap_first});

	boolean del${model.entityName}(${model.columnKey.dataType} ${model.columnKey.javaName});

	boolean update${model.entityName}(${model.entityName} ${model.entityName?uncap_first});

	${model.entityName} get${model.entityName}(${model.columnKey.dataType} ${model.columnKey.javaName});

}
