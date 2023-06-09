part of 'add_edit_employee_bloc.dart';

abstract class AddEditEmployeeEvent extends Equatable {
  const AddEditEmployeeEvent();
  @override
  List<Object?> get props => [];
}

class AddEditEmployeeSaveEvent extends AddEditEmployeeEvent {}

class AddEditEmployeeInitEvent extends AddEditEmployeeEvent {
  final int? employeeId;

  const AddEditEmployeeInitEvent(this.employeeId);
}

class AddEditEmployeeRoleUpdateEvent extends AddEditEmployeeEvent {
  final EmployeeRole employeeRole;

  const AddEditEmployeeRoleUpdateEvent(this.employeeRole);
}

class AddEditEmployeeNameUpdateEvent extends AddEditEmployeeEvent {
  final String employeeName;

  const AddEditEmployeeNameUpdateEvent(this.employeeName);
}

class AddEditEmployeeStartDateChangeEvent extends AddEditEmployeeEvent {
  final DateTime startDate;

  const AddEditEmployeeStartDateChangeEvent(this.startDate);
}

class AddEditEmployeeEndDateChangeEvent extends AddEditEmployeeEvent {
  final DateTime? endDate;

  const AddEditEmployeeEndDateChangeEvent(this.endDate);
}
