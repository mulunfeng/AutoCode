package com.zyy.rtf.util;

import com.zyy.rtf.constant.EntityConstant;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.HashSet;
import java.util.Map;
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

    /**
     * 把源目录的所有文件拷贝到目标目录中
     * @param sourcePath
     * @param targetPath
     */
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

    /**
     * 拷贝文件
     * @param sourcePath
     * @param targetPath
     */
    public static void copyFile(String sourcePath, String targetPath) {
        String targetPathStr = targetPath.replaceAll("\\\\","/");
        File targetFile = new File(targetPath);
        File targetFilePath = new File(targetPathStr.substring(0, targetPathStr.lastIndexOf("/")));
        if (!targetFilePath.exists()){
            if (targetFilePath.mkdirs()){
                try {
                    if (!new File(targetPath).createNewFile()){
                        return;
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        File sourceFile = new File(sourcePath);
        if (!sourceFile.exists())
            return;

        try {
            FileUtils.copyFile(sourceFile, targetFile);
        } catch (IOException e) {
            throw new RuntimeException("拷贝文件失败");
        }
    }



    /**
     * 把源目录的所有文件拷贝到目标目录中，替换模板中的数据
     * @param data
     * @param sourcePath
     * @param targetPath
     */
    public static void copyFiles(Map<String, Object> data, String sourcePath, String targetPath) {
        File targetFilePath = new File(targetPath);
        if (!targetFilePath.exists())
            targetFilePath.mkdirs();

        File sourcceFilePath = new File(sourcePath);
        if (!sourcceFilePath.exists())
            return;

        File[] files = sourcceFilePath.listFiles();
        if (files == null || files.length == 0)
            return;

        for (File file : files) {
            String path = file.getAbsolutePath();
            if (file.isFile()) {
                String fileType = path.substring(path.lastIndexOf(".")+1, path.length());
                String tempPath = file.getPath().substring(file.getPath().indexOf("template")+8);
                if ("ftl".equals(fileType)){
                    generateFromTemplate(data, (targetPath +"/"+ file.getName()).replace(".ftl","").replace("\\","/"), tempPath);
                }else {
                    FileUtil.copyFile(file.getAbsolutePath(), targetPath +"/"+ file.getName());
                }
            } else {
                copyFiles(data, path, targetPath + path.substring(path.lastIndexOf("\\")+1, path.length()));
            }
        }
    }

    protected static void generateFromTemplate(Map data, String outFileName, String templateName) {
        try {
            //获取输出文件地址
            String genFileDir=outFileName.substring(0, outFileName.lastIndexOf("/"));

            Configuration cfg = ConfigurationHelper.getConfiguration(EntityConstant.ENTITY_TEMPLATE_DIR);

            //加载模板
            if (templateName.contains(EntityConstant.ENTITY_TEMPLATE_DIR)){

            }
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

    public static void copyViewFiles(Map<String, Object> data, String sourcePath, String targetPath) {
        File targetFilePath = new File(targetPath);
        if (!targetFilePath.exists())
            targetFilePath.mkdirs();

        File sourcceFilePath = new File(sourcePath);
        if (!sourcceFilePath.exists())
            return;

        File[] files = sourcceFilePath.listFiles();
        if (files == null || files.length == 0)
            return;

        for (File file : files) {
            String path = file.getAbsolutePath();
            if (file.isFile()) {
                String fileType = path.substring(path.lastIndexOf(".")+1, path.length());
                String tempPath = file.getPath().substring(file.getPath().indexOf("template")+8);
                String webFilePath = (targetPath +"/"+ file.getName()).replace(".ftl","").replace("\\","/");
                webFilePath = getViewPath(data, webFilePath);
                if ("ftl".equals(fileType)){
                    generateFromTemplate(data, webFilePath, tempPath);
                }else {
                    FileUtil.copyFile(file.getAbsolutePath(), webFilePath);
                }
            } else {
                copyFiles(data, path, targetPath + path.substring(path.lastIndexOf("\\")+1, path.length()));
            }
        }
    }

    private static String getViewPath(Map<String, Object> data, String webFilePath) {
        String prefix = webFilePath.substring(webFilePath.lastIndexOf("."), webFilePath.length());
        return webFilePath.substring(0, webFilePath.lastIndexOf(".")) +"-"+ StringUtil.toLowerCaseFirstOne((String) data.get("entity")) + prefix;
    }
}
