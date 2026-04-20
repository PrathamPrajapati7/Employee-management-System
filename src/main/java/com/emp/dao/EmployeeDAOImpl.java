package com.emp.dao;

import com.emp.entity.Employee;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class EmployeeDAOImpl implements EmployeeDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Employee employee) {
        sessionFactory.getCurrentSession().save(employee);
    }

    @Override
    public void update(Employee employee) {
        sessionFactory.getCurrentSession().update(employee);
    }

    @Override
    public void delete(int id) {
        Employee emp = findById(id);
        if (emp != null) sessionFactory.getCurrentSession().delete(emp);
    }

    @Override
    public Employee findById(int id) {
        return sessionFactory.getCurrentSession().get(Employee.class, id);
    }

    @Override
    public Employee findByLoginId(String loginId) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Employee WHERE loginId=:lid", Employee.class)
                .setParameter("lid", loginId)
                .uniqueResult();
    }

    @Override
    public List<Employee> findAll() {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Employee ORDER BY name", Employee.class)
                .list();
    }

    @Override
    public List<Employee> findAllPaged(int page, int pageSize) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Employee ORDER BY name", Employee.class)
                .setFirstResult((page - 1) * pageSize)
                .setMaxResults(pageSize)
                .list();
    }

    @Override
    public long countAll() {
        return sessionFactory.getCurrentSession()
                .createQuery("SELECT COUNT(e) FROM Employee e", Long.class)
                .uniqueResult();
    }

    @Override
    public List<Employee> findByRole(String role) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Employee WHERE role=:r ORDER BY name", Employee.class)
                .setParameter("r", role)
                .list();
    }

    @Override
    public void updateStatus(int id, String status) {
        Employee emp = findById(id);
        if (emp != null) {
            emp.setStatus(status);
            sessionFactory.getCurrentSession().update(emp);
        }
    }
}
