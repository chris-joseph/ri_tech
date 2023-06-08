part of "./employee_repository.dart";

abstract class EmployeeContract {
  Future<List<EmployeeModel?>> getEmployees(List<int>? ids);
  Future<EmployeeModel?> getEmployee(int id);
  Future<EmployeeModel?> updateEmployee(EmployeeModel employee);
  Future<EmployeeModel?> createEmployee(EmployeeModel employee);
  Future<bool> deleteEmployee(int id);
}
