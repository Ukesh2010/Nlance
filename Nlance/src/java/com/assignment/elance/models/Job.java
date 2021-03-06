/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.elance.models;

import java.util.Date;
import java.util.Set;

/**
 *
 * @author EyeWeb005
 */
public class Job {

    private int job_id;
    private String job_title;
    private String job_description;
    private float job_cost;
    private long time_period;
    private Date job_posted_date;
    private String job_status;
    private Employer employer;
    private Bidder bidder;
    private Set<Bid> bids;
    private Set<Skill> skills;
    private Category category;
    private Set<Files> files;
    private Set<Message> messages;
    private Set<Milestone> milestones;
    private Date start_date;
    private Date end_date;
    private float bidded_price;

    public float getBidded_price() {
        return bidded_price;
    }

    public void setBidded_price(float bidded_price) {
        this.bidded_price = bidded_price;
    }

    public Set<Milestone> getMilestones() {
        return milestones;
    }

    public void setMilestones(Set<Milestone> milestones) {
        this.milestones = milestones;
    }

    public Set<Message> getMessages() {
        return messages;
    }

    public void setMessages(Set<Message> messages) {
        this.messages = messages;
    }

    public Set<Skill> getSkills() {
        return skills;
    }

    public void setSkills(Set<Skill> skills) {
        this.skills = skills;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public int getJob_id() {
        return job_id;
    }

    public void setJob_id(int job_id) {
        this.job_id = job_id;
    }

    public String getJob_title() {
        return job_title;
    }

    public void setJob_title(String job_title) {
        this.job_title = job_title;
    }

    public String getJob_description() {
        return job_description;
    }

    public void setJob_description(String job_description) {
        this.job_description = job_description;
    }

    public float getJob_cost() {
        return job_cost;
    }

    public void setJob_cost(float job_cost) {
        this.job_cost = job_cost;
    }

    public long getTime_period() {
        return time_period;
    }

    public void setTime_period(long time_period) {
        this.time_period = time_period;
    }

    public Date getJob_posted_date() {
        return job_posted_date;
    }

    public void setJob_posted_date(Date job_posted_date) {
        this.job_posted_date = job_posted_date;
    }

    public String getJob_status() {
        return job_status;
    }

    public void setJob_status(String job_status) {
        this.job_status = job_status;
    }

    public Employer getEmployer() {
        return employer;
    }

    public void setEmployer(Employer employer) {
        this.employer = employer;
    }

    public Bidder getBidder() {
        return bidder;
    }

    public void setBidder(Bidder bidder) {
        this.bidder = bidder;
    }

    public Set<Bid> getBids() {
        return bids;
    }

    public void setBids(Set<Bid> bids) {
        this.bids = bids;
    }

    public Set<Files> getFiles() {
        return files;
    }

    public void setFiles(Set<Files> files) {
        this.files = files;
    }

    public Date getStart_date() {
        return start_date;
    }

    public void setStart_date(Date start_date) {
        this.start_date = start_date;
    }

    public Date getEnd_date() {
        return end_date;
    }

    public void setEnd_date(Date end_date) {
        this.end_date = end_date;
    }

}
