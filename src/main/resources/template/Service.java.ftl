package ${model.packageName};

import com.nk.emis.frame.common.PageView;
<#if model.entityName?if_exists!="">
import ${model.basePackage}.entity.${model.entityName};
</#if>

public interface ${model.serviceInterfaceName} {
 	
 	PageView<${model.entityName}> queryByPage(${model.entityName} ${model.objectName}, Integer pageIndex, Integer pageSize);
 	
 	${model.entityName} query(Integer idEntity);
 	 	
 	boolean saveOrUpdate(${model.entityName} ${model.objectName});
 	
 	boolean delete(Integer idEntity);
 	
}
