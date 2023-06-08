part of 'employee_list_bloc.dart';

abstract class EmployeeListState extends Equatable {
  const EmployeeListState();
  @override
  List<Object> get props => [];
}

class EmployeeListLoadingState extends EmployeeListState {}

class EmployeeListEmptyState extends EmployeeListState {}

class EmployeeListDataState extends EmployeeListState {}
