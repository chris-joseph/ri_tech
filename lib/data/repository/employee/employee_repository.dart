import 'dart:async';

import 'package:ri_tech/data/dao/employee/employee_dao.dart';
import 'package:ri_tech/data/models/employee/employee_model.dart';

part "./employee_contract.dart";

class EmployeeRepo implements EmployeeContract {
  EmployeeModel? _lastDeletedEmployee;
  static final StreamController<EmployeeOperation> _employeeUpdateController =
      StreamController<EmployeeOperation>();

  @override
  Future<EmployeeModel?> createEmployee(EmployeeModel employee) async {
    final res = await employeeDAO.createOrUpdateEmployee(employee);
    _employeeUpdateController.add(EmployeeOperation.create);
    return res;
  }

  @override
  Future<bool> deleteEmployee(id) async {
    _lastDeletedEmployee = await getEmployee(id);

    final res = await employeeDAO.deleteEmployeeById(id);
    _employeeUpdateController.add(EmployeeOperation.delete);
    return res;
  }

  @override
  Future<bool> undoDeleteEmployee() async {
    if (_lastDeletedEmployee != null) {
      await updateEmployee(_lastDeletedEmployee!);
      _employeeUpdateController.add(EmployeeOperation.undo);
      return true;
    }

    return false;
  }

  @override
  Future<List<EmployeeModel>> getEmployees(ids) async {
    final res = await employeeDAO.getEmployeeByIds(ids);
    _employeeUpdateController.add(EmployeeOperation.readAll);
    return res;
  }

  @override
  Future<EmployeeModel?> updateEmployee(EmployeeModel employee) async {
    final res = await employeeDAO.createOrUpdateEmployee(employee);
    _employeeUpdateController.add(EmployeeOperation.update);
    return res;
  }

  @override
  Future<EmployeeModel?> getEmployee(int id) async {
    final res = await employeeDAO.getEmployeeById(id);
    _employeeUpdateController.add(EmployeeOperation.read);
    return res;
  }

  @override
  Stream<EmployeeOperation> get employeeUpdateSub =>
      _employeeUpdateController.stream;
}

//TODO(chris) move to DI
EmployeeRepo employeeRepo = EmployeeRepo();
