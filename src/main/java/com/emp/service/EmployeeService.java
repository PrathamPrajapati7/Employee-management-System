package com.emp.service;

import com.emp.entity.Employee;
import java.util.List;

public interface EmployeeService {
    void register(Employee employee);
    void update(Employee employee);
    void delete(int id);
    Employee findById(int id);
    Employee findByLoginId(String loginId);
    List<Employee> getAllEmployees();
    List<Employee> getEmployeesPaged(int page, int pageSize);
    long getTotalCount();
    List<Employee> getByRole(String role);
    void updateStatus(int id, String status);
}
