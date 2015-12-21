/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.elance.modelManager;

import com.assignment.elance.models.Bidder;
import com.assignment.elance.models.HibernateUtil;
import com.assignment.elance.models.Job;
import com.mysql.jdbc.log.Log;
import java.util.List;
import org.hibernate.Session;

/**
 *
 * @author EyeWeb005
 */
public class JobManager {

    public int insert(Job job) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

//        Job job = new Job();
//        job.setJob_title("test");
//        job.setJob_description("abc");
//        job.setJob_cost(1212);
//        job.setJob_posted_date(new Date());
//        job.setTime_period(1234);
//        job.setJob_status("good");
//        job.setEmployer((Employer) session.load(Employer.class, new Integer(1)));
//        job.setBidder((Bidder) session.load(Bidder.class, new Integer(1)));
//        job.setCategory((Category) session.load(Category.class, new Integer(1)));
        session.save(job);
        session.getTransaction().commit();
        return job.getJob_id();
    }

    public List fetchJobsByEmployerId(int eId) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List jobs = session.createQuery("from Job j where j.employer.employer_id=" + eId).list();
        session.getTransaction().commit();
        return jobs;
    }

    public List fetchJobs() {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List jobs = session.createQuery("from Job").list();
        session.getTransaction().commit();
        return jobs;

    }

    public Job getJobById(int id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List jobs = session.createQuery("from Job j where j.job_id=" + id).list();
        session.getTransaction().commit();
        return jobs.size() > 0 ? (Job) jobs.get(0) : null;

    }

    public void addBidder(int bidderId, int jobId) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Job job = (Job) session.load(Job.class, new Integer(jobId));
        System.out.print(job.getJob_title());
//        session.getTransaction().commit();

//        session = HibernateUtil.getSessionFactory().getCurrentSession();
//        session.beginTransaction();
        Bidder bidder = (Bidder) session.load(Bidder.class, bidderId);
        job.setBidder(bidder);
//        session.getTransaction().commit();

//        session = HibernateUtil.getSessionFactory().getCurrentSession();
//        session.beginTransaction();
        session.save(job);
        session.getTransaction().commit();
    }
}
