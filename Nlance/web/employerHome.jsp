<%@page import="java.util.List"%>
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

    if (employer == null || employer.getEmployer_id() <= 0) {
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

        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="index.jsp">Nlance</a>
                </div>
                <div>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="createNewProject.jsp"><span class="">Create a new Project</span></a></li>
                        <li><a href="#"><span class=""></span><%= employer.getUsername()%></a></li>
                        <li><a href="<%= request.getContextPath()%>/Logout?type=1"><span ></span> Logout</a></li>
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
                                    <th>Title</th>
                                    <th>Description</th>
                                    <th>Price</th>
                                    <th>Posted Date</th>
                                    <th>Category</th>
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
                                    <td><%=job.getJob_title()%></td>
                                    <td><%= job.getJob_description()%></td>
                                    <td>Rs <%= job.getJob_cost()%></td>
                                    <td><%= job.getJob_posted_date()%><br> (<%= 7 - days_count%> days remaining)</td>
                                    <td><%= job.getCategory().getCategory_name()%></td>
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
                                    <th>Title</th>
                                    <th>Description</th>
                                    <th>Posted Date</th>
                                    <th>Started Date</th>
                                    <th>End Date</th>
                                    <th>Posted Price</th>
                                    <th>Agreed Price</th>

                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Iterator activeJobs = jm.activeJobList(employer.getEmployer_id()).iterator();
                                    while (activeJobs.hasNext()) {
                                        Job job = (Job) activeJobs.next();
                                        int daysRem = SystemMethods.subtractDate(new Date(), job.getEnd_date());
                                %>
                                <tr>
                                    <td><%=job.getJob_title()%></td>
                                    <td><%= job.getJob_description()%></td>
                                    <td><%= job.getJob_posted_date()%></td>
                                    <td><%= job.getStart_date()%></td>
                                    <td><%= job.getEnd_date()%><br><%=daysRem < 0 ? "Late" : daysRem + " days remaining"%></td>
                                    <td>Rs <%= job.getJob_cost()%></td>
                                    <td>Rs <%= job.getBidded_price()%></td>

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
                                    <th>Title</th>
                                    <th>Description</th>
                                    <th>Posted Date</th>
                                    <th>Started Date</th>
                                    <th>End Date</th>
                                    <th>Posted Price</th>
                                    <th>Agreed Price</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List closedJobs = jm.fetchJobsByEmployerIdAndClosed(employer.getEmployer_id());
                                    for (int i = 0; i < closedJobs.size(); i++) {
                                        pastJobs.add((Job) closedJobs.get(i));
                                    }
                                %>
                                <%
                                    Iterator pastJobsIterator = pastJobs.iterator();
                                    while (pastJobsIterator.hasNext()) {
                                        Job job = (Job) pastJobsIterator.next();
                                %>
                                <tr>
                                    <td><%=job.getJob_title()%></td>
                                    <td><%= job.getJob_description()%></td>
                                    <td><%= job.getJob_posted_date()%></td>
                                    <td><%= job.getStart_date()%></td>
                                    <td><%= job.getEnd_date()%></td>
                                    <td>Rs <%= job.getJob_cost()%></td>
                                    <td>Rs <%= job.getBidded_price()%></td>
                                    <td> 
                                        <% if (job.getJob_status().equals(SystemAttributes.JobStatuses.OPEN) || job.getJob_status().equals(SystemAttributes.JobStatuses.CLOSED)) {%>
                                        <a class="btn btn-success btn-sm" href="editProject.jsp?jobId=<%=job.getJob_id()%>" class="list-group-item">Repost</a>
                                        <a class="btn btn-success btn-sm" href="projectOverview.jsp?pId=<%= job.getJob_id()%>" class="list-group-item">View</a>
                                        <%} else if (job.getJob_status().equals(SystemAttributes.JobStatuses.S_CLOSED)) {%>
                                        <a class="btn btn-success btn-sm" href="projectOverview.jsp?pId=<%= job.getJob_id()%>" class="list-group-item">View</a>
                                        <%}%>
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
