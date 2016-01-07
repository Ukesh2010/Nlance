package com.assignment.elance.controller;

import com.assignment.elance.modelManager.BidderManager;
import com.assignment.elance.modelManager.EmployerManager;
import com.assignment.elance.modelManager.SkillManager;
import com.assignment.elance.models.Skill;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SignupController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int type = Integer.parseInt(request.getParameter("type"));
        switch (type) {
            case 0:
//                ArrayList<Integer> skills = new ArrayList<Integer>();
//                SkillManager sm = new SkillManager();
//                Iterator temp = sm.fetch().iterator();
//                while (temp.hasNext()) {
//                    Skill skill = (Skill) temp.next();
//                    if (request.getParameter(skill.getSkill_id() + "") != null && request.getParameter(skill.getSkill_id() + "").equals("on")) {
//                        skills.add(skill.getSkill_id());
//                    }
//
//                }
                BidderManager biddermanager = new BidderManager();
//                biddermanager.register(request.getParameter("username"), request.getParameter("password"), request.getParameter("email"), skills);
                biddermanager.register(request.getParameter("username"), request.getParameter("password"), request.getParameter("email"));
                response.sendRedirect("bidderSignin.jsp");
                break;
            case 1:
                EmployerManager employerManager = new EmployerManager();
                employerManager.register(request.getParameter("username"), request.getParameter("password"), request.getParameter("email"));
                response.sendRedirect("employerSignin.jsp");
                break;
            case 2:
                BidderManager bidMan = new BidderManager();
                boolean check = bidMan.preRegisterCheck(request.getParameter("email"));
                response.setContentType("text/html;charset=UTF-8");
                PrintWriter out = response.getWriter();
                out.print(check + "");
                break;
            case 3:
                EmployerManager empMan = new EmployerManager();
                boolean checked = empMan.preRegisterCheck(request.getParameter("email"));
                response.setContentType("text/html;charset=UTF-8");
                PrintWriter outt = response.getWriter();
                outt.print(checked + "");
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
