package com.emp.dao;

import com.emp.entity.Task;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class TaskDAOImpl implements TaskDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Task task) { sessionFactory.getCurrentSession().save(task); }

    @Override
    public void update(Task task) { sessionFactory.getCurrentSession().update(task); }

    @Override
    public void delete(int id) {
        Task t = findById(id);
        if (t != null) sessionFactory.getCurrentSession().delete(t);
    }

    @Override
    public Task findById(int id) { return sessionFactory.getCurrentSession().get(Task.class, id); }

    @Override
    public List<Task> findByAssignedTo(int employeeId) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Task t WHERE t.assignedTo.id=:eid ORDER BY t.assignedDate DESC", Task.class)
                .setParameter("eid", employeeId).list();
    }

    @Override
    public List<Task> findAll() {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Task t ORDER BY t.assignedDate DESC", Task.class).list();
    }

    @Override
    public List<Task> findByAssignedBy(int adminId) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Task t WHERE t.assignedBy.id=:aid ORDER BY t.assignedDate DESC", Task.class)
                .setParameter("aid", adminId).list();
    }
}
