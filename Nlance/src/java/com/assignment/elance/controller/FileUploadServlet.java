/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.elance.controller;

import com.assignment.elance.helper.SystemAttributes;
import com.assignment.elance.modelManager.FilesManager;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author EyeWeb005
 */
public class FileUploadServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // upload settings
    private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3; 	// 3MB
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB

    /**
     * Upon receiving file upload submission, parses the request to read upload
     * data and saves the file on disk.
     */
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        // checks if the request actually contains upload file
        if (!ServletFileUpload.isMultipartContent(request)) {
            // if not, we stop here
            PrintWriter writer = response.getWriter();
            writer.println("Error: Form must has enctype=multipart/form-data.");
            writer.flush();
            return;
        }

        // configures upload settings
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // sets memory threshold - beyond which files are stored in disk 
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        // sets temporary location to store files
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload = new ServletFileUpload(factory);

        // sets maximum size of upload file
        upload.setFileSizeMax(MAX_FILE_SIZE);

        // sets maximum size of request (include file + form data)
        upload.setSizeMax(MAX_REQUEST_SIZE);

        // constructs the directory path to store upload file
        // this path is relative to application's directory
        String uploadPath = getServletContext().getRealPath("")
                + File.separator + SystemAttributes.UPLOAD_DIRECTORY;

        // creates the directory if it does not exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        try {
            // parses the request's content to extract file data
            @SuppressWarnings("unchecked")
            List<FileItem> formItems = upload.parseRequest(request);

            if (formItems != null && formItems.size() > 0) {
                // iterates over form's fields
                for (FileItem item : formItems) {
                    // processes only fields that are not form fields
                    if (!item.isFormField()) {
                        String fileName = new File(item.getName()).getName();
                        String file = randomFileNameGenerator();
                        String filePath = uploadPath + File.separator + file;
                        File storeFile = new File(filePath);

                        // saves the file on disk
                        item.write(storeFile);
                        FilesManager fm = new FilesManager();
                        boolean send_dir = false;
                        switch (Integer.parseInt(request.getParameter("senddir"))) {
                            case 0:
                                send_dir = false;
                                break;
                            case 1:
                                send_dir = true;
                                break;
                        }
                        fm.insert(fileName, file, Integer.parseInt(request.getParameter("jobId")), send_dir);
                        request.setAttribute("message",
                                "Upload has been done successfully!");
                    }
                }
            }
        } catch (Exception ex) {
            request.setAttribute("message",
                    "There was an error: " + ex.getMessage());
        }
//        // redirects client to message page
//        getServletContext().getRequestDispatcher("/message.jsp").forward(
//                request, response);
        switch (Integer.parseInt(request.getParameter("callbackpage"))) {
            case 0:
                response.sendRedirect("projectOverview.jsp?pId=" + Integer.parseInt(request.getParameter("jobId")));
                break;
            case 1:
                response.sendRedirect("project.jsp?jobId=" + Integer.parseInt(request.getParameter("jobId")));
                break;

        }
    }

    private String randomFileNameGenerator() {
        return "file_" + new Date().getTime();
    }
}
