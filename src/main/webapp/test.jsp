
<%--
  Created by IntelliJ IDEA.
  User: JanusV
  Date: 2021/10/15
  Time: 17:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

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

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Fuck Cov Report Auto Commit List</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- jsGrid -->
    <%--    <link rel="stylesheet" href="plugins/jsgrid/jsgrid.min.css">--%>
    <%--    <link rel="stylesheet" href="plugins/jsgrid/jsgrid-theme.min.css">--%>
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
</head>
<body class="hold-transition sidebar-mini">

<p class="mb-1">
    <a href="https://sct.ftqq.com/login">中文说明文档</a>
</p>

<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- jsGrid -->
<%--<script src="plugins/jsgrid/demos/db.js"></script>--%>
<%--<script src="plugins/jsgrid/jsgrid.min.js"></script>--%>
<!-- AdminLTE App -->
<script src="dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>
<!-- page script -->
<script src="dist/js/AutoCommitList.js"></script>

<script>
    var fangtangUrl="https://sct.ftqq.com/login"
    $.ajax({
        url: "https://sct.ftqq.com/login",
        type: "get",
        // dataType: "jsonp",
        async: false,
        success: function (data) {
            alert("数据请求成功");
            console.log(data);
            // userList=$.parseJSON(data)
            // var userList=[];
            // for(var i=0;i<2;++i){
            //     // userList.
            //     userList[i]=data[i];
            // }
            // // userList=data;
            //
            //
            //
            // console.log(userList[0]);
            // console.log(userList[1]);
        },
        error: function (data) {
            alert("数据请求失败");
            console.log(data)
        }
    });

</script>


</body>
</html>

