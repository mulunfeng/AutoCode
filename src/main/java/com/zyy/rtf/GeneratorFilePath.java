package com.zyy.rtf;

import com.zyy.rtf.constant.*;
import com.zyy.rtf.model.*;
import com.zyy.rtf.util.ConfigurationHelper;
import com.zyy.rtf.util.ConvertUtil;
import com.zyy.rtf.util.FileUtil;
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

	public static String create(FreeMarkEntityModel model) {
		Set<String> set = new HashSet<>();
		String packageName = model.getPackageName();
		createDaoPath(set, projectPath, packageName);//dao module
		createWebPath(set, projectPath, packageName);//web module
		createServicePath(set, projectPath, packageName);//service module
		createCommonPath(set, projectPath, packageName);//common module
		return FileUtil.createPath(set) ? projectPath : "";
	}

	private static void createCommonPath(Set<String> set, String projectPath, String packageName) {
		set.add(projectPath + "/" + BaseConstant.PROJECT_NAME + "-common" + BaseConstant.PROJECT_JAVA_PATH + Generator.package2path(packageName));//service module
	}

	private static void createServicePath(Set<String> set, String projectPath, String packageName) {
		set.add(projectPath + "/" + BaseConstant.PROJECT_NAME + "-service" + BaseConstant.PROJECT_JAVA_PATH + Generator.package2path(packageName));//service module
	}

	private static void createWebPath(Set<String> set, String projectPath, String packageName) {
		set.add(projectPath + "/" + BaseConstant.PROJECT_NAME + "-web" + BaseConstant.PROJECT_JAVA_PATH + Generator.package2path(packageName));
		set.add(projectPath + "/" + BaseConstant.PROJECT_NAME + "-web" + BaseConstant.PROJECT_RESOURCE_PATH + "/props");
		set.add(projectPath + "/" + BaseConstant.PROJECT_NAME + "-web" + BaseConstant.PROJECT_RESOURCE_PATH + "/spring");
		set.add(projectPath + "/" + BaseConstant.PROJECT_NAME + "-web" + BaseConstant.PROJECT_WEB_PATH );
		copyWebFile(projectPath + "/" + BaseConstant.PROJECT_NAME + "-web" + BaseConstant.PROJECT_WEB_PATH );
	}

	private static void copyWebFile(String targetPath) {
		String sourcePath = "src/template-source/webapp/";
		FileUtil.copyFiles(sourcePath, targetPath);
	}

	private static void createDaoPath(Set<String> set, String projectPath, String packageName) {
		set.add(projectPath + "/" + BaseConstant.PROJECT_NAME + "-dao" + BaseConstant.PROJECT_JAVA_PATH + Generator.package2path(packageName));//dao java
		set.add(projectPath + "/" + BaseConstant.PROJECT_NAME + "-dao" + BaseConstant.PROJECT_RESOURCE_PATH + "/sqlmap.mysql");//dao resource
	}

	public static String getPomPath(String name) {
		String path = name.indexOf("-") > 0 ? BaseConstant.PROJECT_NAME + "-" + name.substring(0,name.indexOf("-")) : "";
		return projectPath + "/" + path + "/pom.xml";
	}

}
