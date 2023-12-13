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
<title>네이버로그인</title>

<script type="text/javascript">
	$(document).ready(function(){
		var id = ${result}.id;
		var nickname = ${result}.properties.nickname;
		var image = ${result}.properties.profile_image;
		
		$('#id').attr('value',id);
		$('#nickname').attr('value',nickname);
		$('#image').attr('src',image);
	});
</script>
</head>
<body>
	<input id = "id" type="text"/>
	<input id = "nickname" type="text"/>
	<img id = "image" height="100" alt="">
</body>
</html>