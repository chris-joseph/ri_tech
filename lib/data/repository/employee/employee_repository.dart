import 'package:ri_tech/data/dao/employee/employee_dao.dart';
import 'package:ri_tech/data/models/employee/employee_model.dart';

part "./employee_contract.dart";

class EmployeeRepo implements EmployeeContract {
  @override
  Future<EmployeeModel?> createEmployee(EmployeeModel employee) async {
    return await employeeDAO.createOrUpdateEmployee(employee);
  }

  @override
  Future<bool> deleteEmployee(id) async {
    return await employeeDAO.deleteEmployeeById(id);
  }

  @override
  Future<List<EmployeeModel>> getEmployees(ids) async {
    return await employeeDAO.getEmployeeByIds(ids);
  }

  @override
  Future<EmployeeModel?> updateEmployee(EmployeeModel employee) async {
    return await employeeDAO.createOrUpdateEmployee(employee);
  }

  @override
  Future<EmployeeModel?> getEmployee(int id) async {
    return await employeeDAO.getEmployeeById(id);
  }
}
