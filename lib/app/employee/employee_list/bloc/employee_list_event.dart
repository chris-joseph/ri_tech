part of 'employee_list_bloc.dart';

abstract class EmployeeListEvent extends Equatable {
  const EmployeeListEvent();
  @override
  List<Object?> get props => [];
}

class EmployeeListInitEvent extends EmployeeListEvent {}

class EmployeeListUndoDeleteEvent extends EmployeeListEvent {}

class EmployeeDeleteEvent extends EmployeeListEvent {
  final int id;

  const EmployeeDeleteEvent(this.id);
}
