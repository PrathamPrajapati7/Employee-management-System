package com.emp.service;

import com.emp.dao.TaskDAO;
import com.emp.entity.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class TaskService {

    @Autowired
    private TaskDAO taskDAO;

    @Transactional
    public void assign(Task task) { taskDAO.save(task); }

    @Transactional
    public void update(Task task) { taskDAO.update(task); }

    @Transactional
    public void delete(int id) { taskDAO.delete(id); }

    @Transactional
    public void updateProgress(int id, int progress, String status, String note) {
        Task t = taskDAO.findById(id);
        t.setProgress(progress);
        t.setStatus(status);
        if (note != null && !note.trim().isEmpty()) t.setEmployeeNote(note.trim());
        taskDAO.update(t);
    }

    @Transactional(readOnly = true)
    public Task findById(int id) { return taskDAO.findById(id); }

    @Transactional(readOnly = true)
    public List<Task> getByEmployee(int employeeId) { return taskDAO.findByAssignedTo(employeeId); }

    @Transactional(readOnly = true)
    public List<Task> getAll() { return taskDAO.findAll(); }
}
