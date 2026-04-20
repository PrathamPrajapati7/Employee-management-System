package com.emp.dao;

import com.emp.entity.Employee;
import java.util.List;

public interface EmployeeDAO {
    void save(Employee employee);
    void update(Employee employee);
    void delete(int id);
    Employee findById(int id);
    Employee findByLoginId(String loginId);
    List<Employee> findAll();
    List<Employee> findAllPaged(int page, int pageSize);
    long countAll();
    List<Employee> findByRole(String role);
    void updateStatus(int id, String status);
}
