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
public class Bid {

    private int bid_id;
    private Bidder bidder;
    private Job job;
    private String status;
    private Employer employer;
    private long time_of_completion;
    private float bidded_price;

    public Employer getEmployer() {
        return employer;
    }

    public void setEmployer(Employer employer) {
        this.employer = employer;
    }

    public int getBid_id() {
        return bid_id;
    }

    public void setBid_id(int bid_id) {
        this.bid_id = bid_id;
    }

    public Bidder getBidder() {
        return bidder;
    }

    public void setBidder(Bidder bidder) {
        this.bidder = bidder;
    }

    public Job getJob() {
        return job;
    }

    public void setJob(Job job) {
        this.job = job;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public long getTime_of_completion() {
        return time_of_completion;
    }

    public void setTime_of_completion(long time_of_completion) {
        this.time_of_completion = time_of_completion;
    }

    public float getBidded_price() {
        return bidded_price;
    }

    public void setBidded_price(float bidded_price) {
        this.bidded_price = bidded_price;
    }

}
