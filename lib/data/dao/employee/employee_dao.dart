import 'dart:io';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ri_tech/data/dao/employee/employee_model.dart';
import 'package:ri_tech/data/models/employee/employee_model.dart';

class EmployeeDAO {
  late final Directory _directory;
  late final Isar _isar;
  Future<void> init() async {
    _directory = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [EmployeeDAOModelSchema],
      directory: _directory.path,
    );
  }

  Future<bool> doesExistEmployee(id) async {
    return await _isar.employeeDAOModels.get(id) == null;
  }

  Future<EmployeeModel?> getEmployeeById(id) async {
    final res = await _isar.employeeDAOModels.get(id);
    return res?.toEmployeeModel();
  }

  Future<bool> deleteEmployeeById(int id) async {
    await _isar.writeTxn(() async {
      return await _isar.employeeDAOModels.delete(id);
    });
    return false;
  }

  Future<EmployeeModel?> createOrUpdateEmployee(EmployeeModel employee) async {
    final emp = EmployeeDAOModel()
      ..name = employee.name
      ..id = employee.id
      ..startDate = employee.startDate
      ..endDate = employee.endDate
      ..role = employee.role;

    await _isar.writeTxn(() async {
      await _isar.employeeDAOModels.put(emp);
      return employee;
    });
    return null;
  }

  Future<List<EmployeeModel>> getEmployeeByIds(List<int>? ids) async {
    final res = await _isar.employeeDAOModels.getAll(ids ?? []);
    final temp = List.from(res.where((element) => element == null));
    List<EmployeeModel> list =
        List.generate(temp.length, (index) => temp[index].toEmployeeModel());
    return list;
  }
}

//TODO(chris): use DI instead
final EmployeeDAO employeeDAO = EmployeeDAO();
