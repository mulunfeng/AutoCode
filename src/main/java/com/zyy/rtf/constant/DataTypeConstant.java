package com.zyy.rtf.constant;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by zhangyuyang1 on 2017/1/20.
 */
public class DataTypeConstant {
    public static Map<String,String> DATA_TYPE_IMPORT_MAP = new HashMap<>();
    static {
        DATA_TYPE_IMPORT_MAP.put("Date","java.util.Date");
        DATA_TYPE_IMPORT_MAP.put("Integer",null);
        DATA_TYPE_IMPORT_MAP.put("String",null);
        DATA_TYPE_IMPORT_MAP.put("Long",null);
        DATA_TYPE_IMPORT_MAP.put("Float",null);
        DATA_TYPE_IMPORT_MAP.put("Double",null);
    }

    public static Map<String,String> DATA_TYPE_TRANS_MAP = new HashMap<>();
    static {
        DATA_TYPE_TRANS_MAP.put("Integer","Integer.parseInt(");
        DATA_TYPE_TRANS_MAP.put("Long","Long.parseLong(");
        DATA_TYPE_TRANS_MAP.put("Float","Float.parseFloat(");
        DATA_TYPE_TRANS_MAP.put("Double","Double.parseDouble(");
    }
}
