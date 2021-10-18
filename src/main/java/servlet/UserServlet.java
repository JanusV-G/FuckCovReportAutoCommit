package servlet;

import com.alibaba.fastjson.JSONObject;
import entity.User;
import utils.LoggerUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/userServlet"})
//@WebServlet("/userServlet")
public class UserServlet extends HttpServlet {

    private UserService us = new UserService();
    private Logger logger = LoggerFactory.getLogger(UserServlet.class);

    @Override
    public void init() throws ServletException {
        super.init();
        logger.info("Servlet init");
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        super.service(req, resp);

        //1、请求乱码
        req.setCharacterEncoding("UTF-8");
        //2、响应乱码
        resp.setHeader("content-type", "text/html;charset=UTF-8");

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    /**
     * 进对post进行处理, get不进行处理
     * @param request   request
     * @param response  response
     * @throws ServletException 不捕获异常
     * @throws IOException      不捕获异常
     */
    public void doPost(HttpServletRequest request,
                       HttpServletResponse response) throws ServletException, IOException {

        //1、请求乱码
        request.setCharacterEncoding("UTF-8");
        //2、响应乱码
        response.setHeader("content-type", "text/html;charset=UTF-8");

        String method=request.getParameter("method");
        logger.info("method = {}", method);

        switch (method){
            case "login":{
                methodLogin(request, response);
            }
            case "showUserList":{
            }
        }

    }

    @Override
    public void destroy() {
        super.destroy();
    }

    /**
     * 根据request获取用户信息
     * @param request   request
     * @return      返回打包好的用户信息
     */
    private User getUserInfo(HttpServletRequest request) {
        //获取user信息
        String username = request.getParameter("username");
        String studentNum = request.getParameter("studentNum");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String api_key = request.getParameter("api_key");

        // debug
        logger.info("username= {}\n" +
                        "studentNum= {}\n" +
                        "password= {}\n" +
                        "email= {}\n" +
                        "api_key= {}\n"
                , username, studentNum, password, email, api_key);

        // 封装并返回实体
        return new User(username, studentNum, password, email, api_key);
    }

    /**
     * 分流处理函数
     * @param request   request
     * @param response  response
     * @throws IOException      不捕获异常
     * @throws ServletException 不捕获异常
     */
    private void methodLogin(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        //表单 Submmit 分流
        //同一个表单的数据做不同的处理
        String flag = null;
        if (request.getParameter("addOrUpdateToAutoCommit") != null) {
            flag = request.getParameter("addOrUpdateToAutoCommit");
        } else if (request.getParameter("DeleteFromAutoCommit") != null) {
            flag = request.getParameter("DeleteFromAutoCommit");
        } else if (request.getParameter("CommitNow") != null) {
            flag = request.getParameter("CommitNow");
        } else if (request.getParameter("ShowAutoCommitList") != null) {
            flag = request.getParameter("ShowAutoCommitList");
        } else {
            logger.error("Error! Flag Null!");
        }
        logger.info("flag = {}", flag);

        //从表单中获取提交的用户信息
        User newUser = getUserInfo(request);

        //表单操作分流
        switch (flag) {
            case "addOrUpdateToAutoCommit": {
                this.addOrUpdateToAutoCommit(newUser, response);
                break;
            }
            case "DeleteFromAutoCommit": {
                this.DeleteFromAutoCommit(newUser, response);
                break;
            }
            case "CommitNow": {
                this.CommitNow(newUser, response);
                break;
            }
            case "ShowAutoCommitList": {
                this.ShowAutoCommitList(newUser, request, response);
                break;
            }
            default: {
                logger.error("Error Submit flag = {}", flag);
            }
        }
    }

    /**
     * 添加过更新用户信息
     * @param newUser   指定的用户
     * @param response  response
     * @throws IOException  不捕获异常
     */
    private void addOrUpdateToAutoCommit(User newUser, HttpServletResponse response) throws IOException {
        int ans=us.addOrUpdateUser(newUser);
        if(ans==0){
            logger.info("add or update success! student_number = {}", newUser.getStudent_number());
            response.getWriter().print(
                    "<script> alert(\" Add/Update Success !! \");" +
                            "window.location.href=\"login.jsp\"; </script>");
        }else{
            logger.error("add or update failed! student_number = {}", newUser.getStudent_number());
            response.getWriter().print(
                    "<script> " +
                            "alert(\" Add/Update Failed !! \\n Please contact the administrator\");" +
                            "window.location.href=\"login.jsp\"; " +
                            "</script>");
        }
    }

    /**
     * 删除制定用户
     * @param newUser   指定的用户
     * @param response  response
     * @throws IOException  不捕获异常
     */
    private void DeleteFromAutoCommit(User newUser, HttpServletResponse response) throws IOException {
        int ans = us.deleteUser(newUser);
        if (ans == 0) {
            response.getWriter().print(
                    "<script> alert(\" Delete Success !! \");window.location.href=\"login.jsp\"; " +
                            "</script>");
        } else if (ans == 1) {

        } else if (ans == 2) {

        } else {

        }
        return;
    }

    /**
     * 立即提交当前用户的打卡
     * 调用到Python脚本, 以参数形式传入 email
     * @param target    请求执行的用户
     * @param response  请求的response
     * @throws IOException  对异常不进行处理, 直接throw
     */
    private void CommitNow(User target, HttpServletResponse response) throws IOException {
        int ans=us.commitNow(target);
        logger.info("ans = {}", ans);
        if(ans==0){
            response.getWriter().print(
                    "<script> alert(\"Commit Success !!\\nCheck your Email or wechat \");window" +
                            ".location" +
                            ".href=\"login.jsp\"; " +
                            "</script>");
        }else if(ans==1){
            response.getWriter().print(
                    "<script> alert(\"Commit Failed !!\\nCheck your " +
                            "student_number/password/email\");" +
                            "window.location.href=\"login.jsp\"; </script>");
        }
    }

    /**
     * 显示现在服务器数据库中的提交列表
     * 需要进行身份验证, 仅仅是admin才行, admin写死
     * @param target    请求的用户
     * @param request   request
     * @param response  response
     * @throws IOException  不捕获异常, 直接throw到上层
     * @throws ServletException
     */
    private void ShowAutoCommitList(User target,
                                    HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        //调用service层方法, 并获取返回值
        List<User> userList= us.showAutoCommitList(target);

        if(userList==null){
            logger.info("ShowAutoCommitList failed! student_number = {}",
                    target.getStudent_number());
            response.getWriter().print(
                    "<script> alert(\" Failed !!\\nPermission Denied! \");" +
                            "window.location.href=\"login.jsp\"; </script>");
        }else{
            logger.info("ShowAutoCommitList success! student_number = {}",
                    target.getStudent_number());
            logger.info("list size = {}", userList.size());
            try {
                request.setAttribute("userList", userList);
                request.getRequestDispatcher("AutoCommitList.jsp").forward(request, response);
            } catch (IOException e) {
                logger.error("IOException ! \n"+LoggerUtil.getStackTraceString(e));
            }
        }
    }
}
