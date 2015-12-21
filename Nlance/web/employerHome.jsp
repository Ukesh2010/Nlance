<%@page import="com.assignment.elance.modelManager.BidManager"%>
<%@page import="com.assignment.elance.models.Job"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.assignment.elance.modelManager.JobManager"%>
<jsp:useBean id="employer" class="com.assignment.elance.models.Employer" scope="session"/>
<%
    if (employer.getEmployer_id() <= 0) {
        response.sendRedirect("employerSignin.jsp");
    }%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                    <ul class="nav navbar-nav navbar-left">
                        <li><a href="employerHome.jsp"><span class="glyphicon glyphicon-home"></span>Home</a></li>
                        <li><a href="createNewProject.jsp"><span class="glyphicon glyphicon-new-window"></span>Create a new Project</a></li>

                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#"><span class=""></span><%= employer.getUsername()%></a></li>
                        <li><a href="#"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
                    </ul>
                </div>
            </div>
        </nav>


        <div class="row">
            <div class="col-sm-6 col-sm-offset-2">
                Posted Jobs:
                <% JobManager jm = new JobManager();
                    Iterator iterator = jm.fetchJobsByEmployerId(employer.getEmployer_id()).iterator();
                    while (iterator.hasNext()) {
                        Job job = (Job) iterator.next();
                %>

                <div class="list-group">
                    <a href="projectOverview.jsp?pId=<%= job.getJob_id()%>" class="list-group-item">
                        <h4 class="list-group-item-heading"><%=job.getJob_title()%></h4>
                        <p class="list-group-item-text"><%= job.getJob_description()%></p>
                    </a>
                </div>

                <%
                    }
                %>
            </div>
        </div>
        <div class="row">
            On Going Projects:
            <%
                BidManager bidmanager = new BidManager();
//                bidmanager.
            %>

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
