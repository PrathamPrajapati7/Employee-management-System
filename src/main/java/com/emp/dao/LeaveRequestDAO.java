package com.emp.dao;

import com.emp.entity.LeaveRequest;
import java.util.List;

public interface LeaveRequestDAO {
    void save(LeaveRequest lr);
    void update(LeaveRequest lr);
    LeaveRequest findById(int id);
    List<LeaveRequest> findByEmployeeId(int employeeId);
    List<LeaveRequest> findAll();
    List<LeaveRequest> findByStatus(String status);
    long countPending();
}
