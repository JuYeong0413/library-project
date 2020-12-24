<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.util.*, libraryBean.*"%>
<!DOCTYPE html>
<html>
	<head>
		<title>대출현황조회</title>
	<head>
	<body>
	<%@ include file="top.jsp" %>
	<jsp:useBean id="lendMgr" class="libraryBean.LendMgr" />
	<% if (session_id == null) response.sendRedirect("login.jsp"); %>

		<table width="75%" align="center" border>
			<tr>
				<th>제목</th>
				<th>저자</th>
				<th>출판사</th>
				<th>대출일</th>
				<th>반납예정일</th>
        <th>대출연장</th>
        <th>도서반납</th>
			</tr><br>
	<%
    Vector vlist = lendMgr.getLendList(session_id);

		for (int i = 0; i < vlist.size(); i++) {
			Lend book = (Lend)vlist.elementAt(i);
	%>
			<tr>
				<td align="center"><%= book.getTitle() %></td>
        <td align="center"><%= book.getAuthor() %></td>
        <td align="center"><%= book.getPublisher() %></td>
        <td align="center"><%= book.getLendDate().split("\\s+")[0] %></td>
        <td align="center"><%= book.getReturnSchedule().split("\\s+")[0] %></td>
    <%
      if (book.getReturnDate() == null ) {
    %>
        <td align="center"><a href="extend_lend.jsp?lend_id=<%= book.getLendId() %>">연장하기</a></td>
        <td align="center"><a href="return_book.jsp?lend_id=<%= book.getLendId() %>">반납하기</a></td>
    <%
      } else {
    %>
        <td align="center" colspan="2">반납일 : <%= book.getReturnDate().split("\\s+")[0] %></td>
    <%
      }
    %>
			</tr>
<% } %>
		</table>
	</body>
</html>
