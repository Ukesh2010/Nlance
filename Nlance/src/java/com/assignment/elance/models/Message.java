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
public class Message {

    private Job job;
    private int message_id;
    private String message;
    private boolean send_dir;

    public Job getJob() {
        return job;
    }

    public void setJob(Job job) {
        this.job = job;
    }

    public int getMessage_id() {
        return message_id;
    }

    public void setMessage_id(int message_id) {
        this.message_id = message_id;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public boolean isSend_dir() {
        return send_dir;
    }

    public void setSend_dir(boolean send_dir) {
        this.send_dir = send_dir;
    }

}
