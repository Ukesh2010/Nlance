<%@page import="java.util.ArrayList"%>
<%@page import="com.assignment.elance.helper.SystemMethods"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="com.assignment.elance.helper.SystemAttributes"%>
<%@page import="com.assignment.elance.modelManager.BidManager"%>
<%@page import="com.assignment.elance.models.Job"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.assignment.elance.modelManager.JobManager"%>
<jsp:useBean id="employer" class="com.assignment.elance.models.Employer" scope="session"/>
<%
    if (employer.getEmployer_id() <= 0) {
        response.sendRedirect("employerSignin.jsp");
    }

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Nlance</title>
        <script src="js/jquery.js"></script>
        <script src="js/jquery-ui.js"></script>
        <script src="js/bootstrap.js"></script>

        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/jquery-ui.css" rel="stylesheet">
        <script>
            $(function () {
                $("#tabs").tabs();
            });
        </script>
    </head>

    <body id="page-top" class="index">

        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="index.jsp">Nlance</a>
                </div>
                <div>
                    <ul class="nav navbar-nav navbar-left">
                        <li><a href="createNewProject.jsp"><span class="glyphicon glyphicon-new-window"></span>Create a new Project</a></li>

                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#"><span class=""></span><%= employer.getUsername()%></a></li>
                        <li><a href="<%= request.getContextPath()%>/Logout?type=1"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="row">
            <div class="col-sm-offset-1 col-lg-10">
                <div id="tabs">
                    <ul>
                        <li><a href="#tabs-1">Open for Bidding</a></li>
                        <li><a href="#tabs-2">Work in progress</a></li>
                        <li><a href="#tabs-3">Past Projects</a></li>
                    </ul>
                    <div id="tabs-1">
                        <table class="table table-striped table-bordered">
                            <thead >
                                <tr>
                                    <th>Id</th>
                                    <th>Title</th>
                                    <th>Description</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% JobManager jm = new JobManager();
                                    ArrayList<Job> pastJobs = new ArrayList<Job>();
                                    Iterator iterator = jm.fetchJobsByEmployerIdAndOpen(employer.getEmployer_id()).iterator();
                                    while (iterator.hasNext()) {
                                        Job job = (Job) iterator.next();
                                        int days_count = SystemMethods.subtractDate(job.getJob_posted_date(), new Date());
                                        if (days_count < 7) {


                                %>
                                <tr>
                                    <td><%= job.getJob_id()%><%= days_count%></td>
                                    <td><%=job.getJob_title()%></td>
                                    <td><%= job.getJob_description()%></td>
                                    <td> 
                                        <a class="btn btn-success btn-block" href="projectOverview.jsp?pId=<%= job.getJob_id()%>" class="list-group-item">View in Detail</a>
                                    </td>
                                </tr>

                                <%
                                        } else {
                                            pastJobs.add(job);
                                        }
                                    }
                                %>

                            </tbody>
                        </table>
                    </div>
                    <div id="tabs-2">
                        <table class="table table-striped table-bordered">
                            <thead >
                                <tr>
                                    <th>Id</th>
                                    <th>Title</th>
                                    <th>Description</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Iterator activeJobs = jm.activeJobList(employer.getEmployer_id()).iterator();
                                    while (activeJobs.hasNext()) {
                                        Job job = (Job) activeJobs.next();
                                %>
                                <tr>
                                    <td><%= job.getJob_id()%></td>
                                    <td><%=job.getJob_title()%></td>
                                    <td><%= job.getJob_description()%></td>
                                    <td> 
                                        <a class="btn btn-success btn-block" href="projectOverview.jsp?pId=<%= job.getJob_id()%>" class="list-group-item">View in Detail</a>
                                    </td>
                                </tr>


                                <%
                                    }
                                %>

                            </tbody>
                        </table>

                    </div>
                    <div id="tabs-3">
                        <table class="table table-striped table-bordered">
                            <thead >
                                <tr>
                                    <th>Id</th>
                                    <th>Title</th>
                                    <th>Description</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Iterator pastJobsIterator = pastJobs.iterator();
                                    while (pastJobsIterator.hasNext()) {
                                        Job job = (Job) pastJobsIterator.next();
                                %>
                                <tr>
                                    <td><%= job.getJob_id()%></td>
                                    <td><%=job.getJob_title()%></td>
                                    <td><%= job.getJob_description()%></td>
                                    <td> 
                                        <a class="btn btn-success btn-block" href="projectOverview.jsp?pId=<%= job.getJob_id()%>" class="list-group-item">View in Detail</a>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>



    </body>

</html>
