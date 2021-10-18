<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    //获取项目名
    String path = request.getContextPath();
//服务器根路径:
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
//后台服务器路径:
    String backgroundPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/" + "admin/";
//上传的图片路径
    String picPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/" + "image/";
//上传的视频路径:
    String videosPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/" + "videos/";
//上传的资料路径:
    String dataPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/" + "data/";

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Fuck Cov Report Auto Commit</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="<%=basePath%>plugins/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet"
          href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- icheck bootstrap -->
    <link rel="stylesheet" href="<%=basePath%>plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="<%=basePath%>dist/css/adminlte.min.css">
    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700"
          rel="stylesheet">
</head>
<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">
        FuckCovReport<br>
        😅<br>
        AutoCommit
    </div>
    <!-- /.login-logo -->
    <div class="card">
        <div class="card-body login-card-body">
            <p class="login-box-msg">End this Fu😅king Report</p>
<%--            <p class="login-box-msg">End this Fu😅king Report</p>--%>
            <button class="btn btn-block btn-info btn-xs" id="DisclaimerButton" name="DisclaimerButton"
               onclick="showDisclaimer()">
                免责声明（Disclaimer）</button>
            <p></p>
            <div id="Disclaimer"></div>
            <form action="userServlet?method=login" method="post" id="form">
                <%--                username--%>
                <div class="input-group mb-3">
                    <input name="username" type="text" class="form-control"
                           placeholder="User Name" id="userName">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-user"></span>
                            <%--                            <span class="fas fa-envelope"></span>--%>
                        </div>
                    </div>
                </div>

                <%--                studentnumber--%>
                <div class="input-group mb-3">
                    <input name="studentNum" type="number" class="form-control"
                           placeholder="Sutdent Number" id="studentNum">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-user"></span>
                            <%--                            <span class="fas fa-envelope"></span>--%>
                        </div>
                    </div>
                </div>
                <%--                password--%>
                <div class="input-group mb-3">
                    <input name="password" type="password" class="form-control"
                           placeholder="Password" id="password">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-lock"></span>
                        </div>
                    </div>
                </div>
                <%--                confirm password--%>
                <div class="input-group mb-3">
                    <input name="confirm password" type="password" class="form-control"
                           placeholder="Confirm Password" id="confirmPassword"
                           onblur="confirmPasswordFun()">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-lock"></span>
                        </div>
                    </div>
                </div>
                <%--                email--%>
                <div class="input-group mb-3">
                    <input name="email" type="email" class="form-control" placeholder="Email"
                           id="email" onblur="checkEmailFormat()">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-envelope"></span>
                        </div>
                    </div>
                </div>
                <%--                api_key--%>
                <div class="input-group mb-3">
                    <input name="api_key" type="text" class="form-control" placeholder="api_key"
                           id="api_key">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-ellipsis-h"></span>
                        </div>
                    </div>

                </div>

                <div class="row">
                    <%--                    <div class="col-8">--%>
                    <%--                        <div class="icheck-primary">--%>
                    <%--                            <input type="checkbox" id="remember">--%>
                    <%--                            <label for="remember">--%>
                    <%--                                Remember Me--%>
                    <%--                            </label>--%>
                    <%--                        </div>--%>
                    <%--                    </div>--%>
                    <!-- /.col -->
                    <%--                    <div class="col-4">--%>
                    <button type="button" name="addOrUpdateToAutoCommit"
                            class="btn btn-primary btn-block" value="addOrUpdateToAutoCommit"
                            id="addOrUpdateToAutoCommit"
                            onclick="addOrUpdateToAutoCommitSubmit()">
                        Add/Update To AutoCommit
                    </button>
                    <%--                    </div>--%>
                    <!-- /.col -->
                </div>
                <p></p>
                <div class="row">
                    <button type="button" name="DeleteFromAutoCommit"
                            class="btn btn-block btn-danger" value="DeleteFromAutoCommit", id="DeleteFromAutoCommit"
                            onclick="DeleteFromAutoCommitSubmit()">Delete From AutoCommit
                    </button>
                </div>
                <p></p>
                <p class="mb-1">
                    <a href="chineseTutorial.html">中文说明文档</a>
                </p>
                <p class="mb-1">
                    <a href="apikeyTutorial.html">如何获取 api_key ?</a>
                </p>
                <div class="social-auth-links text-center mb-3">
                    <p>- DEBUG -</p>
                    <button type="button" name="CommitNowButton"
                            class="btn btn-primary btn-block" value="CommitNow" id="CommitNowButton"
                            onclick="CommitNowSubmit()">Commit Now (Only
                        For Test)
                    </button>
                    <%--                    <button type="submit" name="ShowAutoCommitList"--%>
                    <%--                            class="btn btn-primary btn-block" value="ShowAutoCommitList"> Show Auto Commit List--%>
                    <%--                    </button>--%>
                    <%--                    <a href="#" class="btn btn-block btn-primary">--%>
                    <%--                        <i class="fab fa-facebook mr-2"></i> Sign in using Facebook--%>
                    <%--                    </a>--%>
                    <%--                    <a href="#" class="btn btn-block btn-danger">--%>
                    <%--                        <i class="fab fa-google-plus mr-2"></i> Sign in using Google+--%>
                    <%--                    </a>--%>
                </div>
                <div class="social-auth-links text-center mb-3">

                    <button type="button" name="ShowAutoCommitList"
                            class="btn btn-primary btn-block" value="ShowAutoCommitList" id="ShowAutoCommitList"
                            onclick="ShowAutoCommitListSubmit()" >
                        Show Auto
                        Commit List
                    </button>
                </div>
            </form>


            <%--            <div class="social-auth-links text-center mb-3">--%>
            <%--                <p>- OR -</p>--%>
            <%--                <a href="#" class="btn btn-block btn-primary">--%>
            <%--                    <i class="fab fa-facebook mr-2"></i> Sign in using Facebook--%>
            <%--                </a>--%>
            <%--                <a href="#" class="btn btn-block btn-danger">--%>
            <%--                    <i class="fab fa-google-plus mr-2"></i> Sign in using Google+--%>
            <%--                </a>--%>
            <%--            </div>--%>
            <!-- /.social-auth-links -->
            <%--            <p class="mb-1">--%>
            <%--                <a href="forgot-password.html">How to get the api_key ?</a>--%>
            <%--            </p>--%>
            <%--            <p class="mb-1">--%>
            <%--                <a href="forgot-password.html">I forgot my password</a>--%>
            <%--            </p>--%>
            <%--            <p class="mb-0">--%>
            <%--                <a href="register.html" class="text-center">Register a new membership</a>--%>
            <%--            </p>--%>
        </div>
        <!-- /.login-card-body -->
    </div>
</div>
<!-- /.login-box -->

<!-- jQuery -->
<script src="<%=basePath%>plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="<%=basePath%>plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="<%=basePath%>dist/js/adminlte.min.js"></script>

<%--外链JS代码分离--%>
<script type="text/javascript" src="<%=basePath%>dist/js/login.js"></script>

<%--<script type="text/javascript">--%>
<%--    function confirmPasswordFun(){--%>
<%--        var password=$("#password").val();--%>
<%--        var confirmPassword=$("#confirmPassword").val();--%>
<%--        console.log(password);--%>
<%--        console.log(confirmPassword);--%>
<%--    }--%>
<%--</script>--%>

</body>
</html>
