<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<title>도서검색</title>
	</head>
	<body>

	<jsp:useBean id="booksMgr" class="libraryBean.BooksMgr" />

	<%
		String query = request.getParameter("search");

		if (query.length() != 0){
			String url = "books.jsp?q=" + query;
			response.sendRedirect(url);
		} else {
			String url = "books.jsp";
	%>
    	<script>
    		alert("검색어를 입력해주세요.");
    		location.href = "<%= url %>"
    	</script>
<%	} %>
	</body>
</html>
