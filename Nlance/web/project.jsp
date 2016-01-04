<%@page import="com.assignment.elance.models.Milestone"%>
<%@page import="com.assignment.elance.modelManager.MilestoneManager"%>
<%@page import="com.assignment.elance.models.Skill"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.assignment.elance.models.Job"%>
<%@page import="com.assignment.elance.modelManager.JobManager"%>
<%@page import="com.assignment.elance.models.Message"%>
<%@page import="com.assignment.elance.modelManager.MessageManager"%>
<%@page import="java.io.File"%>
<%@page import="com.assignment.elance.helper.SystemAttributes"%>
<%@page import="com.assignment.elance.models.Files"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.assignment.elance.modelManager.FilesManager"%>
<% int job_id = Integer.parseInt(request.getParameter("jobId"));%>
<% Job job = new JobManager().getJobById(job_id);%>
<jsp:useBean id="bidder" class="com.assignment.elance.models.Bidder" scope="session"/>
<%!
    public boolean checkPictureFileType(String fileName) {
        int dotIndex = fileName.indexOf(".");
        if (dotIndex < 1) {
            return false;
        }
        String fileActualName = fileName.substring(0, dotIndex);
        String fileType = fileName.substring(dotIndex + 1);
        return fileType.equalsIgnoreCase("JPG") || fileType.equalsIgnoreCase("PNG") || fileType.equalsIgnoreCase("gif");
    }
