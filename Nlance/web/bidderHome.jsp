<%@page import="com.assignment.elance.helper.SystemMethods"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.assignment.elance.models.Skill"%>
<%@page import="java.util.Set"%>
<%@page import="com.assignment.elance.modelManager.CategoryManager"%>
<%@page import="com.assignment.elance.models.Bid"%>
<%@page import="com.assignment.elance.modelManager.BidManager"%>
<%@page import="com.assignment.elance.helper.SystemAttributes"%>
<%@page import="com.assignment.elance.models.Job"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.assignment.elance.modelManager.JobManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="bidder" class="com.assignment.elance.models.Bidder" scope="session"/>
<%
    if (bidder == null || bidder.getBidder_id() <= 0) {
        response.sendRedirect("bidderSignin.jsp");
    }
%>
<%!
    public String getCategoryName(int catId) {
        return (new CategoryManager().fetchById(catId)).getCategory_name();
    }
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
            function placeBid(item) {
                bidderId = $(item).attr('bidderid');
                jobId = $(item).attr('jobid');
                url = "<%= request.getContextPath()%>/BidController";
                type = "<%= SystemAttributes.BidControllerType.INSERTBID%>";

                $.get("<%= request.getContextPath()%>/JobController", {
                    "type": 1,
                    "jobId": jobId
                }, function (json) {
                    skills = json.skills;
                    job_description = json.job_description;
                    job_posted_date = json.job_posted_date;
                    job_employer_id = json.job_employer_id;
                    job_title = json.job_title;
                    job_category = json.category;
                    no_of_bids = json.no_of_bids;

                    $('#dialog-title').html(job_title);
                    $('#dialog-description').html(job_description);
                    $('#dialog-category').html(job_category);
                    $('#dialog-posted-date').html(job_posted_date);
                    $('#dialog-skills').html(skills.toString());
                    $('#dialog-no-of-bids').html(no_of_bids);


                    $("#dialog").dialog({
                        modal: true

                    });
                });

            }

            function submitBid() {
                time_of_completion = $('#toc').val();
                bidded_price = $('#bp').val();
                $("#dialog").dialog("close");
                $.get(url, {
                    "type": type,
                    "bidderId": bidderId,
                    "jobId": jobId,
                    "time_of_completion": time_of_completion,
                    "bidded_price": bidded_price
                }, function (data) {
                    location.reload();
                });
            }
            $(function () {
                $("#tabs").tabs();


            });</script>
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
                        <li><a href="<%= request.getContextPath()%>/Logout?type=0"><span class="glyphicon glyphicon-log-in"></span> Logout</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="row">
            <div class="col-sm-offset-1 col-lg-10">
                <div id="tabs">
                    <ul>
                        <li><a href="#tabs-1">Projects</a></li>
                        <li><a href="#tabs-2">Bids</a></li>
                        <li><a href="#tabs-3">Current Projects</a></li>
                    </ul>
                    <div id="tabs-1">
                        <table class="table table-striped">
                            <thead class="bg-primary">
                            <th>Title</th>
                            <th>Price</th>
                            <th>Date</th>
                            <th>Category</th>
                            <th>Skill</th>
                            <th>Action</th>
                            </thead>                    
                            <%
                                BidManager bm = new BidManager();
                                List bidlist = bm.getBidByBidder(bidder.getBidder_id());

                                JobManager jm = new JobManager();
                                Iterator jobs = jm.fetchJobs().iterator();
                                while (jobs.hasNext()) {
                                    Iterator tempBid = bidlist.iterator();
                                    Job job = (Job) jobs.next();
                                    int days_count = SystemMethods.subtractDate(job.getJob_posted_date(), new Date());
                                    if (days_count < 7) {
                                        boolean alreadyBidded = false;
                                        while (tempBid.hasNext()) {
                                            if (job.getJob_id() == ((Bid) tempBid.next()).getJob().getJob_id()) {
                                                alreadyBidded = true;
                                            }
                                        }
                            %>
                            <tr>
                                <td><%= job.getJob_title()%></td>
                                <td><%= job.getJob_cost()%></td>
                                <td><%= job.getJob_posted_date()%></td>
                                <td><%= getCategoryName(job.getCategory().getCategory_id())%></td>
                                <td><%
                                    List skills = new ArrayList();
                                    skills.addAll(job.getSkills());
                                    Iterator skils = skills.iterator();
                                    while (skils.hasNext()) {
                                    %>
                                    <%= ((Skill) skils.next()).getSkill_name()%>
                                    <%
                                        }
                                    %></td>
                                <td>
                                    <% if (alreadyBidded) {%>
                                    <button>Already Bidded</button>
                                    <%} else {
                                    %>
                                    <a class="btn btn-success" url="<%= request.getContextPath()%>/BidController?type=<%= SystemAttributes.BidControllerType.INSERTBID%>" bidderid="<%= bidder.getBidder_id()%>" jobid="<%= job.getJob_id()%>" onclick="placeBid(this)">Bid</a>

                                    <%
                                        }
                                    %>
                                </td>
                            </tr>                
                            <%
                                    }
                                }
                            %>
                        </table>

                    </div>
                    <div id="tabs-2">
                        <div class="row">
                            <div class="col-sm-offset-1 col-sm-10">
                                <table class="table table-striped">
                                    <thead class="bg-primary">
                                    <th>Title</th>
                                    <th>Price</th>
                                    <th>Date Remaining</th>
                                    <th>Category</th>
                                    <th>Skill</th>
                                    <th>Action</th>
                                    </thead>                   
                                    <%
                                        Iterator tempBid = bidlist.iterator();
                                        while (tempBid.hasNext()) {
                                            Bid bid = (Bid) tempBid.next();

                                            Job biddedJob = new JobManager().getJobById(bid.getJob().getJob_id());
                                            int days_count = SystemMethods.subtractDate(biddedJob.getJob_posted_date(), new Date());
                                    %>
                                    <tbody>
                                        <tr>
                                            <td><%= biddedJob.getJob_title()%></td>
                                            <td><%= biddedJob.getJob_cost()%></td>
                                            <td><%= days_count < 7 ? days_count : "Expired"%></td>
                                            <td><%= getCategoryName(biddedJob.getCategory().getCategory_id())%></td>
                                            <td><%
                                                List skills = new ArrayList();
                                                skills.addAll(biddedJob.getSkills());
                                                Iterator skils = skills.iterator();
                                                while (skils.hasNext()) {
                                                %>
                                                <%= ((Skill) skils.next()).getSkill_name()%>
                                                <%
                                                    }
                                                %></td>
                                            <td><%        if (bid.getStatus().equals(SystemAttributes.BidderStatuses.ACCEPTED)) {
                                                    if (days_count <= 7) {
                                                %>


                                                <a href="<%= request.getContextPath()%>/BidController?type=<%= SystemAttributes.BidControllerType.APPROVE%>&bidId=<%= bid.getBid_id()%>" class="btn btn-success">Approve</a>


                                                <%
                                                } else if (days_count > 7) {
                                                %>


                                                <button class="btn btn-outline btn-block">Approve Expired</button>


                                                <%
                                                } else if (biddedJob.getJob_status().equalsIgnoreCase(SystemAttributes.JobStatuses.INPROGRESS) || biddedJob.getJob_status().equalsIgnoreCase(SystemAttributes.JobStatuses.CLOSED)) {
                                                %>
                                                <button class="btn btn-outline btn-block">Closed</button>

                                                <%
                                                        }
                                                    }
                                                %>
                                            </td>
                                        </tr>
                                    </tbody>
                                    <%
                                        }
                                    %>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div id="tabs-3">
                        <div class="row">
                            <div class="col-sm-offset-1 col-sm-10">
                                <table class="table table-striped">
                                    <thead class="bg-primary">
                                    <th>Title</th>
                                    <th>Price</th>
                                    <th>Date</th>
                                    <th>Category</th>
                                    <th>Skill</th>
                                    <th>Action</th>
                                    </thead>                   
                                    <%
                                        Iterator currentJobs = bm.getBidByStatusAndBidder(SystemAttributes.BidderStatuses.APPROVED, bidder.getBidder_id()).iterator();
                                        while (currentJobs.hasNext()) {
                                            Bid bid = (Bid) currentJobs.next();

                                            Job biddedJob = new JobManager().getJobById(bid.getJob().getJob_id());
                                    %>
                                    <tbody>
                                        <tr>
                                            <td><%= biddedJob.getJob_title()%></td>
                                            <td><%= biddedJob.getJob_cost()%></td>
                                            <td><%= biddedJob.getJob_posted_date()%></td>
                                            <td><%= getCategoryName(biddedJob.getCategory().getCategory_id())%></td>
                                            <td><%
                                                List skills = new ArrayList();
                                                skills.addAll(biddedJob.getSkills());
                                                Iterator skils = skills.iterator();
                                                while (skils.hasNext()) {
                                                %>
                                                <%= ((Skill) skils.next()).getSkill_name()%>
                                                <%
                                                    }
                                                %></td>
                                            <td>
                                                <a href="project.jsp?jobId=<%= biddedJob.getJob_id()%>" class="btn btn-success">Open</a>
                                            </td>
                                        </tr>
                                    </tbody>
                                    <%                        }
                                    %>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>



        <div id="dialog" title="Place Bid">
            <div>
                <table class="table table-bordered">
                    <tr><td>Title</td><td id="dialog-title"></td></tr>
                    <tr><td>Description</td><td id="dialog-description"></td></tr>
                    <tr><td>Posted Date</td><td id="dialog-posted-date"></td></tr>
                    <tr><td>Category</td><td id="dialog-category"></td></tr>
                    <tr><td>Skills</td><td id="dialog-skills"></td></tr>
                    <tr><td>No of bids</td><td id="dialog-no-of-bids"></td></tr>
                </table>
            </div>
            <div role="form">
                <div class="form-group">
                    <label for="toc">Time of Completion</label>
                    <input type="datetime" class="form-control" id="toc" placeholder="Time">
                </div>
                <div class="form-group">
                    <label for="bp">Bidded Price</label>
                    <input type="number" class="form-control" id="bp">
                </div>
                <button onclick="submitBid()" class="btn btn-default btn-block">Submit</button>
            </div>
        </div>
    </body>

</html>







