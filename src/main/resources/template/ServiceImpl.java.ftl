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
	private static final Logger LOGGER = LoggerFactory.getLogger(${model.serviceName}.class);

	<#if model.entityName?if_exists!="">
 	@Resource
	private ${model.entityName}Mapper ${model.objectName}Mapper;
 	</#if>
 	
 	@Override
 	public Page findPage(${model.entityName} ${model.objectName},PageVO pageVO){
		List<${model.entityName}> list = this.${model.objectName}Mapper.findList(${model.objectName}, pageVO);
		Page page = new Page(list, pageVO);
 		return page;
 	}

 	@Override
 	public boolean add${model.entityName}(${model.entityName} ${model.entityName?uncap_first}){
 		if (${model.objectName} == null) {
 			throw new IllegalArgumentException("缺少必要参数:${model.objectName}为null.");
 		}

		try {
			this.${model.objectName}Mapper.addObj(${model.objectName});
			return true;
		} catch (Exception e) {
			LOGGER.error("add${model.entityName} fail!", e);
			return false;
		}
 	}
 	
 	@Override
 	public boolean del${model.entityName}(${model.columnKey.dataType} ${model.columnKey.javaName}){
 		if (${model.columnKey.javaName} == null) {
 			throw new IllegalArgumentException("缺少必要参数:${model.columnKey.javaName}为null.");
 		}

		try {
			return ${model.objectName}Mapper.delObj(${model.columnKey.javaName}) > 0;
		} catch (Exception e) {
			LOGGER.error("del${model.entityName} fail!", e);
		}
		return false;
 	}

	@Override
	public boolean update${model.entityName}(${model.entityName} ${model.entityName?uncap_first}){
		try {
			return ${model.objectName}Mapper.updateObj(${model.entityName?uncap_first}) > 0;
		} catch (Exception e) {
			LOGGER.error("update${model.entityName} fail!", e);
		}
		return false;
	}

	@Override
	public ${model.entityName} get${model.entityName}(${model.columnKey.dataType} ${model.columnKey.javaName}){

		try {
			return ${model.objectName}Mapper.findObj(id);
		} catch (Exception e) {
			LOGGER.error("queryWool fail!", e);
		}
		return null;
	}
}
