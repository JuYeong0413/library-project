<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.util.regex.*" %>
<%
	String session_id = (String)session.getAttribute("user");
  String session_name = (String)session.getAttribute("name");
	String log;

	if (session_id == null) {
		log = "<a href=login.jsp>로그인</a>";
	} else {
		log = "<a href=logout.jsp>로그아웃</a>";
		Pattern p = Pattern.compile("[A-Z].*");
		Matcher m = p.matcher(session_id);
	}
%>

<table width="75%" align="center" bgcolor="#FFFF99" border>
	<tr>
		<td align="center"><b><%=log%></b></td>
		<td align="center"><b><a href="update_user.jsp">회원정보수정</b></td>
		<td align="center"><b><a href="books.jsp">전체도서목록</b></td>
		<td align="center"><b><a href="lend_status.jsp">대출현황조회</b></td>
    <td align="center"><b><a href="reservation_status.jsp">예약현황조회</b></td>
		<td align="center"><b><a href="wish.jsp">희망도서신청</b></td>
	</tr>
</table>
