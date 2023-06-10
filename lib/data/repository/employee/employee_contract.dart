part of "./employee_repository.dart";

enum EmployeeOperation {
  readAll,
  read,
  update,
  create,
  delete,
  undo,
}

abstract class EmployeeContract {
  Stream<EmployeeOperation> get employeeUpdateSub;
  Future<List<EmployeeModel?>> getEmployees(List<int>? ids);
  Future<EmployeeModel?> getEmployee(int id);
  Future<EmployeeModel?> updateEmployee(EmployeeModel employee);
  Future<EmployeeModel?> createEmployee(EmployeeModel employee);
  Future<bool> deleteEmployee(int id);
  Future<bool> undoDeleteEmployee();
}
