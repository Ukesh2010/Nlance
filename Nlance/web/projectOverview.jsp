<%@page import="java.util.Date"%>
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
    int remDays = SystemMethods.subtractDate(new Date(), job.getJob_posted_date());
    String status = "";
    if (job.getJob_status().equals(SystemAttributes.JobStatuses.OPEN)) {
        status = (remDays <= 7) ? "Open" : "Expired";
    } else if (job.getJob_status().equals(SystemAttributes.JobStatuses.INPROGRESS)) {
        status = (SystemMethods.subtractDate(new Date(), job.getEnd_date()) < 0) ? "Inprogress but Late" : "Inprogress";
    } else if (job.getJob_status().equals(SystemAttributes.JobStatuses.CLOSED)) {
        status = "Closed";
    } else if (job.getJob_status().equals(SystemAttributes.JobStatuses.S_CLOSED)) {
        status = "Closed successfully";
    }

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
                var url = "<%=request.getContextPath()%>" + "/MilestoneController", milestoneId;
                function milestonestatuschange(item, type) {
                    milestoneId = $(item).attr('milestoneid');
                    $.post(url, {
                        "type": type,
                        "milestoneId": milestoneId
                    }, function (data) {
                        location.reload();
                    });
                }
                ;
                $('#msBtnAcceptId').on('click', function () {
                    milestonestatuschange(this, 1)
                });
                $('#msBtnRejectId').on('click', function () {
                    milestonestatuschange(this, 2)
                });
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
                        <li><a href="#"><span class=""></span><%= employer.getUsername()%></a></li>
                        <li><a href="<%= request.getContextPath()%>/Logout?type=0"><span class="glyphicon glyphicon-log-in"></span> Logout</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="row">
            <div class=" col-lg-12">
                <div id="tabs">
                    <ul>
                        <li><a href="#tabs-1">Project Detail</a></li>
                        <li><a href="#tabs-2">Proposals</a></li>
                        <li><a href="#tabs-3">Management</a></li>
                    </ul>
                    <div id="tabs-1">
                        <table class="table table-bordered">
                            <tr><td>Title</td><td><%= job.getJob_title()%></td></tr>
                            <tr><td>Description</td><td><%= job.getJob_description()%></td></tr>
                            <tr><td>Posted Date</td><td><%= job.getJob_posted_date()%></td></tr>
                            <tr><td>Cost</td><td><%= job.getJob_cost()%></td></tr>
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
                            <tr>
                            <tr><td>Status</td><td><%= status%></td></tr>
                            </tr>
                        </table>
                        <% if (status.equals("Open")) {
                        %>
                        <a class="btn btn-danger" href="<%= request.getContextPath()%>/JobController?type=2&jobId=<%=jobId%>" >Close</a>
                        <%
                        } else if (status.equals("Expired") || status.equals("Closed")) {
                        %>
                        <a class="btn btn-danger" href="editProject.jsp?jobId=<%=jobId%>">Repost</a>
                        <%
                        } else if (status.equals("Inprogress but Late")) {
                        %>
                        <a class="btn btn-danger" href="<%= request.getContextPath()%>/JobController?type=2&jobId=<%=jobId%>" >Close</a>
                        <a class="btn btn-danger" href="<%= request.getContextPath()%>/JobController?type=3&jobId=<%=jobId%>" >Close Successfully</a>

                        <%
                        } else if (status.equals("Inprogress")) {
                        %>
                        <a class="btn btn-danger" href="<%= request.getContextPath()%>/JobController?type=3&jobId=<%=jobId%>" >Close Successfully</a>
                        <%
                            }
                        %>
                    </div>
                    <div id="tabs-2">
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
                                    <% if (remDays <= 7) {%>
                                    <td><a class="btn btn-success" href="<%= request.getContextPath()%>/BidController?type=<%= SystemAttributes.BidControllerType.ACCEPT%>&jobId=<%= jobId%>&bidId=<%= bid.getBid_id()%>&status=<%=SystemAttributes.BidderStatuses.ACCEPTED%>" class="card-link">Accept Proposal</a></td>
                                    <%} %>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>

                    </div>
                    <div id="tabs-3">
                        <%
                            if (job.getJob_status().equals(SystemAttributes.JobStatuses.INPROGRESS) || job.getJob_status().equals(SystemAttributes.JobStatuses.CLOSED) || job.getJob_status().equals(SystemAttributes.JobStatuses.S_CLOSED)) {
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
                                                <tr>
                                                    <%
                                                        }
                                                        if (job.getJob_status().equals(SystemAttributes.JobStatuses.INPROGRESS)) {
                                                    %>
                                            <form method="post" action="<%= request.getContextPath()%>/FileUploadServlet?jobId=<%=jobId%>" enctype="multipart/form-data">
                                                <td>
                                                    <input class="input-sm " type="file"  name="uploadFile" />
                                                </td>
                                                <td>        
                                                    <input type="submit" value="Upload" />
                                                </td>
                                            </form>

                                            <%
                                                }
                                            %>
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
                                            <% if (job.getJob_status().equals(SystemAttributes.JobStatuses.INPROGRESS)) {%>
                                            <input onkeydown="if (event.keyCode == 13)
                                                        sendMessage(this)" type="text" url="<%= request.getContextPath()%>/MessageController" job-id="<%=jobId%>"   id="sendMessage" value="" />
                                            <% } %>

                                        </div>
                                    </div>
                                    <div id="mgmt-tabs-3">
                                        <div>
                                            <table class="table table-responsive"> 
                                                <thead>
                                                <th>Price</th>
                                                <th>Description</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        MilestoneManager mm = new MilestoneManager();
                                                        List milestones = mm.fetchMilestones(jobId);
                                                        float paidMoney = 0;
                                                        Iterator milestoneIterator = milestones.iterator();
                                                        while (milestoneIterator.hasNext()) {
                                                            Milestone milestone = (Milestone) milestoneIterator.next();
                                                            paidMoney = ((milestone.getMilestone_status() == SystemAttributes.MileStoneStatuses.ACCEPT) ? milestone.getMilestone_amount() : 0) + paidMoney;
                                                    %>
                                                    <tr>
                                                        <td><%= milestone.getMilestone_amount()%></td>
                                                        <td><%= milestone.getMilestone_description()%></td>
                                                        <td><%= milestone.getMilestone_status()%></td>
                                                        <td> <% if (milestone.getMilestone_status() == SystemAttributes.MileStoneStatuses.REQUEST) {%>
                                                            <button class="btn btn-sm btn-success" id="msBtnAcceptId" milestoneid="<%=milestone.getMilestone_id()%>">Accept</button> 
                                                            <button id="msBtnRejectId" class="btn btn-sm btn-danger" milestoneid="<%=milestone.getMilestone_id()%>">Reject</button>
                                                            <%  } else if (milestone.getMilestone_status() == SystemAttributes.MileStoneStatuses.ACCEPT) {%>
                                                            <label class="btn bg-info">Accepted</label>    
                                                            <% } else if (milestone.getMilestone_status() == SystemAttributes.MileStoneStatuses.REJECT) {%>
                                                            <label class="btn bg-info">Rejected</label>    

                                                            <% } %></td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                        <label class=" btn btn-default">Total Project Price : <%= job.getBidded_price()%></label> <label class="btn btn-default">Paid Money : <%= paidMoney%> </label>
                                        <button id="createMilestone" class="btn btn-social" paidmoney="<%= paidMoney%>">Create New Milestone</button>

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
