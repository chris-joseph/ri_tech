import 'package:flutter/material.dart';
import 'package:ri_tech/app/employee/add_edit_employee/add_edit_employee_screen.dart';
import 'package:ri_tech/app/employee/employee_list/employee_list_screen.dart';

const employeeList = "/";
const addEmployee = "add_employee";
const editEmployee = "edit_employee";

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case addEmployee:
      return MaterialPageRoute(builder: (context) {
        return const AddEditEmployeeScreen();
      });
    case editEmployee:
      return MaterialPageRoute(
        builder: (context) {
          return AddEditEmployeeScreen(
            employeeId: settings.arguments as int,
          );
        },
      );

    default:
      return MaterialPageRoute(builder: (context) {
        return const EmployeeListScreen();
      });
  }
}
