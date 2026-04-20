package com.emp.service;

import com.emp.dao.EmployeeDAO;
import com.emp.entity.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeDAO employeeDAO;

    @Override @Transactional
    public void register(Employee employee) { employeeDAO.save(employee); }

    @Override @Transactional
    public void update(Employee employee) { employeeDAO.update(employee); }

    @Override @Transactional
    public void delete(int id) { employeeDAO.delete(id); }

    @Override @Transactional(readOnly = true)
    public Employee findById(int id) { return employeeDAO.findById(id); }

    @Override @Transactional(readOnly = true)
    public Employee findByLoginId(String loginId) { return employeeDAO.findByLoginId(loginId); }

    @Override @Transactional(readOnly = true)
    public List<Employee> getAllEmployees() { return employeeDAO.findAll(); }

    @Override @Transactional(readOnly = true)
    public List<Employee> getEmployeesPaged(int page, int pageSize) { return employeeDAO.findAllPaged(page, pageSize); }

    @Override @Transactional(readOnly = true)
    public long getTotalCount() { return employeeDAO.countAll(); }

    @Override @Transactional(readOnly = true)
    public List<Employee> getByRole(String role) { return employeeDAO.findByRole(role); }

    @Override @Transactional
    public void updateStatus(int id, String status) { employeeDAO.updateStatus(id, status); }
}
