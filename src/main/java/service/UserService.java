package service;

import utils.userInfoJsonWrapperUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import dao.UserDao;
//import dao.TestDao;
//import dao.UsersDao;
import entity.User;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import utils.LoggerUtil;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.regex.Pattern;

public class UserService {
    private final UserDao ud = new UserDao();
    private final Logger logger = LoggerFactory.getLogger(UserService.class);

    /**
     * @param target 所操作的用户
     * @return 0 = add/update success, 1 = add/update failed, search detail in log
     */
    public int addOrUpdateUser(User target) {
        int ans;
        if (checkUser(target.getStudent_number())) {
            logger.info("User={} student_number={} already exists! \nUpdate user",
                    target.getUser_name(), target.getStudent_number());
            ans = updateUser(target);
        } else {
            logger.info("User={} student_number={} not exists! \nAdd user",
                    target.getUser_name(), target.getStudent_number());
            ans = addUser(target);
        }
        return ans;
    }

    /**
     * 检测user是否存在
     * @param student_number 需要检测的用户学号
     * @return true = user exist, false = user not exist
     */
    public boolean checkUser(String student_number) {
        List<User> users = ud.search("student_number", student_number);
        return users != null && users.size() > 0;
    }

    /**
     * 更新指定用户信息
     * @param target 需要更新的用户
     * @return 0 = update success, 1 = update failed, search detail in log
     */
    public int updateUser(User target) {
        int row = ud.update(target);
        if (row == 1) {
            logger.info("Update user success! student_name = {}", target.getStudent_number());
            return 0;
        } else {
            logger.error("Update user failed! student_name = {}", target.getStudent_number());
            return 1;
        }
    }

    /**
     * 添加新用户
     * @param newUser 将要添加的用户
     * @return 0 = add success, 1 = Add failed, search detail in log
     */
    public int addUser(User newUser) {
        int row = ud.add(newUser);
        if (row != 1) {
            logger.error("Add user failed! student_name = {}", newUser.getStudent_number());
//                System.out.printf("Add user failed\n");
            return 1;
        } else {
            logger.info("Add user success! student_name = {}", newUser.getStudent_number());
//                System.out.printf("Add user success\n");
            return 0;
        }
    }

    /**
     * @param target 需要删除的用户
     * @return 0 = add success, 1 = Add failed, search detail in log, 2 = user is not exists
     */
    public int deleteUser(User target) {

        if (checkUser(target.getStudent_number())) {
            int row = ud.delete(target);
            if (row != 1) {
                logger.error("Delete user failed! student_number = {}", target.getStudent_number());
//                System.out.printf("Delete user failed\n");
                return 1;
            } else {
                logger.info("Delete user success! student_number = {}", target.getStudent_number());
//                System.out.printf("Delete user success\n");
                return 0;
            }
        } else {

            logger.info("User is not exists! student_number = {}", target.getStudent_number());
//            System.out.printf("User %s is not exists!\n");
            return 2;
        }
    }

    /**
     *
     * @param target 目标登录的用户
     * @return null = failed (notAdmin or userNotFount or passwordErrro)  notNull = success,
     * return allUser
     */
    public List<User> showAutoCommitList(User target) {
        String admin = "1002181118";
        if (!target.getStudent_number().equals(admin)) {
            logger.warn("User is not Admin! student_number = {}", target.getStudent_number());
            return null;
        }

        List<User> userList = findUser(target.getStudent_number());

        if (userList == null || userList.size() <= 0) {
            logger.warn("User not found! student_number = {}", target.getStudent_number());
            return null;
        } else if (!userList.get(0).getPassword().equals(target.getPassword())) {
            logger.warn("User password error! student_number = {}, password = {}",
                    target.getStudent_number(), target.getPassword());
            return null;
        } else {
            return showAllUser();
        }
    }

