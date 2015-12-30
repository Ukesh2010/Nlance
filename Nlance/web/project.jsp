<%@page import="com.assignment.elance.models.Message"%>
<%@page import="com.assignment.elance.modelManager.MessageManager"%>
<%@page import="java.io.File"%>
<%@page import="com.assignment.elance.helper.SystemAttributes"%>
<%@page import="com.assignment.elance.models.Files"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.assignment.elance.modelManager.FilesManager"%>
<% int job_id = Integer.parseInt(request.getParameter("jobId"));%>
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


%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="templates/header.jsp" />
<script>
    $(document).ready(function () {
        $('#gallery').gallerie();
        $("#mgmt-tabs").tabs();
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
                <ul class="nav navbar-nav navbar-left">
                </ul>
                <ul class="nav navbar-nav navbar-right">
                </ul>
            </div>
        </div>
    </nav>
    <div class="row">
        <div class="col-sm-offset-2 col-sm-8">
            <div id="mgmt-tabs">
                <ul>
                    <li><a href="#mgmt-tabs-1">Files</a></li>
                    <li><a href="#mgmt-tabs-2">Messages</a></li>
                </ul>
                <div id="mgmt-tabs-1">
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
                <div id="mgmt-tabs-2">
                    <div class="h1">Message</div>
                    <div>
                        <ul id="message-box" class="list-unstyled">
                            <li class="bg-primary "></li>
                        </ul>
                    </div>
                    <input onkeydown="if (event.keyCode == 13)
                                sendMessage(this)" type="text" url="<%= request.getContextPath()%>/MessageController" job-id="<%=job_id%>"   id="sendMessage" value="" />
                </div>
            </div>
        </div>
    </div>


</body>
<jsp:include page="templates/footer.jsp" />