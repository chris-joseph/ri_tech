import 'dart:io';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ri_tech/data/models/employee/employee_model.dart';

class EmployeeDAO {
  late final Directory _directory;
  late final Isar _isar;
  Future<void> init() async {
    _directory = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [EmployeeModelSchema],
      directory: _directory.path,
    );
  }

  Future<bool> doesExistEmployee(id) async {
    return await _isar.employeeModels.get(id) == null;
  }

  Future<EmployeeModel?> getEmployeeById(id) async {
    return await _isar.employeeModels.get(id);
  }

  Future<bool> deleteEmployeeById(int id) async {
    await _isar.writeTxn(() async {
      return await _isar.employeeModels.delete(id);
    });
    return false;
  }

  Future<EmployeeModel?> createOrUpdateEmployee(EmployeeModel employee) async {
    await _isar.writeTxn(() async {
      await _isar.employeeModels.put(employee);
      return employee;
    });
    return null;
  }

  Future<List<EmployeeModel?>> getEmployeeByIds(List<int>? ids) async {
    return await _isar.employeeModels.getAll(ids ?? []);
  }
}

//TODO(chris): use DI instead
final EmployeeDAO employeeDAO = EmployeeDAO();
