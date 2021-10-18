package utils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.util.ResourceBundle;
import java.util.regex.Pattern;

public class userInfoJsonWrapperUtil {
    static public String jsonConfigPath;
    static public String jsonConfigTemplatePath;
    static public String pythonPath;
    static public String autoCommitScript;
    static private Logger logger = LoggerFactory.getLogger(userInfoJsonWrapperUtil.class);

    static {
        logger.info("start load jsonConfigPath......");
        ResourceBundle bundle = ResourceBundle.getBundle("jsonPath");
        jsonConfigPath = bundle.getString("jsonConfigPath");
        jsonConfigTemplatePath = bundle.getString("jsonConfigTemplatePath");
        pythonPath = bundle.getString("pythonPath");
        autoCommitScript = bundle.getString("autoCommitScript");

        logger.info("jsonConfigPath load complete!\njsonConfigPath = {}\njsonConfigTemplatePath =" +
                " {}\npythonPath = {}", jsonConfigPath, jsonConfigTemplatePath, pythonPath);
    }

    static public void main(String[] args) {

    }
}
