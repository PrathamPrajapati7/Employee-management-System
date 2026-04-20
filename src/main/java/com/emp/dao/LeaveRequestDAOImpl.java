package com.emp.dao;

import com.emp.entity.LeaveRequest;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class LeaveRequestDAOImpl implements LeaveRequestDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(LeaveRequest lr) { sessionFactory.getCurrentSession().save(lr); }

    @Override
    public void update(LeaveRequest lr) { sessionFactory.getCurrentSession().update(lr); }

    @Override
    public LeaveRequest findById(int id) { return sessionFactory.getCurrentSession().get(LeaveRequest.class, id); }

    @Override
    public List<LeaveRequest> findByEmployeeId(int employeeId) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM LeaveRequest lr WHERE lr.employee.id=:eid ORDER BY lr.appliedOn DESC", LeaveRequest.class)
                .setParameter("eid", employeeId).list();
    }

    @Override
    public List<LeaveRequest> findAll() {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM LeaveRequest lr ORDER BY lr.appliedOn DESC", LeaveRequest.class).list();
    }

    @Override
    public List<LeaveRequest> findByStatus(String status) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM LeaveRequest lr WHERE lr.status=:s ORDER BY lr.appliedOn DESC", LeaveRequest.class)
                .setParameter("s", status).list();
    }

    @Override
    public long countPending() {
        return sessionFactory.getCurrentSession()
                .createQuery("SELECT COUNT(lr) FROM LeaveRequest lr WHERE lr.status='PENDING'", Long.class)
                .uniqueResult();
    }
}
