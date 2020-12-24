<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
	<head><title>도서 대출 예약 취소</title></head>
	<body>
    <%@ include file="top.jsp" %>
    <% if (session_id == null) response.sendRedirect("login.jsp"); %>
	<%
    String book_id = request.getParameter("book_id");

    Connection myConn = null;
    ResultSet myResultSet = null;
    String mySQL = "";
    String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
    String user = "ST2016111540";
    String passwd = "ST2016111540";
    String dbdriver = "oracle.jdbc.driver.OracleDriver";
    String result = "";

    try {
      Class.forName(dbdriver);
      myConn = DriverManager.getConnection(dburl, user, passwd);
    } catch (SQLException ex) {
      System.err.println("SQLException: " + ex.getMessage());
    }

    Statement stmt = myConn.createStatement();
    mySQL = "delete from reservation where book_id = '" + book_id + "' and user_id = '" + session_id + "'";

    int res = stmt.executeUpdate(mySQL);

    if (res == 0) {
      result = "잠시 후 다시 시도하십시오.";
    } else {
      result = "도서 대출 예약 취소가 완료되었습니다.";
    }
	%>
  	<script>
      alert("<%= result %>");
  		location.href = "reservation_status.jsp";
  	</script>
	</body>
</html>
