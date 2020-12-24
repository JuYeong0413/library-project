<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*"  %>
<!DOCTYPE html>
<html>
	<head>
		<title>회원정보수정</title>
	</head>
	<body>
	<%@ include file="top.jsp" %>
	<%
		if (session_id == null) response.sendRedirect("login.jsp");

		Connection myConn = null;
		Statement stmt = null;
		ResultSet myResultSet = null;
		String mySQL = "";

		String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:DBLAB";
		String user = "ST2016111540";
		String passwd = "ST2016111540";
		String dbdriver = "oracle.jdbc.driver.OracleDriver";

		try {
			Class.forName(dbdriver);
			myConn = DriverManager.getConnection(dburl, user, passwd);
			stmt = myConn.createStatement();
		} catch(SQLException ex) {
			System.err.println("SQLException: " + ex.getMessage());
		}

		mySQL = "select name, phone, address, email, password from users where user_id='" + session_id + "'";
		myResultSet = stmt.executeQuery(mySQL);

		if (myResultSet.next()) {
			String name = myResultSet.getString("name");
			String phone = myResultSet.getString("phone");
			String address = myResultSet.getString("address");
			String email = myResultSet.getString("email");
			String password = myResultSet.getString("password");
	%>
		<br>
		<form name="update_user" method="POST" action="update_user_verify.jsp">
			<input type="hidden" name="user_id" value="<%= session_id %>">
			<table width="75%" align="center" border>
				<tr>
					<th>이름</th>
					<td><input type="text" name="name" size="50" value="<%= name %>" disabled></td>
				</tr>
			 	<tr>
					<th>연락처</th>
					<td><input type="text" name="phone" size="50" value="<%= phone %>"></td>
				</tr>
			 	<tr>
			 		<th>주소</th>
			 		<td><input type="text" name="address" size="50" value="<%=address %>"></td>
				</tr>
				<tr>
			 		<th>이메일</th>
			 		<td><input type="text" name="email" size="50" value="<%= email %>"></td>
				</tr>
				<tr>
					<th>패스워드</th>
				   	<td><input type="password" name="password" size="20"  value="<%= password %>"></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
            <input type="submit" value="수정">
            <input type="button" onClick="location.href='main.jsp'" value="취소">
          </td>
				</tr>
			</table>
		</form>
	<%
		}
		stmt.close();
		myConn.close();
	%>
	</body>
</html>
