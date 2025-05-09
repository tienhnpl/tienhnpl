package com.example.test_springbootbasic_090525.Service;


import com.example.test_springbootbasic_090525.Model.Employee;

import java.util.List;

public interface EmployeeService {
    List<Employee> getAllEmployees();
    Employee saveEmployee(Employee employee);
    Employee getEmployeeById(Long id);
    void deleteEmployeeById(Long id);
    List<Employee> searchEmployees(String keyword);
}

