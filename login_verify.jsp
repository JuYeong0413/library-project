<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%
	String userID = request.getParameter("userID");
	String userPassword = request.getParameter("userPassword");

	Connection myConn = null;
	Statement stmt = null;
	String mySQL = null;

	String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:DBLAB";
	String user = "ST2016111540";
	String passwd = "ST2016111540";
	String dbdriver = "oracle.jdbc.OracleDriver";

	Class.forName(dbdriver);
	myConn = DriverManager.getConnection (dburl, user, passwd);
	stmt = myConn.createStatement();

	mySQL = "select user_id, name from users where user_id='" + userID + "' and password='" + userPassword + "'";

	ResultSet myResultSet = stmt.executeQuery(mySQL);

	if (myResultSet.next()) {
		session.setAttribute("user", userID);
    session.setAttribute("name", myResultSet.getString("name"));
		response.sendRedirect("main.jsp");
	} else {
%>
<script>
	alert("사용자아이디 혹은 암호가 틀렸습니다");
	location.href = "login.jsp";
</script>
<%
	}
	stmt.close();
	myConn.close();
%>
