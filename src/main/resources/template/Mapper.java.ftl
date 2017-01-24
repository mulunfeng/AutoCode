package ${model.packageName};

import java.util.Map;

import com.nk.emis.frame.dao.IBaseDAO;
import ${model.basePackage}.entity.${model.entityName};
import com.nk.emis.frame.common.PageView;

public interface ${model.daoInterfaceName} {

	void addObj(${model.entityName} ${model.lowerEntityName})throws IllegalAccessException, InvocationTargetException, NoSuchMethodException;

	int delObj(${model.columnKey.type} ${model.columnKey.javaName})throws IllegalAccessException, InvocationTargetException, NoSuchMethodException;

	int updateObj(${model.entityName} ${model.lowerEntityName})throws IllegalAccessException, InvocationTargetException, NoSuchMethodException;

	List<${model.entityName}> findList(@Param(value = "${model.lowerEntityName}") ${model.entityName} ${model.lowerEntityName}, @Param(value = "pageVO") PageVO pageVO)throws IllegalAccessException, InvocationTargetException, NoSuchMethodException;

	${model.entityName} findObj(long id);

}
