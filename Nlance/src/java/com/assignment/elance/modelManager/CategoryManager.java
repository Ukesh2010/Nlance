/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.elance.modelManager;

import com.assignment.elance.models.Category;
import com.assignment.elance.models.HibernateUtil;
import java.util.List;
import org.hibernate.Session;

/**
 *
 * @author EyeWeb005
 */
public class CategoryManager {

    public List fetch() {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List categories = session.createQuery("from Category").list();
        session.getTransaction().commit();
        return categories;
    }

    public void insert() {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Category category = new Category();
        category.setCategory_name("Category one");
        category.setCategory_description("hehe");
        session.save(category);
        session.getTransaction().commit();
    }

    public Category fetchById(int catId) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Category category = (Category) session.createQuery("from Category").list().get(0);
        session.getTransaction().commit();
        return category;
    }

}
