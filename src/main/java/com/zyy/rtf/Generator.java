package com.zyy.rtf;

import com.zyy.rtf.constant.*;
import com.zyy.rtf.model.*;
import com.zyy.rtf.util.ConfigurationHelper;
import com.zyy.rtf.util.ConvertUtil;
import com.zyy.rtf.util.FileUtil;
import com.zyy.rtf.util.StringUtil;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.apache.commons.lang.StringUtils;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.sql.*;
import java.util.*;

public abstract class Generator {
	
	/**
	 * 根据模板生成实体类
	 * @param templateName	模板地址
	 * @param data			数据集合
	 * @param outFileName		输出文件
	 */
	@SuppressWarnings("rawtypes")
	protected static void generateFromTemplate(Map data, String outFileName, String templateName) {
		try {
			//获取输出文件地址
			String genFileDir=outFileName.substring(0, outFileName.lastIndexOf("/"));

			Configuration cfg = ConfigurationHelper.getConfiguration(EntityConstant.ENTITY_TEMPLATE_DIR);
			
			//加载模板
			Template template = cfg.getTemplate(templateName);
	        //创建输出文件地址
	        org.apache.commons.io.FileUtils.forceMkdir(new File(genFileDir));
	        
	        File output = new File(outFileName);
	        
	        Writer writer = new FileWriter(output);
	        //通过模板将数据生成实体类
	        template.process(data, writer);
	        writer.close();
		} catch (TemplateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}catch (Exception e){
			e.printStackTrace();
		}
	}
	
	protected static void generateMapper(Map data, String entityName, String packageName) {
		//dao包名
		data.put("daoPackageName", packageName + ".dao");
		String filePath = new String(ModuleEnum.ENTITY.path() + BaseConstant.SQLMAP_MYSQL_PATH + entityName + "_sqlmap.xml");
		generateFromTemplate(data, filePath, EntityConstant.MAPPER_TEMPLATE);
	}
	
	/**
	 * 将包地址的"."转换成"/"
	 * @param packageName
	 * @return
	 */
	protected static String package2path(String packageName) {
		return packageName.replace('.', '/');
	}
	
