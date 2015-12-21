/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.elance.models;

import java.util.Set;

/**
 *
 * @author EyeWeb005
 */
public class Bidder {

    private int bidder_id;
    private String email;
    private String username;
    private String password;
    private Set<Job> jobs;
    private Set<Bid> bids;

    public Set<Bid> getBids() {
        return bids;
    }

    public void setBids(Set<Bid> bids) {
        this.bids = bids;
    }
    
    

    public Set<Job> getJobs() {
        return jobs;
    }

    public void setJobs(Set<Job> jobs) {
        this.jobs = jobs;
    }

    public int getBidder_id() {
        return bidder_id;
    }

    public void setBidder_id(int bidder_id) {
        this.bidder_id = bidder_id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

}
