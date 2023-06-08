import 'package:flutter/material.dart';
import 'package:ri_tech/app/employee/add_edit_employee/add_edit_employee_screen.dart';

const employeeList = "/";
const addEmployee = "add_employee";
const editEmployee = "edit_employee";
Map<String, WidgetBuilder> getRoutes = {
  //employeeList: (BuildContext context) => const EmployeeListScreen(),
  addEmployee: (BuildContext context) => const AddEditEmployeeScreen(),
  editEmployee: (BuildContext context) => const AddEditEmployeeScreen(),
};
