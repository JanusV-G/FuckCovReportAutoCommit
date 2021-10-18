package utils;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.tomcat.jdbc.pool.DataSource;
import org.apache.tomcat.jdbc.pool.PoolProperties;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ResourceBundle;

//静态变量配置配置信息
public class DBConnecterUtil {

    static private String dbip;
    static private String dbport;
    static private String dbName;
    static private String username;
    static private String password;
    static public DataSource ds=null;
    static private Logger logger = LoggerFactory.getLogger(DBConnecterUtil.class);

    //静态代码块加载配置信息
    static{
        logger.info("Start get JDBC connect properties");
        ResourceBundle bundle= ResourceBundle.getBundle("jdbc");
        dbip=bundle.getString("dbip");
        dbport=bundle.getString("dbport");
        dbName=bundle.getString("dbName");
        username=bundle.getString("username");
        password=bundle.getString("password");
        logger.info("dbip = {}\ndbport = {}\ndbName = {}\nusername = {}\npassword = {}"
        , dbip, dbport, dbName, username, password);


        PoolProperties poolProps=new PoolProperties();
        poolProps.setUrl(
                String.format("jdbc:mysql://%s:%s/%s?serverTimezone = GMT", dbip, dbport, dbName));
        poolProps.setDriverClassName("com.mysql.cj.jdbc.Driver");
        poolProps.setUsername(username);
        poolProps.setPassword(password);
        ds=new DataSource();
        ds.setPoolProperties(poolProps);
    }

}
