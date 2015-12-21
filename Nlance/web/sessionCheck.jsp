<jsp:useBean id="bidder" class="com.assignment.elance.models.Bidder" scope="session"/>
<jsp:useBean id="employer" class="com.assignment.elance.models.Employer" scope="session"/>
<% 
    log(employer.getEmployer_id() + "");
    if (!(bidder.getBidder_id() <= 0)) {
        response.sendRedirect("bidderHome.jsp");
    } else if (!(employer.getEmployer_id() <= 0)) {
        response.sendRedirect("employerHome.jsp");
    }%>