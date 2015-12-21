package com.assignment.elance.modelManager;

import com.assignment.elance.models.Bidder;
import com.assignment.elance.models.HibernateUtil;
import com.assignment.elance.models.Employer;
import java.util.List;
import org.hibernate.Session;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author EyeWeb005
 */
public class EmployerManager {

    public void register(String username, String password, String email) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Employer employer = new Employer();
        employer.setUsername(username);
        employer.setEmail(email);
        employer.setPassword(password);

        session.save(employer);
        session.getTransaction().commit();
    }

    public Employer login(String username, String password) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List result = session.createQuery("from Employer").list();
        session.getTransaction().commit();
        return result.size() > 0 ? (Employer) result.get(0) : null;

    }
}
