import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ri_tech/data/repository/employee/employee_repository.dart';

part 'employee_list_event.dart';
part 'employee_list_state.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  final EmployeeContract _employeeContract;
  EmployeeListBloc({required EmployeeContract employeeContract})
      : _employeeContract = employeeContract,
        super(EmployeeListLoadingState()) {
    on<EmployeeListEvent>(
      (event, emit) {},
    );

    emit(EmployeeListEmptyState());
  }
}
