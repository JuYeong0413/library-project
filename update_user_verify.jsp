<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head><title>회원정보수정</title></head>
<body>
<%
	String user_id = request.getParameter("user_id");

	String phone = new String(request.getParameter("phone"));
	String address = new String(request.getParameter("address").getBytes("8859_1"),"utf-8");
	String email = new String(request.getParameter("email"));
	String password = new String(request.getParameter("password"));

	Connection myConn = null;
	Statement stmt = null;
	String mySQL = "";

	String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
	String user="ST2016111540";
	String passwd="ST2016111540";
	String dbdriver = "oracle.jdbc.driver.OracleDriver";

	try {
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection (dburl, user, passwd);
		stmt = myConn.createStatement();
	} catch(SQLException ex) {
		System.err.println("SQLException: " + ex.getMessage());
	}

  mySQL = "update users ";
	mySQL = mySQL + " set phone ='" + phone + "' , " ;
	mySQL = mySQL + " address ='" + address + "' , " ;
	mySQL = mySQL + " email ='" + email + "' , " ;
	mySQL = mySQL + " password ='" + password + "' where user_id='" + user_id + "' ";

	try {
		stmt.executeQuery(mySQL);
%>

<script>
	alert("회원 정보가 수정되었습니다.");
	location.href="update_user.jsp";
</script>
<%
	} catch(SQLException ex) {
		String sMessage;
    if (ex.getErrorCode() == 20012) sMessage="연락처에는 숫자만 입력해야 합니다.";
		else if (ex.getErrorCode() == 20013) sMessage="암호는 4자리 이상이어야 합니다.";
		else if (ex.getErrorCode() == 20014) sMessage="암호에 공란은 입력되지 않습니다.";
		else sMessage="잠시 후 다시 시도하십시오";
%>
<script>
	alert("<%= sMessage %>");
	location.href = "update_user.jsp";
</script>
<%
	} finally {
		if (stmt != null)   try { 	stmt.close();  myConn.close(); }
		catch(SQLException ex) { }
	}
%>
</body></html>
