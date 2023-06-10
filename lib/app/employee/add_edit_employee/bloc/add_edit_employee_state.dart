part of 'add_edit_employee_bloc.dart';

abstract class AddEditEmployeeState extends Equatable {
  const AddEditEmployeeState();
  @override
  List<Object> get props => [];
}

class AddEditEmployeeLoadingState extends AddEditEmployeeState {}

class AddEditEmployeeDataState extends AddEditEmployeeState {
  final String employeeName;
  final EmployeeRole? employeeRole;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isEditing;

  const AddEditEmployeeDataState({
    required this.employeeName,
    required this.employeeRole,
    required this.startDate,
    required this.endDate,
    required this.isEditing,
  });
  @override
  List<Object> get props => [
        employeeName,
        startDate.millisecondsSinceEpoch,
        DateTime.now().toIso8601String()
      ];
}