%>
<%
    String filePath = request.getContextPath()
            + File.separator + SystemAttributes.UPLOAD_DIRECTORY + File.separator;
    MilestoneManager mm = new MilestoneManager();
    List milestones = mm.fetchMilestones(job_id);
    float paidMoney = 0;

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="templates/header.jsp" />
<script>
    $(document).ready(function () {
        $('#gallery').gallerie();
        $("#mgmt-tabs").tabs();
        var dialog = $('#dialog').dialog({
            autoOpen: false,
            modal: true,
            width: 500
        });
        var total_price =<%= job.getBidded_price()%>, paid_amount, request_amount, description, job_id =<%= job.getJob_id()%>, url = "<%=request.getContextPath()%>" + "/MilestoneController";

        $('#createMilestone').on("click", function () {
            paid_amount = $('#createMilestone').attr('paidmoney');
            var temp_rem = total_price - paid_amount;
            $('#total_price').val(total_price + "(" + temp_rem + " remaining)");
            $('#request_amount').attr('max', temp_rem);
            dialog.dialog("open");
        });

        $('#postMilestone').on("click", function () {
            request_amount = $('#request_amount').val();
            description = $('#description').val();
            $.post(url, {
                "type": 0,
                "request_amount": request_amount,
                "description": description,
                "job_id": job_id
            }, function (data) {
                dialog.dialog("close");
                location.reload();
            });

        });

    });
    setInterval(function () {
        message = "";
        $.post("<%= request.getContextPath()%>/MessageController", {
            "type": 1,
            "jobId":<%=job_id%>
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
            "send_dir": true,
            "type": 0
        },
        function () {
            message = message + '<li class="bg-info">' + msg + "</li>";
            $("#message-box").html(message);
        });
    }



</script>
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
        <div class="col-sm-offset-2 col-sm-8">
            <div id="mgmt-tabs">
                <ul>
                    <li><a href="#mgmt-tabs-1">Project Detail</a></li>
                    <li><a href="#mgmt-tabs-2">Files</a></li>
                    <li><a href="#mgmt-tabs-3">Messages</a></li>
                    <li><a href="#mgmt-tabs-4">Milestones</a></li>
                </ul>
                <div id="mgmt-tabs-1">
                    <table class="table table-bordered">
                        <tr><td>Title</td><td><%= job.getJob_title()%></td></tr>
                        <tr><td>Description</td><td><%= job.getJob_description()%></td></tr>
                        <tr><td>Posted Date</td><td><%= job.getJob_posted_date()%></td></tr>
                        <tr><td>Job Start Date</td><td><%= job.getStart_date()%></td></tr>
                        <tr><td>Job End Date</td><td><%= job.getEnd_date()%></td></tr>
                        <tr><td>Status</td><td><%= job.getJob_status()%></td></tr>
                        <tr><td>Bidded Price</td><td><%= job.getBidded_price()%></td></tr>
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
                <div id="mgmt-tabs-2">
                    <table class="table table-bordered">
                        <thead>
                        <th>File Name</th>
                        <th>Action</th>
                        </thead>
                        <tbody>
                            <%                        FilesManager fm = new FilesManager();
                                Iterator filesIterator = fm.fetchByJobId(job_id).iterator();

                                while (filesIterator.hasNext()) {
                                    Files file = (Files) filesIterator.next();
                            %>
                            <tr>
                                <td><a class="btn btn-block" href="<%=filePath + file.getFile()%>"><%=file.getFile_name()%></a></td>
                                <td>
                                    <%
                                        if (checkPictureFileType(file.getFile_name())) {
                                    %>
                                    <div id="gallery">
                                        <a href="<%=filePath + file.getFile()%>">Preview</a>
                                    </div>
                                    <%
                                        }
                                    %>
                                </td>
                            </tr>

                            <%
                                }
                            %>
                            <tr>
                        <form method="post" action="<%= request.getContextPath()%>/FileUploadServlet?jobId=<%=job_id%>" enctype="multipart/form-data">
                            <td>
                                <input id="fileUpload" class="input-sm " type="file"  name="uploadFile" />
                            </td>
                            <td>        
                                <input type="submit" value="Upload" />
                            </td>
                        </form>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div id="mgmt-tabs-3">
                    <div class="h1">Message</div>
                    <div>
                        <ul id="message-box" class="list-unstyled">
                            <li class="bg-primary "></li>
                        </ul>
                    </div>
                    <input onkeydown="if (event.keyCode == 13)
                                sendMessage(this)" type="text" url="<%= request.getContextPath()%>/MessageController" job-id="<%=job_id%>"   id="sendMessage" value="" />
                </div >
                <div id="mgmt-tabs-4">
                    <div>
                        <table class="table table-responsive"> 
                            <thead>
                            <th>Price</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Action</th>
                            </thead>
                            <tbody>
                                <% Iterator milestoneIterator = milestones.iterator();
                                    while (milestoneIterator.hasNext()) {
                                        Milestone milestone = (Milestone) milestoneIterator.next();
                                        paidMoney = ((milestone.getMilestone_status() == SystemAttributes.MileStoneStatuses.ACCEPT) ? milestone.getMilestone_amount() : 0) + paidMoney;
                                %>
                                <tr>
                                    <td><%= milestone.getMilestone_amount()%></td>
                                    <td><%= milestone.getMilestone_description()%></td>
                                    <td><%= milestone.getMilestone_status()%></td>
                                    <td></td>
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

    <div id="dialog" title="Request Milestone">
        <div class="form-horizontal"  role="form">
            <div class = "form-group">
                <label for = "total_price" class = "col-sm-4 control-label">Job Total Price</label>
                <div class = "col-sm-8">
                    <input type = "text" class = "form-control" id = "total_price" disabled="true">
                </div>
            </div>
            <div class = "form-group">
                <label for = "request_amount" class = "col-sm-4 control-label">Request Amount</label>
                <div class = "col-sm-8">
                    <input type = "number"   class = "form-control" id = "request_amount"  placeholder="Amount">
                </div>
            </div>
            <div class = "form-group">
                <label for = "description" class = "col-sm-4 control-label">Description</label>
                <div class = "col-sm-8">
                    <input type = "text" class = "form-control" id = "description"  placeholder="Description">
                </div>
            </div>
            <div class = "form-group">
                <div class = "col-sm-offset-4 col-sm-8">
                    <button id="postMilestone"  class = "btn btn-default">Request Milestone</button>
                </div>
            </div>
        </div>
    </div>

</body>
<jsp:include page="templates/footer.jsp" />