	/**
	 * 根据数据库表明获得数据列信息
	 * @param tableName 表名
	 * @return
	 */
	protected static List<Column> getColumns(String tableName, Properties pro) {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DatabaseMetaData dbmd = null;
		ResultSet resultSet = null;
		ResultSetMetaData rsmd = null;
		ResultSet rs2 = null;
		try {
			boolean f = Boolean.parseBoolean(pro.get(EntityConstant.ISNEEDKEY).toString());
			Connection conn = DataSource.getConnection(pro);
			stmt = conn.prepareStatement("select *  from " + tableName + " where 1=0 ");
			
			
			Map<String,String> columnRemarkMap = new HashMap<String, String>();
			// 获取列注释
			dbmd = conn.getMetaData();
			rs = dbmd.getColumns(null, null, tableName, null);
			while (rs.next()) {
				columnRemarkMap.put(rs.getString("COLUMN_NAME"), rs.getString("REMARKS"));
			}
			System.out.println(columnRemarkMap.toString());
		
			resultSet = stmt.executeQuery();
			rsmd = resultSet.getMetaData();
			// 获得所有列的数目及实际列数
			int n = rsmd.getColumnCount();
			List<Column> columns = new ArrayList<Column>();
			String buffer = "" ; 
			int s = 2;
			//如果需要主键则需要从第一行开始
			if(f) s=1;
			for (int i = s; i <= n; i++) {
				// 获得指定列的列名
				String colName = rsmd.getColumnName(i);
				Column column = new Column();
				column.setName(colName);
				String javaName = ConvertUtil.getAttributeName(colName, pro.getProperty(EntityConstant.ATTPREFIX));
				// javaBean中的列名
				column.setJavaName(javaName);
				//get和set方法的方法名称
				column.setGetSetName(ConvertUtil.getGetSetName(javaName));
				if(ConvertUtil.sqlType2JavaType(rsmd.getColumnTypeName(i).toLowerCase()) == null){
					System.out.println("+++++++++++++++++++++++++++++++"+rsmd.getColumnTypeName(i));
				}
				column.setType(ConvertUtil.sqlType2JavaType(rsmd.getColumnTypeName(i).toLowerCase()));
				column.setTypeDB(rsmd.getColumnTypeName(i).toLowerCase().equals("int")?"INTEGER":rsmd.getColumnTypeName(i));
				column.setDataType(ConvertUtil.sqlType2JavaType(rsmd.getColumnTypeName(i).toLowerCase()));
				// 某列类型的精确度(类型的长度)
				column.setPrecision(String.valueOf(rsmd.getPrecision(i)));
				// 小数点后的位数
				column.setScale(String.valueOf(rsmd.getScale(i)));
				// 获取列的长度
				column.setLength(String.valueOf(rsmd.getColumnDisplaySize(i)));

				// 是否为空
				column.setNullable(1 == rsmd.isNullable(i));
				
				String columnRemark = columnRemarkMap.get(column.getName());
				if(columnRemark != null){
					column.setComments(columnRemark);
				}
				
				if(f){
					// 获取主键列
					rs2 = dbmd.getPrimaryKeys(null, null, tableName);
					while (rs2.next()) {
						if (colName.equals(rs2.getString("COLUMN_NAME")))
							column.setColumnKey("TRUE");
					}
					rs2.close();
				}
				columns.add(column);
				rs.close();
			}
			return columns;
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally{
			try {
				resultSet.close();
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 方法功能说明:获取表名、表注释
	 * @param pro
	 * @return
	 */
	protected static List<Table> getTables(Properties pro){
		DatabaseMetaData dbMetaData = null ;
		Statement stmt = null;
		ResultSet rs = null;
		List<Table> tableList = new ArrayList<Table>();
		try{
			Connection conn = DataSource.getConnection(pro);
			List<String> tables = (List<String>) pro.get(EntityConstant.TABLES);
			
			if(tables == null || tables.isEmpty()){
				dbMetaData = conn.getMetaData(); 
				String[] types = { "TABLE" };    
				rs = dbMetaData.getTables(null, pro.getProperty("user").toUpperCase(), "%", types);  
				Table table;
				while (rs.next()) {    
				    table = new Table();
				    table.setTableName(rs.getString("TABLE_NAME"));
				    table.setTableComment(rs.getString("REMARKS"));
				    tableList.add(table);
				}
			} else {
				StringBuilder sqlBuilder = new StringBuilder();
				if (pro.get("jdbc.driver").toString().equalsIgnoreCase(EntityConstant.JDBC_DRIVER_MYSQL)){
					sqlBuilder.append("SELECT `TABLES`.TABLE_NAME as Table_Name, `TABLES`.TABLE_COMMENT as Comments FROM `INFORMATION_SCHEMA`.`TABLES` where TABLE_NAME in (");
					for(String tableName : tables){
						sqlBuilder.append("'").append(tableName.toLowerCase()).append("'").append(",");
					}
					sqlBuilder = sqlBuilder.deleteCharAt(sqlBuilder.lastIndexOf(","));
					sqlBuilder.append(")");
				} else if (pro.get("jdbc.driver").toString().equalsIgnoreCase(EntityConstant.JDBC_DRIVER_ORACLE)) {
					sqlBuilder.append("Select A.Table_Name,B.Comments From User_Tables A join User_Tab_Comments B on A.Table_Name=B.Table_Name where 1=1 ");
					sqlBuilder.append(" and A.Table_Name in (");
					for(String tableName : tables){
						sqlBuilder.append("'").append(tableName).append("'").append(",");
					}
					sqlBuilder = sqlBuilder.deleteCharAt(sqlBuilder.lastIndexOf(","));
					sqlBuilder.append(")");
				}
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sqlBuilder.toString());
				while(rs.next()){
					Table table = new Table();
					table.setTableName(rs.getString("Table_Name"));
					table.setTableComment(rs.getString("Comments"));
					tableList.add(table);
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
			try{
				if(rs != null){
					rs.close();
					rs = null;
				}
				if(stmt != null){
					stmt.close();
					stmt = null;
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return tableList;
	}
	
	 private static String parse(String all) {
         String comment = null;
         int index = all.indexOf("COMMENT='");
         if(index < 0) {
                 return "";
         }
         comment = all.substring(index+9);
         comment = comment.substring(0,comment.length() - 1);
         return comment;
 }
	
	/**
	 * 根据表名通过调用模板生成实体
	 * 
	 * @param tableName
	 */
	protected static void createGenerator(String tableName,String tableRemarks, Properties pro) {
		FreeMarkEntityModel model = new FreeMarkEntityModel();
		Map<String, Object> data = new HashMap<>();
		String packageName = pro.getProperty(EntityConstant.PACKAGE);
		// 设置包名
		model.setPackageName(packageName);
		// 设置继承类包名
		model.setExtendPackageName(pro.getProperty(EntityConstant.EXTEND_PACKAGE));
		// 设置继承类名
		model.setExtendName(pro.getProperty(EntityConstant.EXTEND_NAME));
		// 类名
		String entityName = ConvertUtil.getEntityName(tableName, pro.getProperty(EntityConstant.TABPREFIX));
		model.setEntityName(entityName);
		// 所属数据库用户
		model.setSysName(pro.getProperty("user").toUpperCase());
		// 数据库表名
		model.setTableName(tableName);
		// 获取表中列的集合
		List<Column> columns = getColumns(tableName, pro);
		model.setColumns(columns);
		//表的描述
		model.setTableRemarks(tableRemarks);
		
		data.put("model", model);
		String path = GeneratorFilePath.create(model);
		if (StringUtils.isBlank(path))
			throw new RuntimeException("生成路径失败");
		generateEntity(data, pro.getProperty(EntityConstant.PACKAGE), entityName);
		generateService(data, pro.getProperty(EntityConstant.PACKAGE), entityName);
		generateDAO(data, pro.getProperty(EntityConstant.PACKAGE), entityName);
		generateMapper(data, entityName, pro.getProperty(EntityConstant.PACKAGE));
		generateController(data, pro.getProperty(EntityConstant.PACKAGE), entityName);
		generateView(data, pro.getProperty(EntityConstant.PACKAGE), entityName);
		generatePom(pro.getProperty(EntityConstant.PACKAGE));
	}

	private static void generateEntity(Map<String, Object> data, String packageName, String entityName) {
		String filePath = new String(ModuleEnum.ENTITY.path() + BaseConstant.PROJECT_JAVA_PATH + Generator.package2path(packageName) + "/entity/" + entityName + ".java");
		generateFromTemplate(data, filePath, EntityConstant.ENTITY_TEMPLATE);
	}

	private static void generatePom(String packageName) {
		Map<String, String> data = new HashMap<String, String>();
		data.put("projectName", BaseConstant.PROJECT_NAME);
		data.put("packageName", packageName);
		File file = new File(EntityConstant.ENTITY_TEMPLATE_DIR + "/pom");
		if (file.exists() && file.isDirectory()) {
			File[] files = file.listFiles();
			for (File pom : files) {
				generateFromTemplate(data, GeneratorFilePath.getPomPath(pom.getName()), "/pom/"+pom.getName());
			}
		}
	}

	private static void generateView(Map<String, Object> data, String packageName, String entityName) {
		String _packageName = packageName + ".vm";
		data.put("controllerPackageName", _packageName);
		String filePath = new String("src/" + Generator.package2path(_packageName) + "/list-" + entityName + "s.vm");
//		generateFromTemplate(data, filePath, EntityConstant.VIEW_TEMPLATE);
	}

	private static void generateController(Map<String, Object> data, String packageName, String entityName) {
		String _packageName = packageName + ".controller";
		data.put("controllerPackageName", _packageName);
		data.put("DATA_TYPE_TRANS_MAP", DataTypeConstant.DATA_TYPE_TRANS_MAP);
		String filePath = new String(ModuleEnum.WEB.path() + BaseConstant.PROJECT_JAVA_PATH + Generator.package2path(_packageName) + "/" + entityName + "Controller.java");
		generateFromTemplate(data, filePath, EntityConstant.CONTROLLER_TEMPLATE);
	}

	public static String uncapitalize(String str) {
        int strLen;
        if (str == null || (strLen = str.length()) == 0) {
            return str;
        }
        return new StringBuilder(strLen)
            .append(Character.toLowerCase(str.charAt(0)))
            .append(str.substring(1))
            .toString();
    }
	
	private static void generateService(Map<String, Object> map, String packageName, String entityName) {
		FreeMarkServiceModel serviceModel = new FreeMarkServiceModel();
		
		serviceModel.setBasePackage(packageName);
		
		serviceModel.setEntityName(entityName);
		String objectName = uncapitalize(entityName);
		serviceModel.setObjectName(objectName);
		String entityPackageName = packageName + ".entity." + entityName;
		serviceModel.setEntityPackageName(entityPackageName);
		
		String serviceInterfaceName = entityName + "Service";
		serviceModel.setServiceInterfaceName(serviceInterfaceName);
		
		String _packageName = packageName + ".service";
		serviceModel.setPackageName(_packageName);
		serviceModel.setColumns(((FreeMarkEntityModel)map.get("model")).getColumns());
		
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("model", serviceModel);
		String filePath = new String(ModuleEnum.SERVICE.path() + BaseConstant.PROJECT_JAVA_PATH + Generator.package2path(_packageName) + "/" + serviceInterfaceName + ".java");
		generateFromTemplate(data, filePath, ServiceConstant.SERVICE_INTERFACE_TEMPLATE);
		
		String serviceName = entityName + "ServiceImpl";
		serviceModel.setServiceName(serviceName);
		String serviceBeanName = entityName+"Service";
		serviceModel.setServiceBeanName(serviceBeanName);
		
		_packageName = packageName + ".service.impl";
		serviceModel.setPackageName(_packageName);
		
		filePath = new String(ModuleEnum.SERVICE.path() + BaseConstant.PROJECT_JAVA_PATH + Generator.package2path(_packageName) + "/" + serviceName + ".java");
		generateFromTemplate(data, filePath, ServiceConstant.SERVICE_IMPL_TEMPLATE);
	}
	
	private static void generateDAO(Map<String, Object> map, String packageName, String entityName) {
		FreeMarkDAOModel daoModel = new FreeMarkDAOModel();
		daoModel.setBasePackage(packageName);
		
		String daoInterfaceName = entityName + "Mapper";
		String _packageName = packageName + ".dao";
		daoModel.setDaoInterfaceName(daoInterfaceName);
		daoModel.setPackageName(_packageName);

		daoModel.setEntityName(entityName);
		daoModel.setObjectName(uncapitalize(entityName));
		daoModel.setColumns(((FreeMarkEntityModel)map.get("model")).getColumns());

		Map<String, Object>  data = new HashMap<String, Object>();
		data.put("model", daoModel);
		String filePath = new String(ModuleEnum.DAO.path() + BaseConstant.PROJECT_JAVA_PATH + Generator.package2path(_packageName) + "/" + daoInterfaceName + ".java");
		generateFromTemplate(data, filePath, DAOConstant.DAO_INTERFACE_TEMPLATE);
		
	}
	
	/**
	 * 调用并生成
	 * @param pro
	 * @throws SQLException
	 */
	protected static void createGenerator(Properties pro) throws SQLException {
		List<Table> tableList = getTables(pro);
		for(Table table : tableList){
			if(table.getTableName()!=null && !"".equals(table.getTableName())
					&& !"".equals(table.getTableName().trim())){
				createGenerator(table.getTableName(),table.getTableComment(),pro);
			}
		}
	}

	
}
