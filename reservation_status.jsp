<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
	<head>
		<title>예약현황조회</title>
	<head>
	<body>
	<%@ include file="top.jsp" %>
	<% if (session_id == null) response.sendRedirect("login.jsp"); %>

		<table width="75%" align="center" border>
			<tr>
				<th>제목</th>
				<th>저자</th>
				<th>출판사</th>
				<th>반납예정일</th>
        <th>순번</th>
        <th>예약취소</th>
			</tr><br>
	<%
    Connection myConn = null;
    ResultSet myResultSet = null;
    String mySQL = "";
    String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
    String user = "ST2016111540";
    String passwd = "ST2016111540";
    String dbdriver = "oracle.jdbc.driver.OracleDriver";

    try {
      Class.forName(dbdriver);
      myConn = DriverManager.getConnection(dburl, user, passwd);
    } catch (SQLException ex) {
      System.err.println("SQLException: " + ex.getMessage());
    }

    mySQL = "select b.book_id, b.title, b.author, b.publisher, l.return_schedule, r.r_order from books b join lend l on l.book_id = b.book_id join reservation r on r.book_id = l.book_id and r.user_id ='" + session_id + "'";

    Statement stmt = myConn.createStatement();
    myResultSet = stmt.executeQuery(mySQL);

    if (myResultSet != null) {
      while (myResultSet.next()) {
        String book_id = myResultSet.getString("book_id");
        String title = myResultSet.getString("title");
        String author = myResultSet.getString("author");
        String publisher = myResultSet.getString("publisher");
        String return_schedule = myResultSet.getString("return_schedule").split("\\s+")[0];
        int order = myResultSet.getInt("r_order");
	%>
			<tr>
				<td align="center"><%= title %></td>
        <td align="center"><%= author %></td>
        <td align="center"><%= publisher %></td>
        <td align="center"><%= return_schedule %></td>
        <td align="center"><%= order %></td>
        <td align="center"><a href="cancel.jsp?book_id=<%= book_id %>">예약취소</a></td>
<%
      }
    }
    stmt.close();
    myConn.close();
%>
			</tr>
		</table>
	</body>
</html>
