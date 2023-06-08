class EmployeeModel {
  final String name;
  final EmployeeRole role;
  final DateTime startDate;
  final DateTime? endDate;

  const EmployeeModel({
    required this.name,
    required this.role,
    required this.startDate,
    this.endDate,
  });
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