    /**
     * 立即提交当前用户的打卡信息
     * @param target 当前提交的用户
     * @return 0 = success , 1 = failed
     */
    public int commitNow(User target) {
        InputStream jsonConfigTemplateFile = null;
        OutputStream jsonConfigFile = null;
        try {
            //更新 Config.json 信息
            //打开并读取config.json配置文件
            jsonConfigTemplateFile =
                    new FileInputStream(userInfoJsonWrapperUtil.jsonConfigTemplatePath);
            String jsonConfigTemplateString = IOUtils.toString(jsonConfigTemplateFile, StandardCharsets.UTF_8);
            JSONObject jsonObject = JSON.parseObject(jsonConfigTemplateString);
//            System.out.println(JSON.toJSONString(jsonObject, SerializerFeature.PrettyFormat));

            //修改config.json配置信息
            jsonObject.put("username", target.getUser_name());
            jsonObject.put("password", target.getPassword());
            jsonObject.put("push_api", String.format("https://sctapi.ftqq.com/%s.send",
                    target.getApi_key()));
//            System.out.println(JSON.toJSONString(jsonObject, SerializerFeature.PrettyFormat));

            //写回config.json
            jsonConfigFile = new FileOutputStream(userInfoJsonWrapperUtil.jsonConfigPath);
            jsonConfigFile.write(JSON.toJSONString(jsonObject, SerializerFeature.PrettyFormat).getBytes(StandardCharsets.UTF_8));
            jsonConfigFile.close();


            //运行python 自动提交脚本
            ProcessBuilder processBuilder = new ProcessBuilder();
            processBuilder.command(userInfoJsonWrapperUtil.pythonPath,
                    userInfoJsonWrapperUtil.autoCommitScript, target.getEmail());
            processBuilder.redirectErrorStream(true);   //stdout & stderr 合并读取
            Process process = processBuilder.start();

            //读取输出流
            InputStream inputStream=process.getInputStream();
            InputStreamReader reader=new InputStreamReader(inputStream);
            BufferedReader bf=new BufferedReader(reader);
            StringBuilder procOutput=new StringBuilder();
            String tempStr="";
            while((tempStr=bf.readLine())!=null){
                procOutput.append(tempStr);
            }
            tempStr=procOutput.toString();

            //判定py脚本执行结果, 这里用了个很笨的方法, 搜索到关键字
            boolean matchAns= Pattern.matches(".*Login status: Succeeded.*", tempStr);
            logger.info("python script Execution result :\n{}", tempStr);
            logger.info("matchAns = "+matchAns);
            //清理
            inputStream.close();
            reader.close();

            if(matchAns){
                return 0;
            }else{
                return 1;
            }

        } catch (FileNotFoundException e) {
            logger.error("FileNotFoundException \n" + LoggerUtil.getStackTraceString(e));
            return 1;
        } catch (IOException e) {
            logger.error("IOException\n" + LoggerUtil.getStackTraceString(e));
            return 1;
        }
    }

    /**
     * 将用户信息打包成JSON并返回
     * 之前测试的遗留函数, 并不使用
     * @param users
     * @return
     */
    public JSONObject packUsersToJson(List<User> users) {
        JSONObject jsonObject = new JSONObject();
        JSONObject tempJsonObject;

        int i = 0;
        for (User tempUser : users) {
            tempJsonObject = new JSONObject();
            tempJsonObject.put("user_name", tempUser.getUser_name());
            tempJsonObject.put("student_number", tempUser.getStudent_number());
            tempJsonObject.put("password", tempUser.getPassword());
            tempJsonObject.put("email", tempUser.getEmail());
            tempJsonObject.put("api_key", tempUser.getApi_key());
            jsonObject.put(Integer.toString(i++), tempJsonObject);
        }

        return jsonObject;
    }

    public List<User> showAllUser() {
        return ud.searchAllUser();
    }

    public List<User> findUser(String student_number) {
        return ud.search("student_number", student_number);
    }

    public static void main(String[] args) {
    }
}
