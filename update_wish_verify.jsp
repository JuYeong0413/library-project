<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*, libraryBean.*" %>
<!DOCTYPE html>
<html>
<head><title>희망도서수정</title></head>
<body>
<%@ include file="top.jsp" %>
<% if (session_id == null) response.sendRedirect("login.jsp"); %>
<jsp:useBean id="wishMgr" class="libraryBean.WishMgr" />
<%
  request.setCharacterEncoding("utf-8");

	String wish_id = request.getParameter("wish_id");
  String user_id = request.getParameter("user_id");
	String title = new String(request.getParameter("title"));
	String author = new String(request.getParameter("author"));
	String publisher = new String(request.getParameter("publisher"));
	String wish_comment = new String(request.getParameter("wish_comment"));
  String result;

	result = wishMgr.updateWish(title, author, publisher, wish_comment, wish_id, user_id);

  if (result == null) result = "H";
  if (result.equals("20015")) {
    result = "도서제목, 저자, 출판사 정보를 모두 입력해주세요.";
  }
%>

<script>
	alert("<%= result %>");
	location.href = "wish.jsp";
</script>

</body></html>
