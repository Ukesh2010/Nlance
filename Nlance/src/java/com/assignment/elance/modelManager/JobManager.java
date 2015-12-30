/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.elance.modelManager;

import com.assignment.elance.helper.SystemAttributes;
import com.assignment.elance.models.Bidder;
import com.assignment.elance.models.HibernateUtil;
import com.assignment.elance.models.Job;
import java.util.List;
import org.hibernate.Session;

/**
 *
 * @author EyeWeb005
 */
public class JobManager {

    //add job
    public int insert(Job job) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        session.save(job);
        session.getTransaction().commit();
        return job.getJob_id();
    }

    //Employer posted job list
    public List fetchJobsByEmployerId(int eId) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List jobs = session.createQuery("from Job j where j.employer.employer_id=" + eId).list();
        session.getTransaction().commit();
        return jobs;
    }

    //Employer posted Open job list
    public List fetchJobsByEmployerIdAndOpen(int eId) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List jobs = session.createQuery("from Job j where j.employer.employer_id=" + eId + "AND j.job_status='" + SystemAttributes.JobStatuses.OPEN + "'").list();
        session.getTransaction().commit();
        return jobs;
    }

    //All the Jobs list
    public List fetchJobs() {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List jobs = session.createQuery("from Job job where job.bidder.bidder_id =" + null).list();
        session.getTransaction().commit();
        return jobs;

    }

    //fetch Job of specific Id
    public Job getJobById(int id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Job job = (Job) session.get(Job.class, new Integer(id));
        session.getTransaction().commit();
        return job;
//        List jobs = session.createQuery("from Job j where j.job_id=" + id).list();
//        session.getTransaction().commit();
//        return jobs.size() > 0 ? (Job) jobs.get(0) : null;
    }

    public void addBidder(int bidderId, int jobId) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Job job = (Job) session.load(Job.class, new Integer(jobId));

        Bidder bidder = (Bidder) session.load(Bidder.class, bidderId);
        job.setBidder(bidder);

        session.save(job);
        session.getTransaction().commit();
    }

    //change job status
    public void changeStatus(int jobId, String status) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Job job = (Job) session.load(Job.class, new Integer(jobId));
        job.setJob_status(status);

        session.update(job);
        session.getTransaction().commit();

    }

    //Employer active jobs
    public List activeJobList(int emp_id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List list = session.createQuery("from Job job where job.employer.employer_id=" + emp_id + " AND job.bidder.bidder_id >" + 0).list();
        session.getTransaction().commit();
        return list;
    }
}
