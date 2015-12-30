/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.elance.modelManager;

import com.assignment.elance.models.Files;
import com.assignment.elance.models.HibernateUtil;
import com.assignment.elance.models.Job;
import java.util.List;
import org.hibernate.Session;

/**
 *
 * @author EyeWeb005
 */
public class FilesManager {

    public void insert(String file_name, String file_temp, int job_id, boolean sent_dir) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Files file = new Files();
        file.setFile_name(file_name);
        file.setJob((Job) session.load(Job.class, new Integer(job_id)));
        file.setSent_dir(sent_dir);
        file.setFile(file_temp);

        session.save(file);
        session.getTransaction().commit();
    }

    public List fetchByJobId(int id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List files = session.createQuery("from Files files where files.job.job_id=" + id).list();
        session.getTransaction().commit();
        return files;
    }
}
