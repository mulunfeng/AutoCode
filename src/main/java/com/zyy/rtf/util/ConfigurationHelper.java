package com.zyy.rtf.util;

import freemarker.template.Configuration;

import java.io.File;
import java.io.IOException;
import java.util.Locale;


/**
 * freeMarker模板设置
 */
public class ConfigurationHelper {
	
	private static Configuration cfg = new Configuration();
	
	
	public static Configuration getConfiguration(String templateDir) throws IOException{
	        File templateDirFile = new File(templateDir);
	        cfg.setDirectoryForTemplateLoading(templateDirFile);
	        cfg.setLocale(Locale.CHINA);
	        cfg.setDefaultEncoding("UTF-8");
		return cfg;
	}
}
