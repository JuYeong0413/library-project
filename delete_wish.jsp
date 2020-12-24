<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head><title>희망도서삭제</title></head>
<body>
<%@ include file="top.jsp" %>
<% if (session_id == null) response.sendRedirect("login.jsp"); %>
<%
  request.setCharacterEncoding("utf-8");
	String wish_id = request.getParameter("wish_id");

	Connection myConn = null;
	Statement stmt = null;
	String mySQL = "";
  String sMessage = "";

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

  mySQL = "delete from wish where wish_id='" + wish_id + "' and user_id = '" + session_id + "'";

	try {
		stmt.executeQuery(mySQL);
%>

<script>
	alert("희망도서 신청정보가 삭제되었습니다.");
	location.href="wish.jsp";
</script>
<%
	} catch(SQLException ex) {
		sMessage = ex.getMessage();
%>
<script>
	alert("<%= sMessage %>");
	location.href = "wish.jsp";
</script>
<%
	} finally {
		if (stmt != null)   try { 	stmt.close();  myConn.close(); }
		catch(SQLException ex) { }
	}
%>
</body></html>
