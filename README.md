# FuckCovReportAutoCommit
中国地质大学(北京) 疫情期间每日健康打卡, JavaWeb版





项目整体上分为2个部分:

1. JavaWeb部分的用户系统

2. python部分的自动提交

   本部分在 hanrc97大佬 的基础上进行修改

   > 项目地址:
   >
   > https://github.com/hanrc97/FucknCoVReport



JavaWeb仅仅是对用户进行管理

真正实现自动提交还是得靠py脚本



## 项目目录结构:

![image-20211018223953722](https://gitee.com/JanusV/typora-pic-bed/raw/master/img/image-20211018223953722.png)

1. sqlBuild

   对应数据库建表的 `.sql` 脚本

2. pyScript

   对应执行提交的py脚本

3. 其余都是IDEA项目目录



# 配置文件



## JavaWeb部分:



运行项目仅需要修改这3个配置文件:

![image-20211018223624347](https://gitee.com/JanusV/typora-pic-bed/raw/master/img/image-20211018223624347.png)

1. jdbc.properties

   jdbc连接配置, 对应到mysql

   ![image-20211018223709467](https://gitee.com/JanusV/typora-pic-bed/raw/master/img/image-20211018223709467.png)

   

2. jsonPath.properties

   本部分专供commitNow, 填入py脚本目录下的配置文件与py脚本

   ![image-20211018223901490](https://gitee.com/JanusV/typora-pic-bed/raw/master/img/image-20211018223901490.png)

   - jsonConfigPath: 对应pyScript/config.json
   - jsonConfigTemplatePath: 对应pyScript/configTemplate.json
   - pythonPath: 对应系统的python命令路径
   - AutoCommitScript: 对应单次提交脚本, pyScript/FuckCoVReport.py

3. log4j.properties

   log4j 配置, 根据需求自行修改, 一般只需要修改日志文件输出路径





## python Script部分:

![image-20211018224607720](https://gitee.com/JanusV/typora-pic-bed/raw/master/img/image-20211018224607720.png)

1. configPath.py

   对应脚本运行的配置文件路径:

   ![image-20211018224638924](https://gitee.com/JanusV/typora-pic-bed/raw/master/img/image-20211018224638924.png)

   使用绝对路径, 对应到pyScript/下的相应文件即可

2. databaseConfig.py

   py连接数据库的配置文件

   ![image-20211018224757029](https://gitee.com/JanusV/typora-pic-bed/raw/master/img/image-20211018224757029.png)

3. FuckCovReport.py

   单次提交打卡信息脚本

   如果需要SMTP邮件接收打卡信息, 则需要填入SMTP信息

   ![image-20211018225109105](https://gitee.com/JanusV/typora-pic-bed/raw/master/img/image-20211018225109105.png)

































