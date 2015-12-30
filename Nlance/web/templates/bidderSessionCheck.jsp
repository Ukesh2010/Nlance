<%@page import="com.assignment.elance.models.Bidder"%>
<%
    HttpSession httpSession = request.getSession();
    Bidder bidder = (Bidder) httpSession.getAttribute("bidder");
    if (bidder == null) {
        response.sendRedirect("bidderSignin.jsp");
    }
%>