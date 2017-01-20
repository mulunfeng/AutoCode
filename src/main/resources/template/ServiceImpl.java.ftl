package ${model.packageName};

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
<#if model.entityName?if_exists!="">import ${model.basePackage}.entity.${model.entityName};</#if>
<#if model.entityName?if_exists!="">import ${model.basePackage}.dao.I${model.entityName}DAO;</#if>
<#if model.serviceInterfaceName?if_exists!="">import ${model.basePackage}.service.${model.serviceInterfaceName};</#if>
import com.nk.emis.frame.common.PageView;
 	
<#if model.serviceBeanName?if_exists!="">@Service("${model.serviceBeanName}")<#else></#if>

public class ${model.serviceName} <#if model.serviceInterfaceName?if_exists!="">implements ${model.serviceInterfaceName}<#else></#if> {
 	
 	<#if model.entityName?if_exists!="">
 	@Resource(name = "i${model.entityName}DAO")
	private I${model.entityName}DAO ${model.objectName}DAO;
 	</#if>
 	
 	@Override
 	public PageView<${model.entityName}> queryByPage(${model.entityName} ${model.objectName}, 
 		Integer pageIndex, Integer pageSize){
 		Map<String, Object> parameter = new HashMap<String, Object>();
 		
 		PageView<${model.entityName}> result = this.${model.objectName}DAO.queryByPage(parameter, pageIndex, pageSize);
 		
 		return result;
 	}
 	
 	@Override
 	public ${model.entityName} query(Integer idEntity){
 		if (idEntity == null) {
 			throw new IllegalArgumentException("缺少必要参数:idEntity为null.");
 		}
 		return this.${model.objectName}DAO.findById(idEntity);
 	}
 	
 	@Override
 	public boolean saveOrUpdate(${model.entityName} ${model.objectName}){
 		if (${model.objectName} == null) {
 			throw new IllegalArgumentException("缺少必要参数:${model.objectName}为null.");
 		}
 		this.${model.objectName}DAO.saveOrUpdate(${model.objectName});
 		
 		return true;
 	}
 	
 	@Override
 	public boolean delete(Integer idEntity){
 		if (idEntity == null) {
 			throw new IllegalArgumentException("缺少必要参数:idEntity为null.");
 		}
 		Map<String, Object> parameter = new HashMap<String, Object>();
 		parameter.put("idEntity", idEntity);
 		return this.${model.objectName}DAO.deleteById(parameter) > 0;
 	}
 	
}
