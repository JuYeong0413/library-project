<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.util.*, libraryBean.*"%>
<!DOCTYPE html>
<html>
	<head>
		<title>전체도서목록</title>
	<head>
	<body>
	<%@ include file="top.jsp" %>
	<% if (session_id == null) response.sendRedirect("login.jsp"); %>

	<jsp:useBean id="booksMgr" class="libraryBean.BooksMgr" />
	<%

		Vector vlist = null;
		String q = "";

		if (request.getParameter("q") == null) {
			vlist = booksMgr.getBooksList();
		} else {
			q = request.getParameter("q");
			vlist = booksMgr.searchBooksList(q);
		}
	%>
		<form name="search" method="POST" action="search_verify.jsp" style="margin-top: 20px;">
			<table width="75%" align="center" border>
				<tr>
					<th>도서검색</th>
					<th><input type="text" name="search" placeholder="도서명 또는 저자명을 입력해주세요." value="<%= q %>" style="width: 100%;"></th>
					<th><input type="submit" value="검색" style="width: 100%;"></th>
				</tr>
			</table>
		</form>
		<table width="75%" align="center" border>
			<tr>
				<th>도서분류</th>
				<th>제목</th>
				<th>저자</th>
				<th>출판사</th>
				<th>출판일</th>
				<th>도서상태</th>
        <th>대출예약</th>
			</tr><br>
	<%
		for (int i = 0; i < vlist.size(); i++) {
			Books book = (Books)vlist.elementAt(i);
	%>
			<tr>
				<td align="center"><%= book.getCategoryName() %></td>
				<td align="center"><%= book.getTitle() %></td>
        <td align="center"><%= book.getAuthor() %></td>
        <td align="center"><%= book.getPublisher() %></td>
        <td align="center"><%= book.getPublishedDate().split("\\s+")[0] %></td>
      <% if (book.getLenderId() == null) { %>
        <td align="center">
          <a href="lend.jsp?book_id=<%= book.getBookId() %>&user_id=<%= session_id %>">대출하기</a>
        </td>
        <td align="center">
          &nbsp;
        </td>
      <% } else { %>
        <td align="center">
          <span>대출중<br>반납예정일 : <%= book.getReturnSchedule().split("\\s+")[0] %></span>
        </td>
        <td align="center">
					<%
						String lender_id = book.getLenderId();
						if (lender_id.equals(session_id)) {
					%>
						&nbsp;
					<% } else { %>
          	<a href="reserve.jsp?book_id=<%= book.getBookId() %>&user_id=<%= session_id %>">예약하기</a>
					<% } %>
        </td>
      <% } %>
			</tr>
<% } %>
		</table>
	</body>
</html>
