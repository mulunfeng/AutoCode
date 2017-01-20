package ${model.packageName};

import java.util.Map;

import com.nk.emis.frame.dao.IBaseDAO;
import ${model.basePackage}.entity.${model.entityName};
import com.nk.emis.frame.common.PageView;

public interface ${model.daoInterfaceName} extends IBaseDAO<${model.entityName}> {
 	
 	PageView<${model.entityName}> queryByPage(Map<String, Object> parameter, Integer pageIndex, Integer pageSize);
 	
 	int deleteById(Map<String, Object> parameter);
 	
}
