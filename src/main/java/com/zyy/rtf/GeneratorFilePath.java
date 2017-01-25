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

public class GeneratorFilePath {
	private static String projectPath = "src/target-source/"+BaseConstant.PROJECT_NAME;
	private static FreeMarkEntityModel model;

	public static String create(FreeMarkEntityModel model) {
		GeneratorFilePath.model =  model;
		Set<String> set = new HashSet<>();
		String packageName = model.getPackageName();
		createDaoPath(set, projectPath, packageName);//dao module
		createWebPath(set, projectPath, packageName);//web module
		createServicePath(set, projectPath, packageName);//service module
		createCommonPath(set, projectPath, packageName);//common module
		return FileUtil.createPath(set) ? projectPath : "";
	}

	private static void createCommonPath(Set<String> set, String projectPath, String packageName) {
		set.add(projectPath + "/" + BaseConstant.PROJECT_NAME + "-common/" + BaseConstant.PROJECT_JAVA_PATH + Generator.package2path(packageName));//service module
		copyCommonFile(projectPath + "/" + BaseConstant.PROJECT_NAME + "-common/" + BaseConstant.PROJECT_JAVA_PATH , packageName);
	}

	private static void copyCommonFile(String targetPath, String packageName) {
		String voPath = "src/main/resources/template/vo/";
		String utilsPath = "src/main/resources/template/utils/";
		String mybatisPath = "src/main/resources/template/mybatis/";
		Map<String, Object> map = new HashMap<>();
		map.put("packageName", packageName);
		map.put("model", model);
		FileUtil.copyFiles(map, voPath, targetPath + Generator.package2path(packageName)+"/vo/");
		FileUtil.copyFiles(map, utilsPath, targetPath + Generator.package2path(packageName)+"/utils/");
		FileUtil.copyFiles(map, mybatisPath, targetPath + Generator.package2path(packageName)+"/mybatis/");
	}

	private static void createServicePath(Set<String> set, String projectPath, String packageName) {
		set.add(projectPath + "/" + BaseConstant.PROJECT_NAME + "-service/" + BaseConstant.PROJECT_JAVA_PATH + Generator.package2path(packageName));//service module
	}

	private static void createWebPath(Set<String> set, String projectPath, String packageName) {
		set.add(projectPath + "/" + BaseConstant.PROJECT_NAME + "-web/" + BaseConstant.PROJECT_JAVA_PATH + Generator.package2path(packageName));
		set.add(projectPath + "/" + BaseConstant.PROJECT_NAME + "-web/" + BaseConstant.PROJECT_RESOURCE_PATH + "/props");
		set.add(projectPath + "/" + BaseConstant.PROJECT_NAME + "-web/" + BaseConstant.PROJECT_RESOURCE_PATH + "/spring");
		set.add(projectPath + "/" + BaseConstant.PROJECT_NAME + "-web/" + BaseConstant.PROJECT_WEB_PATH );
		copyWebFile(packageName);
	}

	private static void copyWebFile(String packageName) {
		Map<String,Object> data = new HashMap<>();
		data.put("packageName",packageName);
		data.put("entity", GeneratorFilePath.model.getEntityName());
		data.put("model", model);
		String webFilePath = "src/template-source/webapp/";
		String resourcePath = "src/main/resources/template/resources/";
		String viewPath = "src/main/resources/template/view/";
		FileUtil.copyFiles(webFilePath, projectPath + "/" + BaseConstant.PROJECT_NAME + "-web/" + BaseConstant.PROJECT_WEB_PATH );
		FileUtil.copyFiles(data, resourcePath, projectPath + "/" + BaseConstant.PROJECT_NAME + "-web/" + BaseConstant.PROJECT_RESOURCE_PATH );
		FileUtil.copyViewFiles(data, viewPath, projectPath + "/" + BaseConstant.PROJECT_NAME + "-web/" + BaseConstant.PROJECT_VIEW_PATH + StringUtil.toLowerCaseFirstOne(model.getEntityName()));
	}

	private static void createDaoPath(Set<String> set, String projectPath, String packageName) {
		set.add(projectPath + "/" + BaseConstant.PROJECT_NAME + "-dao/" + BaseConstant.PROJECT_JAVA_PATH + Generator.package2path(packageName));//dao java
		set.add(projectPath + "/" + BaseConstant.PROJECT_NAME + "-dao/" + BaseConstant.SQLMAP_MYSQL_PATH);//dao resource
		copyDaoFile(packageName);
	}

	private static void copyDaoFile(String packageName) {
		Map<String,Object> data = new HashMap<>();
		data.put("packageName",packageName);
		data.put("entity", GeneratorFilePath.model.getEntityName());
		String resourcePath = "src/main/resources/template/sqlmap/";
		FileUtil.copyFiles(data, resourcePath, projectPath + "/" + BaseConstant.PROJECT_NAME + "-dao/" + BaseConstant.PROJECT_RESOURCE_PATH );
	}

	public static String getPomPath(String name) {
		String path = name.indexOf("-") > 0 ? BaseConstant.PROJECT_NAME + "-" + name.substring(0,name.indexOf("-")) : "";
		return projectPath + "/" + path + "/pom.xml";
	}

}
