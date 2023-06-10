part of 'employee_list_bloc.dart';

abstract class EmployeeListState extends Equatable {
  const EmployeeListState();
  @override
  List<Object> get props => [];
}

class EmployeeListLoadingState extends EmployeeListState {}

class EmployeeListEmptyState extends EmployeeListState {}

class EmployeeListDataState extends EmployeeListState {
  final List<EmployeeModel> currentEmployees;
  final List<EmployeeModel> pastEmployees;

  const EmployeeListDataState(this.currentEmployees, this.pastEmployees);
  @override
  List<Object> get props =>
      [...currentEmployees, ...pastEmployees, DateTime.now().toIso8601String()];
}

class EmployeeListActionState extends EmployeeListState {
  final EmployeeListAction action;

  const EmployeeListActionState(this.action);
  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}
