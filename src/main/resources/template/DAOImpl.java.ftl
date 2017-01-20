package ${model.packageName};

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nk.emis.frame.dao.BaseDAOImpl;
<#if model.daoInterfaceName?if_exists!="">import ${model.basePackage}.dao.${model.daoInterfaceName};</#if>
import ${model.basePackage}.entity.${model.entityName};
import com.nk.emis.frame.common.PageView;

<#if model.repositoryName?if_exists!="">@Repository("${model.repositoryName}")<#else></#if>

public class ${model.daoName} extends BaseDAOImpl<${model.entityName}> 
	<#if model.daoInterfaceName?if_exists!="">implements ${model.daoInterfaceName}<#else></#if> {

	public ${model.daoName}(){
		super(${model.entityName}.class);
	}
	
	@Override
	public PageView<${model.entityName}> queryByPage(Map<String, Object> parameter, 
			Integer pageIndex, Integer pageSize){
		StringBuilder sqlBuilder = new StringBuilder();
		sqlBuilder.append("select t from ${model.entityName} t \t");
		
		List<String> conditions = new ArrayList<String>();
		if (!conditions.isEmpty()) {
			int index = 0;
			for (String condition : conditions) {
				if (index == 0) {
					sqlBuilder.append("where ");
				} else {
					sqlBuilder.append("and ");
				}
				sqlBuilder.append(condition);
				index++;
			}
		}
		sqlBuilder.append("order by t.id desc \t");
		return super.findPage(sqlBuilder.toString(), parameter, pageIndex, pageSize);
	}
 	
 	@Override
 	public int deleteById(Map<String, Object> parameter){
 		StringBuilder sqlBuilder = new StringBuilder();
		sqlBuilder.append("delete from ${model.entityName} t where t.id = :idEntity");
		return super.delByParams(sqlBuilder.toString(), parameter);
 	}
 	
}
