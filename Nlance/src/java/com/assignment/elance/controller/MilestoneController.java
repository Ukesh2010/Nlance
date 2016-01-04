/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.elance.controller;

import com.assignment.elance.helper.SystemAttributes;
import com.assignment.elance.modelManager.MilestoneManager;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author EyeWeb005
 */
public class MilestoneController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MilestoneManager mm = new MilestoneManager();
        response.setContentType("text/html;charset=UTF-8");
        switch (Integer.parseInt(request.getParameter("type"))) {
            case 0:
                mm.insert(Integer.parseInt(request.getParameter("job_id")), Float.parseFloat(request.getParameter("request_amount")), request.getParameter("description"), true);
                response.getWriter().print("true");
                break;
            case 1:
                mm.changeStatus(Integer.parseInt(request.getParameter("milestoneId")), SystemAttributes.MileStoneStatuses.ACCEPT);
                response.getWriter().print("true");
                break;
            case 2:
                mm.changeStatus(Integer.parseInt(request.getParameter("milestoneId")), SystemAttributes.MileStoneStatuses.REJECT);
                response.getWriter().print("true");
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
