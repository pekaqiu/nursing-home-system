package com.nursinghome.entity;

import java.util.Date;

public class CareRecord {
    private Integer id;
    private Integer elderlyId;
    private Integer staffId;
    private String careContent;
    private String bodyCondition;
    private Date careTime;
    private String remark;
    private Date createTime;
    private Date updateTime;
    private String elderlyName;
    private String staffName;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getElderlyId() {
        return elderlyId;
    }

    public void setElderlyId(Integer elderlyId) {
        this.elderlyId = elderlyId;
    }

    public Integer getStaffId() {
        return staffId;
    }

    public void setStaffId(Integer staffId) {
        this.staffId = staffId;
    }

    public String getCareContent() {
        return careContent;
    }

    public void setCareContent(String careContent) {
        this.careContent = careContent;
    }

    public String getBodyCondition() {
        return bodyCondition;
    }

    public void setBodyCondition(String bodyCondition) {
        this.bodyCondition = bodyCondition;
    }

    public Date getCareTime() {
        return careTime;
    }

    public void setCareTime(Date careTime) {
        this.careTime = careTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getElderlyName() {
        return elderlyName;
    }

    public void setElderlyName(String elderlyName) {
        this.elderlyName = elderlyName;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }
}
