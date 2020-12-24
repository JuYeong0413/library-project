<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.util.*, libraryBean.*"%>
<!DOCTYPE html>
<html>
	<head>
		<title>희망도서목록</title>
	<head>
	<body>
	<%@ include file="top.jsp" %>
	<% if (session_id == null) response.sendRedirect("login.jsp"); %>

  <br>
  <div style="width: 75%; margin: auto;">
    <input type="button" style="width: 100%;" onClick="location.href='create_wish.jsp'" value="희망도서 신청하기">
  </div>

  <jsp:useBean id="wishMgr" class="libraryBean.WishMgr" />
	<%
    Vector vlist = wishMgr.getWishList(session_id);

		for (int i = 0; i < vlist.size(); i++) {
			Wish wish = (Wish)vlist.elementAt(i);
	%>

		<table width="75%" align="center" border>
			<tr>
				<th>제목</th>
				<th>저자</th>
				<th>출판사</th>
				<th>수정</th>
        <th>삭제</th>
			</tr><br>

			<tr>
				<td align="center"><%= wish.getTitle() %></td>
        <td align="center"><%= wish.getAuthor() %></td>
        <td align="center"><%= wish.getPublisher() %></td>
        <td align="center"><a href="update_wish.jsp?wish_id=<%= wish.getWishId() %>">수정하기</a></td>
        <td align="center"><a href="delete_wish.jsp?wish_id=<%= wish.getWishId() %>">삭제하기</a></td>
			</tr>
<% if (wish.getWishComment() != null) { %>
      <tr>
        <td colspan="5"><%= wish.getWishComment() %></td>
      </tr>
<%
  }
}
%>
		</table>
	</body>
</html>
