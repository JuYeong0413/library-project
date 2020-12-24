<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import = "java.sql.*, libraryBean.*" %>
<!DOCTYPE html>
<html>
	<head><title>도서 대출 연장</title></head>
	<body>

  <jsp:useBean id="lendMgr" class="libraryBean.LendMgr" />
	<%
		String lend_id = request.getParameter("lend_id");
		String result = null;

		result = lendMgr.returnBook(lend_id);
	%>
	<script>
    alert("<%= result %>");
		location.href = "lend_status.jsp";
	</script>
	</body>
</html>
