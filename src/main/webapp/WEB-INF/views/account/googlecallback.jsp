<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<<<<<<<< HEAD:src/main/webapp/WEB-INF/views/account/googlecallback.jsp
<title>구글로그인</title>
========
<title>카카오로그인</title>
>>>>>>>> BH:src/main/webapp/WEB-INF/views/account/kakaocallback.jsp

<script type="text/javascript">
	$(document).ready(function(){
		var id = ${result}.id;
		var name = ${result}.name;
		var image = ${result}.picture;
		
		$('#id').attr('value',id);
		$('#name').attr('value',name);
		$('#image').attr('src',image);
	});
</script>
</head>
<body>
	<input id = "id" type="text"/>
<<<<<<<< HEAD:src/main/webapp/WEB-INF/views/account/googlecallback.jsp
	<input id = "name" type="text"/>
========
	<input id = "nickname" type="text"/>
>>>>>>>> BH:src/main/webapp/WEB-INF/views/account/kakaocallback.jsp
	<img id = "image" height="100" alt="">
</body>
</html>