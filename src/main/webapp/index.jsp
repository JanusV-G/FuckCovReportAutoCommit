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

<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
</head>
<body>
	FuckCovReport 😅 AutoCommit
	<h2>FuckCovReport 😅 AutoCommit</h2>
	<p>FuckCovReport 😅 AutoCommit</p>
	<form action="userServlet" method="post">
		<p>name: <input name="uname" type="text" /> </p>
		<p>password: <input name="password" type="password"></p>
		<p>confirm password: <input name="password" type="password"></p>
		<p>email: <input name="email" type="text"></p>
		<p>api_key: <input name="api_key" type="text"> How to get this ? </p>
		<p>
			<input type="submit" name="addToAutoCommit" value="Add To AutoCommit"/>
			<input type="submit" name="DeleteFromAutoCommit" value="Delete From AutoCommit" />
		</p>
		<p>
			<input type="submit" name="CommitNow" value="Commit Now (Only For Debug)"/>
		</p>
	</form>
	<input type="button" name="ShowAutoCommitList" value="ShowAutoCommitList">
	<input type="button" name="test" value="test" id="testButton">

<script type="text/javascript" src="<%=basePath%>dist/js/index.js"></script>

</body>
</html>
