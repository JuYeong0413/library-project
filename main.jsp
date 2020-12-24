<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
	<head>
		<title>데이터베이스를 활용한 도서관 시스템입니다.</title>
	</head>
	<body>
	<%@ include file="top.jsp" %>
		<table width="75%" align="center" style="padding-top: 300px;">
		<% if (session_id != null) { %>
			<tr>
				<td align="center"><b><%= session_name %></b>님 방문을 환영합니다.</td>
			</tr>
		<% } else { %>
			<tr>
				<td align="center"><a href="login.jsp">로그인</a> 후 사용하세요.</td>
			</tr>
		<% } %>
		</table>
	</body>
</html>
