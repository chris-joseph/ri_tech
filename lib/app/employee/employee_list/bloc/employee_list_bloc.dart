import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ri_tech/data/models/employee/employee_model.dart';
import 'package:ri_tech/data/repository/employee/employee_repository.dart';

part 'employee_list_event.dart';
part 'employee_list_state.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  final EmployeeContract _employeeRepo;
  final List<EmployeeModel> _currentEmployees = [];
  final List<EmployeeModel> _pastEmployees = [];
  EmployeeModel? _lastDeletedEmployee;
  EmployeeListBloc({required EmployeeContract employeeRepo})
      : _employeeRepo = employeeRepo,
        super(EmployeeListLoadingState()) {
    on<EmployeeListInitEvent>(_init);
    on<EmployeeDeleteEvent>(_onEmployeeDelete);
    add(EmployeeListInitEvent());
  }

  Future<void> _init(EmployeeListInitEvent event, emit) async {
    final List<EmployeeModel?> employees = await _employeeRepo.getEmployees([]);
    for (EmployeeModel? employee in employees) {
      if (employee != null) {
        if (employee.isCurrent) {
          _currentEmployees.add(employee);
        }
        _pastEmployees.add(employee);
      }
    }
  }

  Future<void> _onEmployeeDelete(EmployeeDeleteEvent event, emit) async {
    _lastDeletedEmployee = await _employeeRepo.getEmployee(event.id);
    if (await _employeeRepo.deleteEmployee(event.id)) {
      //TODO(chris): show toast with undo
    }
  }
}
