package com.zyy.rtf.util;

import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by zhangyuyang1 on 2017/1/23.
 */
public class FileUtil {

    public static boolean createPath(Set<String> set) {
        if (set == null)
            return true;

        boolean flag = true;
        for (String path : set) {
            File file = new File(path);
            if (!file.exists())
                flag = flag && file.mkdirs();
        }
        return flag;
    }

    public static void main(String[] args) {
        Set<String> set = new HashSet<String>();
        set.add("d:/aa");
        set.add("d:/cc");
        set.add("d:/bb");
        set.add("d:/bb/aa");
        set.add("d:/ee/ee");
        System.out.println(createPath(set));
    }

    public static void copyFiles(String sourcePath, String targetPath) {
        File targetFilePath = new File(targetPath);
        if (!targetFilePath.exists())
            targetFilePath.mkdirs();
        try {
            FileUtils.copyDirectory(new File(sourcePath), targetFilePath);
        } catch (IOException e) {
            throw new RuntimeException("拷贝文件失败");
        }
    }

}
