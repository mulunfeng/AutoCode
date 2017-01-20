package com.zyy.rtf.constant;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by zhangyuyang1 on 2017/1/20.
 */
public class DataTypeConstant {
    public static Map<String,String> DATA_TYPE_IMPORT_MAP = new HashMap<String, String>();
    static {
        DATA_TYPE_IMPORT_MAP.put("Date","java.util.Date");
        DATA_TYPE_IMPORT_MAP.put("Integer",null);
        DATA_TYPE_IMPORT_MAP.put("String",null);
        DATA_TYPE_IMPORT_MAP.put("Long",null);
        DATA_TYPE_IMPORT_MAP.put("Float",null);
        DATA_TYPE_IMPORT_MAP.put("Double",null);
    }
}
