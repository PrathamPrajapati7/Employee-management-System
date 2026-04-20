package com.emp.dao;

import com.emp.entity.Task;
import java.util.List;

public interface TaskDAO {
    void save(Task task);
    void update(Task task);
    void delete(int id);
    Task findById(int id);
    List<Task> findByAssignedTo(int employeeId);
    List<Task> findAll();
    List<Task> findByAssignedBy(int adminId);
}
