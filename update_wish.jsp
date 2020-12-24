<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
	<head>
		<title>희망도서수정</title>
	<head>
	<body>
	<%@ include file="top.jsp" %>
	<%
    if (session_id == null) response.sendRedirect("login.jsp");

    String wish_id = request.getParameter("wish_id");

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

		mySQL = "select title, author, publisher, wish_comment from wish where wish_id='" + wish_id + "' and user_id = '" + session_id + "'";
		myResultSet = stmt.executeQuery(mySQL);

		if (myResultSet.next()) {
			String title = myResultSet.getString("title");
			String author = myResultSet.getString("author");
			String publisher = myResultSet.getString("publisher");
			String wish_comment = myResultSet.getString("wish_comment");
  %>

    <form name="update_wish" method="POST" action="update_wish_verify.jsp">
      <input type="hidden" name="wish_id" value="<%= wish_id %>">
			<input type="hidden" name="user_id" value="<%= session_id %>">
  		<table width="75%" align="center" border>
  			<tr>
  				<th>제목</th>
          <td><input type="text" name="title" size="50" value="<%= title %>"></td>
        </tr>
        <tr>
  				<th>저자</th>
          <td><input type="text" name="author" size="50" value="<%= author %>"></td>
        </tr>
        <tr>
  				<th>출판사</th>
          <td><input type="text" name="publisher" size="50" value="<%= publisher %>"></td>
  			</tr>
        <tr>
          <th>코멘트</th>
          <td>
          <% if (wish_comment != null) { %>
            <textarea name="wish_comment" placeholder="해당 도서를 희망하는 이유 등의 내용을 작성해주세요." cols="50" rows="8"><%= wish_comment %></textarea>
          <% } else { %>
            <textarea name="wish_comment" placeholder="해당 도서를 희망하는 이유 등의 내용을 작성해주세요." cols="50" rows="8"></textarea>
          <% } %>
          </td>
        </tr>
        <tr>
					<td colspan="2" align="center">
            <input type="submit" value="수정">
            <input type="button" onClick="location.href='wish.jsp'" value="취소">
          </td>
				</tr>
  		</table>
    </form>
<% } %>
	</body>
</html>
