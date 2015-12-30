/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.elance.controller;

import com.assignment.elance.helper.SystemAttributes;
import com.assignment.elance.modelManager.BidManager;
import com.assignment.elance.modelManager.JobManager;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BidController extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int requestType = Integer.parseInt(request.getParameter("type"));
        
        BidManager bm = new BidManager();
        switch (requestType) {
            case SystemAttributes.BidControllerType.INSERTBID:
                bm.insert(Integer.parseInt(request.getParameter("bidderId")), Integer.parseInt(request.getParameter("jobId")), Float.parseFloat(request.getParameter("bidded_price")), Long.parseLong(request.getParameter("time_of_completion")));
//                response.sendRedirect("bidderHome.jsp");
                break;
            case SystemAttributes.BidControllerType.ACCEPT:
                bm.fromBiddedToAccepted(request.getParameter("status"), Integer.parseInt(request.getParameter("bidId")));
                response.sendRedirect("projectOverview.jsp?pId=" + Integer.parseInt(request.getParameter("jobId")));
                break;
            case SystemAttributes.BidControllerType.APPROVE:
                int bid_id = Integer.parseInt(request.getParameter("bidId"));
                int[] ids = bm.fromAcceptedToApproved(bid_id);
                JobManager jm = new JobManager();
                jm.addBidder(ids[1], ids[0]);
                jm.changeStatus(ids[0], SystemAttributes.JobStatuses.INPROGRESS);
                response.sendRedirect("project.jsp?jobId=" + ids[0]);
                break;
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
