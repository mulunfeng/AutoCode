package com.zyy.rtf.constant;

import org.apache.commons.lang.StringUtils;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Created by zhangyuyang1 on 2017/1/20.
 */
public enum ModuleEnum {

    WEB("web",BaseConstant.TARGET_SOURCE_PATH + BaseConstant.PROJECT_NAME +"/"+ BaseConstant.PROJECT_NAME + "-web/"),
    DAO("dao",BaseConstant.TARGET_SOURCE_PATH + BaseConstant.PROJECT_NAME +"/"+ BaseConstant.PROJECT_NAME + "-dao/"),
    SERVICE("service",BaseConstant.TARGET_SOURCE_PATH + BaseConstant.PROJECT_NAME +"/"+ BaseConstant.PROJECT_NAME + "-service/"),
    ENTITY("entity",BaseConstant.TARGET_SOURCE_PATH + BaseConstant.PROJECT_NAME +"/"+ BaseConstant.PROJECT_NAME + "-dao/");

    private String value;
    private String modulePath;
    ModuleEnum(String value, String modulePath){
        this.value = value;
        this.modulePath = modulePath;
    }
    public String value() {
        return value;
    }
    public String path() {
        return modulePath;
    }

    public static boolean haveValue(String moduleName) {
        if (StringUtils.isBlank(moduleName))
            return false;
        for (ModuleEnum status : ModuleEnum.values()) {
            if (status.value().equals(moduleName)){
                return true;
            }
        }
        return false;
    }

    public static Map<String,String> asMap() {
        Map<String,String> result = new LinkedHashMap<>();
        for (ModuleEnum module : ModuleEnum.values()) {
            result.put(module.value, module.modulePath);
        }
        return result;
    }
}
