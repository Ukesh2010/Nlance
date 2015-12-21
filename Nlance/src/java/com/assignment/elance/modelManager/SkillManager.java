/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.elance.modelManager;

import com.assignment.elance.models.HibernateUtil;
import com.assignment.elance.models.Skill;
import java.util.List;
import org.hibernate.Session;

/**
 *
 * @author EyeWeb005
 */
public class SkillManager {

    public List fetch() {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List skills = session.createQuery("from Skill").list();
        session.getTransaction().commit();

        return skills;
    }

    public Skill fetchById(int id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        List skills = session.createQuery("from Skill s where s.skill_id=" + id).list();
        session.getTransaction().commit();

        return (Skill) skills.get(0);

    }

    public void insert() {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Skill skill = new Skill();
        skill.setSkill_name("Washing");
        session.save(skill);
        session.getTransaction().commit();
    }

}
