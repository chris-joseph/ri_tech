import 'package:isar/isar.dart';

part 'employee_model.g.dart';

@collection
class EmployeeModel {
  Id? id;
  String? name;
  @Enumerated(EnumType.value, 'title')
  EmployeeRole? role;
  DateTime? startDate;
  DateTime? endDate;
}

enum EmployeeRole {
  productDesigner("Product Designer"),
  flutterDeveloper("Flutter Developer"),
  qATester("QA Tester"),
  productOwner("Product Owner");

  final String title;

  const EmployeeRole(this.title);
}

extension EmployeeUtils on EmployeeModel {
  bool get isCurrent => endDate == null;
}
