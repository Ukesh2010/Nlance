/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.tomcat.util.http.fileupload.FileItem;

/**
 *
 * @author EyeWeb005
 */
public class UploadHandler extends HttpServlet {

    private final String UPLOAD_DIRECTORY = "C:/uploads";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//process only if its multipart content
//        if(Servlet.isMultipartContent(request)){
        try {
//            List<FileItem> multiparts = new ServletFi(
//                    new DiskFileItemFactory()).parseRequest(request);
//
//            for (FileItem item : multiparts) {
//                if (!item.isFormField()) {
//                    String name = new File(item.getName()).getName();
//                    item.write(new File(UPLOAD_DIRECTORY + File.separator + name));
//                }
//            }

            //File uploaded successfully
            request.setAttribute("message", "File Uploaded Successfully");
        } catch (Exception ex) {
            request.setAttribute("message", "File Upload Failed due to " + ex);
        }

//        }else{
//            request.setAttribute("message",
//                                 "Sorry this Servlet only handles file upload request");
//        }
        request.getRequestDispatcher("/result.jsp").forward(request, response);

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
