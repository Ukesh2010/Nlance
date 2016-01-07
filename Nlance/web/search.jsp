<%@page import="com.assignment.elance.helper.SystemAttributes"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="bidder" class="com.assignment.elance.models.Bidder" scope="session"/>
<%
    if (bidder == null || bidder.getBidder_id() <= 0) {
        response.sendRedirect("bidderSignin.jsp");
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
            $(function () {
//                searchByTitle("");
                $("#dialog").dialog({
                    autoOpen: false,
                    modal: true,
                    width: 400
                });
            });
            function searchByTitle(key) {
                $.post("<%= request.getContextPath()%>/SearchController", {
                    "type": 0,
                    "title": "" + key
                }, function (data) {
                    $('#result').html("");
                    for (item in data) {
                        var row = "<tr><td>" + data[item].title + "</td><td>" + data[item].description + " </td><td> " + data[item].cost + " </td><td> " + data[item].posted_date + " </td><td> " + data[item].category + " </td><td > " + data[item].employer_name + " </td><td>" +
                                '<a class="btn btn-block btn-info" jobid="' + data[item].id + '" onclick="placeBid(this)">Bid</a>' + "</td></tr>"
                        $('#result').append(row);
                    }
                });
            }
            function search(item) {
                var key = $(item).val();
                searchByTitle(key);
            }
            searchByTitle("");

            function placeBid(item) {
                bidderId = <%= bidder.getBidder_id()%>;
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
                    $("#dialog").dialog("open");
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
                        <li><a href="bidderSignup.jsp"><span></span> <%= bidder.getEmail()%></a></li>
                        <li><a href="<%= request.getContextPath()%>/Logout?type=0"><span></span> Logout</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="row">
            <div class=" col-sm-3">
                <div class="row">
                    <div class="col-sm-offset-2 col-sm-8">
                        <div class="form-group">
                            <input onkeydown="if (event.keyCode == 13)
                                        search(this)" type="text" class="form-control" id="title" placeholder="Job" onsubmit="alert('heh')">
                        </div>

                    </div>


                </div>

            </div>
            <div class="col-sm-8">
                <table class="table">
                    <thead>
                    <th>Job Title</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>Posted Date</th>
                    <th>Category</th>
                    <th>Posted By</th>
                    </thead>
                    <tbody id="result">

                    </tbody>

                </table>

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
                    <input type="number"  class="form-control" id="toc" min="0" placeholder="Time in hours">
                </div>
                <div class="form-group">
                    <label for="bp">Bidded Price</label>
                    <input type="number" class="form-control" min="0" id="bp">
                </div>
                <button onclick="submitBid()" class="btn btn-default btn-block">Submit</button>
            </div>
        </div>


    </body>
</html>







