package ${model.packageName};

import ${model.basePackage}.entity.${model.entityName};
import org.apache.ibatis.annotations.Param;
import java.lang.reflect.InvocationTargetException;
import ${model.basePackage}.vo.PageVO;
import java.util.List;

public interface ${model.daoInterfaceName} {

	void addObj(${model.entityName} ${model.lowerEntityName})throws IllegalAccessException, InvocationTargetException, NoSuchMethodException;

	int delObj(${model.columnKey.type} ${model.columnKey.javaName})throws IllegalAccessException, InvocationTargetException, NoSuchMethodException;

	int updateObj(${model.entityName} ${model.lowerEntityName})throws IllegalAccessException, InvocationTargetException, NoSuchMethodException;

	List<${model.entityName}> findList(@Param(value = "${model.lowerEntityName}") ${model.entityName} ${model.lowerEntityName}, @Param(value = "pageVO") PageVO pageVO)throws IllegalAccessException, InvocationTargetException, NoSuchMethodException;

	${model.entityName} findObj(long id);

}
