<%@page import="com.assignment.elance.models.Bid"%>
<%@page import="com.assignment.elance.modelManager.BidManager"%>
<%@page import="com.assignment.elance.helper.SystemAttributes"%>
<%@page import="com.assignment.elance.models.Job"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.assignment.elance.modelManager.JobManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="bidder" class="com.assignment.elance.models.Bidder" scope="session"/>
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
                        <li><a href="bidderSignup.jsp"><span class="glyphicon glyphicon-log-in"></span> <%= bidder.getEmail()%></a></li>
                        <li><a href="bidderSignup.jsp"><span class="glyphicon glyphicon-log-in"></span> Logout</a></li>
                    </ul>
                </div>
            </div>
        </nav>


        <div class="row">


            <div class="col-sm-4">
                <h1>Posted Jobs</h1>
                <%
                    JobManager jm = new JobManager();
                    Iterator jobs = jm.fetchJobs().iterator();
                    while (jobs.hasNext()) {
                        Job job = (Job) jobs.next();
                %>

                <li><span><%= job.getJob_title()%></span><span><a href="<%= request.getContextPath()%>/BidController?type=<%= SystemAttributes.BidControllerType.INSERTBID%>&jobId=<%= job.getJob_id()%>&bidderId=<%= bidder.getBidder_id()%>">Bid</a>
                        <a href="">View Detail</a></span></li>
                        <%
                            }
                        %>



            </div>
            <div class="col-sm-4">
                <h1>Jobs Already Bidded</h1>
                <%
                    BidManager bm = new BidManager();
                    Iterator bids = bm.getBidByStatusAndBidder(SystemAttributes.BidderStatuses.BIDED, bidder.getBidder_id()).iterator();
                    while (bids.hasNext()) {
                        Job biddedJob = new JobManager().getJobById(((Bid) bids.next()).getJob().getJob_id());
                %>
                <%= biddedJob.getJob_title()%>
                <%        }
                %>

            </div>
            <div class="col-sm-4">
                <h1>Jobs Which need Approval</h1>
                <%
                    Iterator bidsApproval = bm.getBidByStatusAndBidder(SystemAttributes.BidderStatuses.ACCEPTED, bidder.getBidder_id()).iterator();
                    while (bidsApproval.hasNext()) {
                        Bid bidsneedApproval = ((Bid) bidsApproval.next());
                        Job biddedJob = new JobManager().getJobById(bidsneedApproval.getJob().getJob_id());
                %>
                <%= biddedJob.getJob_title()%>
                <a href="<%= request.getContextPath()%>/BidController?type=<%= SystemAttributes.BidControllerType.UPDATESTATUS%>&jobId=<%= biddedJob.getJob_id()%>&bidId=<%=bidsneedApproval.getBid_id()%>&status=<%=SystemAttributes.BidderStatuses.APPROVED%>" class="btn btn-link">Approve </a>    
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







