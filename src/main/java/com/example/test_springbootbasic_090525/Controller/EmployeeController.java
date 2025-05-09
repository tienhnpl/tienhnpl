package com.example.test_springbootbasic_090525.Controller;

import com.example.test_springbootbasic_090525.Model.Employee;
import com.example.test_springbootbasic_090525.Service.EmployeeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/employees")
public class EmployeeController {

    private final EmployeeService employeeService;

    public EmployeeController(EmployeeService employeeService) {
        this.employeeService = employeeService;
    }

    // LIST + SEARCH
    @GetMapping
    public String listEmployees(@RequestParam(value = "keyword", required = false) String keyword, Model model) {
        if (keyword != null && !keyword.isEmpty()) {
            model.addAttribute("employees", employeeService.searchEmployees(keyword));
            model.addAttribute("keyword", keyword); // để giữ lại keyword trong ô tìm kiếm
        } else {
            model.addAttribute("employees", employeeService.getAllEmployees());
        }
        model.addAttribute("employee", new Employee()); // để bind với form tạo mới
        return "employee-list";
    }

    // SAVE (Create & Update)
    @PostMapping("/save")
    public String saveEmployee(@ModelAttribute("employee") Employee employee, RedirectAttributes redirectAttributes) {
        if (employee.getId() == null) {
            redirectAttributes.addFlashAttribute("successMessage", "Employee created successfully!");
        } else {
            redirectAttributes.addFlashAttribute("successMessage", "Employee updated successfully!");
        }
        employeeService.saveEmployee(employee);
        return "redirect:/employees";
    }

    // EDIT - Load data lên form
    @GetMapping("/edit/{id}")
    public String editEmployee(@PathVariable Long id, Model model) {
        Employee employee = employeeService.getEmployeeById(id);
        model.addAttribute("employee", employee);
        model.addAttribute("employees", employeeService.getAllEmployees());
        return "employee-list";  // dùng lại view list + form
    }

    // DELETE
    @GetMapping("/delete/{id}")
    public String deleteEmployee(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        employeeService.deleteEmployeeById(id);
        redirectAttributes.addFlashAttribute("successMessage", "Employee deleted successfully!");
        return "redirect:/employees";
    }
}

