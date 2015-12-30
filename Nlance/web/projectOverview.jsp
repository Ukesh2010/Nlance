<%@page import="com.assignment.elance.models.Milestone"%>
<%@page import="com.assignment.elance.modelManager.MilestoneManager"%>
<%@page import="com.assignment.elance.models.Skill"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.assignment.elance.models.Message"%>
<%@page import="com.assignment.elance.modelManager.MessageManager"%>
<%@page import="java.io.File"%>
<%@page import="com.assignment.elance.helper.SystemMethods"%>
<%@page import="com.assignment.elance.models.Files"%>
<%@page import="com.assignment.elance.modelManager.FilesManager"%>
<%@page import="com.assignment.elance.models.Job"%>
<%@page import="com.assignment.elance.modelManager.JobManager"%>
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
    Job job = new JobManager().getJobById(jobId);

    String filePath = request.getContextPath()
            + File.separator + SystemAttributes.UPLOAD_DIRECTORY + File.separator;
%>
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
                $("#mgmt-tabs").tabs();
            });

            setInterval(function () {
                message = "";
                $.post("<%= request.getContextPath()%>/MessageController", {
                    "type": 1,
                    "jobId":<%=jobId%>
                }, function (data) {
                    for (var i = 0; i < data.length; i++) {
                        if (data[i].dir) {
                            message = message + '<li class="bg-info">' + data[i].message + "</li>";
                        } else {
                            message = message + '<li class="bg-primary">' + data[i].message + "</li>";
                        }
                    }
                    $("#message-box").html(message);
                });
            }, 5000);


            function sendMessage(item) {
                var job_id = $(item).attr('job-id');
                var url = $(item).attr('url');
                var msg = $(item).val();
                $(item).val("");
                $.post(url, {
                    "job_id": job_id,
                    "message": msg,
                    "send_dir": false,
                    "type": 0
                },
                function () {
                    message = message + '<li class="bg-info">' + msg + "</li>";
                    $("#message-box").html(message);
                });
            }</script>

    </head>

    <body id="page-top" class="index">

        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="index.jsp">Nlance</a>
                </div>
                <div>
                    <ul class="nav navbar-nav navbar-right">
                        <li><div class="dropdown">
                                <button class="btn btn-success dropdown-toggle" type="button" data-toggle="dropdown">Options
                                    <span class="caret"></span></button>
                                <ul class="dropdown-menu">
                                    <li><a href="#">Repost</a></li>
                                    <li><a href="#">Delete</a></li>
                                </ul>
                            </div></li>
                        <li><a href="<%= request.getContextPath()%>/Logout?type=0"><span class="glyphicon glyphicon-log-in"></span> Logout</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="row ">
            <div class="col-sm-4 col-sm-offset-2">
                <table class="table table-bordered">
                    <tr><td>Title</td><td><%= job.getJob_title()%></td></tr>
                    <tr><td>Description</td><td><%= job.getJob_description()%></td></tr>
                </table>
            </div>
            <div class="col-sm-4">
                <table class="table table-bordered">
                    <tr><td>Posted Date</td><td><%= job.getJob_posted_date()%></td></tr>
                    <tr><td>Category</td><td><%= job.getCategory().getCategory_id()%></td></tr>
                    <tr><td>Skills</td> <td><%
                        List skills = new ArrayList();
                        skills.addAll(job.getSkills());
                        Iterator skils = skills.iterator();
                        while (skils.hasNext()) {
                            %>
                            <%= ((Skill) skils.next()).getSkill_name()%>
                            <%
                                }
                            %></td>
                    </tr>
                </table>


            </div>
        </div>
        <div class="row">
            <div class=" col-lg-12">
                <div id="tabs">
                    <ul>
                        <li><a href="#tabs-1">Proposals</a></li>
                        <li><a href="#tabs-2">Management</a></li>
                    </ul>
                    <div id="tabs-1">
                        <table class="table table-striped">
                            <thead>
                            <th>Bid Id</th>
                            <th>Bidder Username</th>
                            <th>Project Bid price</th>
                            <th>Project Bid Time</th>
                            <th>Action</th>
                            </thead>
                            <tbody>
                                <%
                                    BidManager bm = new BidManager();
                                    Iterator bidsAccepted = bm.getBidByStatus(SystemAttributes.BidderStatuses.ACCEPTED, jobId).iterator();
                                    while (bidsAccepted.hasNext()) {
                                        Bid bid = (Bid) bidsAccepted.next();
                                %>
                                <tr>
                                    <td><%= bid.getBid_id()%></td>
                                    <td><%= bid.getBidder().getUsername()%></td>
                                    <td><%= bid.getBidded_price()%></td>
                                    <td><%= bid.getTime_of_completion()%></td>

                                    <td><button class="btn btn-success">Accepted</button></td>
                                </tr>
                                <%
                                    }
                                %>
                                <%
                                    Iterator bids = bm.getBidByStatus(SystemAttributes.BidderStatuses.BIDED, jobId).iterator();
                                    while (bids.hasNext()) {
                                        Bid bid = (Bid) bids.next();
                                %>
                                <tr>
                                    <td><%= bid.getBid_id()%></td>
                                    <td><%= bid.getBidder().getUsername()%></td>
                                    <td><%= bid.getBidded_price()%></td>
                                    <td><%= bid.getTime_of_completion()%></td>

                                    <td><a class="btn btn-success" href="<%= request.getContextPath()%>/BidController?type=<%= SystemAttributes.BidControllerType.ACCEPT%>&jobId=<%= jobId%>&bidId=<%= bid.getBid_id()%>&status=<%=SystemAttributes.BidderStatuses.ACCEPTED%>" class="card-link">Accept Proposal</a></td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>

                    </div>
                    <div id="tabs-2">
                        <%
                            if (job.getJob_status().equals(SystemAttributes.JobStatuses.INPROGRESS)) {
                        %>
                        <div class="row">
                            <div class="col-sm-offset-2 col-sm-8">
                                <div id="mgmt-tabs">
                                    <ul>
                                        <li><a href="#mgmt-tabs-1">Files</a></li>
                                        <li><a href="#mgmt-tabs-2">Messages</a></li>
                                        <li><a href="#mgmt-tabs-3">Milestones</a></li>
                                    </ul>
                                    <div id="mgmt-tabs-1">
                                        <table class="table table-bordered">
                                            <thead>
                                            <th>File Name</th>
                                            <th>Preview</th>
                                            </thead>
                                            <tbody>
                                                <%                        FilesManager fm = new FilesManager();
                                                    Iterator filesIterator = fm.fetchByJobId(jobId).iterator();

                                                    while (filesIterator.hasNext()) {
                                                        Files file = (Files) filesIterator.next();
                                                %>
                                                <tr>
                                                    <td>
                                                        <a class="btn btn-block" href="<%=filePath + file.getFile()%>"><%= file.getFile_name()%></a>
                                                    </td>
                                                    <td>
                                                        <%
                                                            if (SystemMethods.checkPictureFileType(file.getFile_name())) {
                                                        %>
                                                        <img src="<%=filePath + file.getFile()%>" class="img-rounded" style="width: 200px;" />
                                                        <%
                                                            }
                                                        %>
                                                    </td>
                                                </tr>
                                                <%
                                                    }
                                                %>
                                                <tr>
                                            <form method="post" action="<%= request.getContextPath()%>/FileUploadServlet?jobId=<%=jobId%>" enctype="multipart/form-data">
                                                <td>
                                                    <input class="input-sm " type="file"  name="uploadFile" />
                                                </td>
                                                <td>        
                                                    <input type="submit" value="Upload" />
                                                </td>
                                            </form>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div id="mgmt-tabs-2">
                                        <div>
                                            <div class="h1">Message</div>
                                            <div style="width: 200px; height: 100px; overflow-y: scroll;">
                                                <ul id="message-box" class="list-unstyled">
                                                    <li class="bg-primary "></li>
                                                </ul>
                                            </div>
                                            <input onkeydown="if (event.keyCode == 13)
                                                        sendMessage(this)" type="text" url="<%= request.getContextPath()%>/MessageController" job-id="<%=jobId%>"   id="sendMessage" value="" />

                                        </div>
                                    </div>
                                    <div id="mgmt-tabs-3">
                                        <%
                                            MilestoneManager msm = new MilestoneManager();
                                            Iterator ms = msm.fetchMilestones(jobId).iterator();
                                            while (ms.hasNext()) {
                                                Milestone milestone = (Milestone) ms.next();
                                        %>
                                        <%= milestone.getMilestone_amount()%>
                                        <%
                                            }

                                        %>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%                            }
                        %>


                    </div>
                </div>
            </div>
        </div>




    </body>

</html>
