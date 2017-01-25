package ${model.packageName};

import ${model.basePackage}.vo.PageVO;
import ${model.basePackage}.vo.Page;
<#if model.entityName?if_exists!="">
import ${model.basePackage}.entity.${model.entityName};
</#if>

public interface ${model.serviceInterfaceName} {

	Page findPage(${model.entityName} ${model.entityName?uncap_first}, PageVO pageVO);

	boolean add${model.entityName}(${model.entityName} ${model.entityName?uncap_first});

	boolean del${model.entityName}(${model.columnKey.dataType} ${model.columnKey.javaName});

	boolean update${model.entityName}(${model.entityName} ${model.entityName?uncap_first});

	${model.entityName} get${model.entityName}(${model.columnKey.dataType} ${model.columnKey.javaName});

}
