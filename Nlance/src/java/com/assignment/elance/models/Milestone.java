/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.elance.models;

/**
 *
 * @author EyeWeb005
 */
public class Milestone {

    private int milestone_id;
    private float milestone_amount;
    private int milestone_status;
    private String milestone_description;
    private boolean send_dir;
    private Job job;

    public Job getJob() {
        return job;
    }

    public void setJob(Job job) {
        this.job = job;
    }

    public int getMilestone_id() {
        return milestone_id;
    }

    public void setMilestone_id(int milestone_id) {
        this.milestone_id = milestone_id;
    }

    public float getMilestone_amount() {
        return milestone_amount;
    }

    public void setMilestone_amount(float milestone_amount) {
        this.milestone_amount = milestone_amount;
    }

    public int getMilestone_status() {
        return milestone_status;
    }

    public void setMilestone_status(int milestone_status) {
        this.milestone_status = milestone_status;
    }

    public String getMilestone_description() {
        return milestone_description;
    }

    public void setMilestone_description(String milestone_description) {
        this.milestone_description = milestone_description;
    }

    public boolean isSend_dir() {
        return send_dir;
    }

    public void setSend_dir(boolean send_dir) {
        this.send_dir = send_dir;
    }

}
