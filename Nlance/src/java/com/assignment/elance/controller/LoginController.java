package com.assignment.elance.controller;

import com.assignment.elance.modelManager.BidderManager;
import com.assignment.elance.modelManager.EmployerManager;
import com.assignment.elance.models.Bidder;
import com.assignment.elance.models.Employer;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession httpSession = request.getSession();
        int type = Integer.parseInt(request.getParameter("type"));
        switch (type) {
            case 0:
                BidderManager biddermanager = new BidderManager();
                Bidder bidder = biddermanager.login(request.getParameter("username"), request.getParameter("password"));
                if (bidder == null) {
                    response.sendRedirect("bidderSignin.jsp");
                } else {
                    httpSession.setAttribute("bidder", bidder);
                    response.sendRedirect("bidderHome.jsp");
                }

                break;
            case 1:
                EmployerManager employerManager = new EmployerManager();
                Employer employer = employerManager.login(request.getParameter("username"), request.getParameter("password"));
                if (employer == null) {
                    response.sendRedirect("employerSignin.jsp");
                } else {
                    httpSession.setAttribute("employer", employer);
                    response.sendRedirect("employerHome.jsp");
                }
                break;
            default:
                log("Signup type not defined");
        }

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
