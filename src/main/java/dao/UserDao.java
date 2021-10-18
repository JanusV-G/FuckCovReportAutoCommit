package dao;

import entity.User;
import utils.LoggerUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import utils.DBConnecterUtil;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.QueryRunner;

import java.sql.SQLException;
import java.util.List;

public class UserDao {


    static private String tablename = "user";
    private Logger logger = LoggerFactory.getLogger(UserDao.class);

    private String sql = null;
    //数据库连接任务由单独的Utils控制
    private QueryRunner queryRunner = new QueryRunner(DBConnecterUtil.ds);

    /**
     * 添加用户
     * @param target 目标用户
     * @return  返回影响的行数
     */
    public int add(User target) {
        sql = String.format("INSERT INTO `%s` (user_name, student_number, password, email, " +
                "api_key)" +
                "VALUES(?,?,?,?,?)", tablename);
        int row = 0;

        try {
            row = queryRunner.update(sql, target.getUser_name(), target.getStudent_number(),
                    target.getPassword(), target.getEmail(), target.getApi_key());
        } catch (SQLException e) {
            logger.error(LoggerUtil.getStackTraceString(e));
//            e.printStackTrace();
        }
        return row;
    }

    /**
     * 删除用户
     * @param target 目标用户
     * @return  返回影响的行数
     */
    public int delete(User target) {
        sql = String.format("DELETE FROM %s WHERE student_number=?", tablename);
        int row = 0;
        try {
            row = queryRunner.update(sql, target.getStudent_number());
        } catch (SQLException e) {
            logger.error(LoggerUtil.getStackTraceString(e));
        }
        return row;
    }

    /**
     * 更新用户
     * @param target 目标用户
     * @return  返回影响的行数
     */
    public int update(User target){
        sql = String.format("UPDATE `%s` SET user_name=?, password=?, email=?, api_key=? " +
                        "WHERE student_number=?",
                tablename);
        int row=0;
        try {
            row=queryRunner.update(sql, target.getUser_name(), target.getPassword(), target.getEmail()
                    , target.getEmail(), target.getStudent_number());
        } catch (SQLException e) {
            logger.error(LoggerUtil.getStackTraceString(e));
        }
        return row;
    }

    /**
     * 按照任意关键字查找用户
     * @param keyword   关键字
     * @param value     值
     * @return          返回查找的用户List
     */
    public List<User> search(String keyword, String value) {
        sql = String.format("SELECT * FROM `%s` WHERE %s=?", tablename, keyword);
        List<User> users = null;
        try {
            users = queryRunner.query(sql, new BeanListHandler<User>(User.class), value);
        } catch (SQLException e) {
            logger.error(LoggerUtil.getStackTraceString(e));
        }
        return users;
    }

    /**
     * 查找所有用户
     * @return  返回查找的List
     */
    public List<User> searchAllUser(){
        sql=String.format("SELECT * FROM `%s`", tablename);
        List<User> users = null;
        try {
            users = queryRunner.query(sql, new BeanListHandler<User>(User.class));
        } catch (SQLException e) {
            logger.error(LoggerUtil.getStackTraceString(e));
        }
        return users;
    }

    //数据库单元测试
    public static void main(String args[]) {

    }

}
