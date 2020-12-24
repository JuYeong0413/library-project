<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
	<head><title>도서 대출</title></head>
	<body>
	<%
		String book_id = request.getParameter("book_id");
		String user_id = request.getParameter("user_id");

		Connection myConn = null;
		String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
		String user = "ST2016111540";
		String passwd = "ST2016111540";
		String dbdriver = "oracle.jdbc.driver.OracleDriver";
		Statement stmt = null;
		String mySQL = null;

		String result = null;

		try {
			Class.forName(dbdriver);
			myConn = DriverManager.getConnection(dburl, user, passwd);
			stmt = myConn.createStatement();
		} catch (SQLException ex) {
			System.err.println("SQLException : " + ex.getMessage());
		}

		CallableStatement cstmt = myConn.prepareCall("{ call InsertLend(?, ?, ?) }");
		cstmt.setString(1, book_id);
		cstmt.setString(2, user_id);
		cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);

		try {
			cstmt.execute();
      result = cstmt.getString(3);
	%>
	<script>
    alert("<%= result %>");
		location.href = "books.jsp";
	</script>
	<%
		} catch (SQLException ex) {
			System.err.println("SQLException : " + ex.getMessage());
		} finally {
			if (cstmt != null)
				try {
					myConn.commit();
					cstmt.close();
					myConn.close();
				} catch (SQLException ex) {

				}
		}
	%>
	</body>
</html>
