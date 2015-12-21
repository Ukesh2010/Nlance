<%@page import="java.util.List"%>
<%@page import="com.assignment.elance.helper.SystemAttributes"%>
<%@page import="com.assignment.elance.modelManager.BidderManager"%>
<%@page import="com.assignment.elance.models.Bid"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.assignment.elance.modelManager.BidManager"%>
<%@page import="com.assignment.elance.models.Employer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="employer" class="com.assignment.elance.models.Employer" scope="session"/>
<%
    if (employer.getEmployer_id() <= 0) {
        response.sendRedirect("employerSignin.jsp");
    }
    int jobId = Integer.parseInt(request.getParameter("pId"));
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Freelancer - Start Bootstrap Theme</title>

        <!-- Bootstrap Core CSS - Uses Bootswatch Flatly Theme: http://bootswatch.com/flatly/ -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="css/freelancer.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
        <link href="http://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">

    </head>

    <body id="page-top" class="index">

        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="index.jsp">Nlance</a>
                </div>
                <div>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="bidderSignup.jsp"><span class="glyphicon glyphicon-log-in"></span> Signup</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="row">
            <div class="col-sm-6 col-sm-offset-2">
                <%
                    BidManager bm = new BidManager();
                    List bidApprovedtemp = bm.getBidByStatus(SystemAttributes.BidderStatuses.APPROVED, jobId);
                    Bid bidApproved = bidApprovedtemp.size() > 0 ? (Bid) bidApprovedtemp.get(0) : null;
                    if (bidApproved != null) {
                %>
                <%--<%= bidAccepted.getBid_id()%>--%>

                <div class="list-group">
                    <a href="#" class="list-group-item active">

                        <h4 class="list-group-item-heading"><%= bidApproved.getBid_id()%></h4>
                    </a>
                </div>

                <%
                    }
                %>   

            </div>            
        </div>

        <div class="row">
            <div class="col-sm-4 col-sm-offset-2">
                <h1>Proposals</h1>
                <%
                    Iterator bids = bm.getBidByStatus(SystemAttributes.BidderStatuses.BIDED, jobId).iterator();
                    while (bids.hasNext()) {
                        Bid bid = (Bid) bids.next();
                        BidderManager bidMan = new BidderManager();
                        bid.setBidder(bidMan.getBidderById(bid.getBidder().getBidder_id()));
                %>
                <div class="card card-block">
                    <h4 class="card-title" bidder-id="<%= bid.getBid_id()%>"><%= bid.getBidder().getUsername()%></h4>
                    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                    <a href="#" class="card-link">View About Bidder</a>
                    <a href="<%= request.getContextPath()%>/BidController?type=<%= SystemAttributes.BidControllerType.UPDATESTATUS%>&jobId=<%= jobId%>&bidId=<%= bid.getBid_id()%>&status=<%=SystemAttributes.BidderStatuses.ACCEPTED%>" class="card-link">Accept Proposal</a>
                </div>
                <%
                    }
                %>



            </div>
            <div class="col-sm-4">
                <h2>Bid Waiting for Approval</h2>
                <%
                    List bidAcceptedtemp = bm.getBidByStatus(SystemAttributes.BidderStatuses.ACCEPTED, jobId);
                    Bid bidAccepted = bidAcceptedtemp.size() > 0 ? (Bid) bidAcceptedtemp.get(0) : null;
                    if (bidAccepted != null) {
                %>
                <%--<%= bidAccepted.getBid_id()%>--%>

                <div class="list-group">
                    <a href="#" class="list-group-item active">

                        <h4 class="list-group-item-heading"><%= bidAccepted.getBid_id()%></h4>
                    </a>
                </div>

                <%
                    }
                %>                    
            </div>
        </div>




        <!-- jQuery -->
        <script src="js/jquery.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="js/bootstrap.min.js"></script>

        <!-- Plugin JavaScript -->
        <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
        <script src="js/classie.js"></script>
        <script src="js/cbpAnimatedHeader.js"></script>

        <!-- Contact Form JavaScript -->
        <script src="js/jqBootstrapValidation.js"></script>
        <script src="js/contact_me.js"></script>

        <!-- Custom Theme JavaScript -->
        <script src="js/freelancer.js"></script>

    </body>

</html>
