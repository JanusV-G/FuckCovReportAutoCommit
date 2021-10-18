
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
<div class="wrapper">
        <!-- Main content -->
        <section class="content">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Bordered Table</h3>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th>user_name</th>
                            <th>student_name</th>
                            <th>password</th>
                            <th>email</th>
                            <th>api_key</th>
                        </tr>
                        </thead>
                        <tbody>
<%--                        <%String userList = request.getParameter("userList");%>--%>
<%--<%@ page isELIgnored="false" %>--%>
                        <c:forEach items="${userList }" var="user">
                        <tr>
                            <td>${user.user_name}</td>
                            <td>${user.student_number}</td>
                            <td>${user.password }</td>
                            <td>${user.email }</td>
                            <td>${user.api_key }</td>
<%--                            <td><span class="badge bg-danger">55%</span></td>--%>
                        </c:forEach>
<%--                        <tr>--%>
<%--                            <td>2.</td>--%>
<%--                            <td>Clean database</td>--%>
<%--                            <td>--%>
<%--                                <div class="progress progress-xs">--%>
<%--                                    <div class="progress-bar bg-warning" style="width: 70%"></div>--%>
<%--                                </div>--%>
<%--                            </td>--%>
<%--                            <td><span class="badge bg-warning">70%</span></td>--%>
<%--                        </tr>--%>
<%--                        <tr>--%>
<%--                            <td>3.</td>--%>
<%--                            <td>Cron job running</td>--%>
<%--                            <td>--%>
<%--                                <div class="progress progress-xs progress-striped active">--%>
<%--                                    <div class="progress-bar bg-primary" style="width: 30%"></div>--%>
<%--                                </div>--%>
<%--                            </td>--%>
<%--                            <td><span class="badge bg-primary">30%</span></td>--%>
<%--                        </tr>--%>
<%--                        <tr>--%>
<%--                            <td>4.</td>--%>
<%--                            <td>Fix and squish bugs</td>--%>
<%--                            <td>--%>
<%--                                <div class="progress progress-xs progress-striped active">--%>
<%--                                    <div class="progress-bar bg-success" style="width: 90%"></div>--%>
<%--                                </div>--%>
<%--                            </td>--%>
<%--                            <td><span class="badge bg-success">90%</span></td>--%>
<%--                        </tr>--%>
                    </table>
                </div>
                <!-- /.card-body -->
                <div class="card-footer clearfix">
                    <ul class="pagination pagination-sm m-0 float-right">
                        <li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
                        <li class="page-item"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
                    </ul>
                </div>
            </div>
            <!-- /.card -->
        </section>
    <!-- /.control-sidebar -->
</div>


<%--<%--%>
<%--String username = request.getParameter("username");--%>
<%--String studentNum = request.getParameter("studentNum");--%>
<%--String password = request.getParameter("password");--%>
<%--String email = request.getParameter("email");--%>
<%--String api_key = request.getParameter("api_key");--%>
<%--%>--%>
<%--<input id="user_name" name="str" value=<%=username%> type="hidden"/>--%>
<%--<input id="student_number" name="str" value=<%=studentNum%> type="hidden"/>--%>
<%--<input id="password" name="str" value=<%=password%> type="hidden"/>--%>
<%--<input id="email" name="str" value=<%=email%> type="hidden"/>--%>
<%--<input id="api_key" name="str" value=<%=api_key%> type="hidden"/>--%>

<!-- ./wrapper -->

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

<%--<script>--%>
<%--    $(function () {--%>
<%--        $("#jsGrid1").jsGrid({--%>
<%--            height: "100%",--%>
<%--            width: "100%",--%>

<%--            sorting: true,--%>
<%--            paging: true,--%>

<%--            data: db.clients,--%>

<%--            fields: [--%>
<%--                { name: "Name", type: "text", width: 150 },--%>
<%--                { name: "Age", type: "number", width: 50 },--%>
<%--                { name: "Address", type: "text", width: 200 },--%>
<%--                { name: "Country", type: "select", items: db.countries, valueField: "Id", textField: "Name" },--%>
<%--                { name: "Married", type: "checkbox", title: "Is Married" }--%>
<%--            ]--%>
<%--        });--%>
<%--    });--%>
<%--</script>--%>
</body>
</html>

