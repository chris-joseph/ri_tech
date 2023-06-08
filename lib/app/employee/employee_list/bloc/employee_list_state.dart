part of 'employee_list_bloc.dart';

abstract class EmployeeListState extends Equatable {
  const EmployeeListState();
}

class EmployeeListInitial extends EmployeeListState {
  @override
  List<Object> get props => [];
}
