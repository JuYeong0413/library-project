<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
	<head>
		<title>희망도서신청</title>
	<head>
	<body>
	<%@ include file="top.jsp" %>
	<% if (session_id == null) response.sendRedirect("login.jsp"); %>

    <form name="create_wish" method="POST" action="create_wish_verify.jsp">
      <input type="hidden" name="user_id" value="<%= session_id %>">
  		<table width="75%" align="center" border>
  			<tr>
  				<th>제목</th>
          <td><input type="text" name="title" size="50"></td>
        </tr>
        <tr>
  				<th>저자</th>
          <td><input type="text" name="author" size="50"></td>
        </tr>
        <tr>
  				<th>출판사</th>
          <td><input type="text" name="publisher" size="50"></td>
  			</tr>
        <tr>
          <th>코멘트</th>
          <td><textarea name="wish_comment" placeholder="해당 도서를 희망하는 이유 등의 내용을 작성해주세요." cols="50" rows="8"></textarea></td>
        </tr>
        <tr>
					<td colspan="2" align="center">
            <input type="submit" value="신청">
            <input type="button" onClick="location.href='wish.jsp'" value="취소">
          </td>
				</tr>
  		</table>
    </form>
	</body>
</html>
