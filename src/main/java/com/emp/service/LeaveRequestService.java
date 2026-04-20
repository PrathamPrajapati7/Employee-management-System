package com.emp.service;

import com.emp.dao.LeaveRequestDAO;
import com.emp.entity.LeaveRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class LeaveRequestService {

    @Autowired
    private LeaveRequestDAO leaveRequestDAO;

    @Transactional
    public void apply(LeaveRequest lr) { leaveRequestDAO.save(lr); }

    @Transactional
    public void updateStatus(int id, String status, String remark) {
        LeaveRequest lr = leaveRequestDAO.findById(id);
        lr.setStatus(status);
        lr.setAdminRemark(remark);
        leaveRequestDAO.update(lr);
    }

    @Transactional(readOnly = true)
    public LeaveRequest findById(int id) { return leaveRequestDAO.findById(id); }

    @Transactional(readOnly = true)
    public List<LeaveRequest> getByEmployee(int employeeId) { return leaveRequestDAO.findByEmployeeId(employeeId); }

    @Transactional(readOnly = true)
    public List<LeaveRequest> getAll() { return leaveRequestDAO.findAll(); }

    @Transactional(readOnly = true)
    public List<LeaveRequest> getPending() { return leaveRequestDAO.findByStatus("PENDING"); }

    @Transactional(readOnly = true)
    public long countPending() { return leaveRequestDAO.countPending(); }
}
