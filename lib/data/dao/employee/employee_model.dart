import 'package:isar/isar.dart';
import 'package:ri_tech/data/models/employee/employee_model.dart';

part 'employee_model.g.dart';

@collection
class EmployeeDAOModel {
  Id? id;
  String? name;
  @Enumerated(EnumType.value, 'title')
  EmployeeRole? role;
  DateTime? startDate;
  DateTime? endDate;

  EmployeeModel toEmployeeModel() => EmployeeModel(
        id: id,
        name: name,
        role: role,
        startDate: startDate,
        endDate: endDate,
      );
}
