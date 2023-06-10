import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ri_tech/data/models/employee/employee_model.dart';
import 'package:ri_tech/data/repository/employee/employee_repository.dart';

part 'employee_list_event.dart';
part 'employee_list_state.dart';

enum EmployeeListAction {
  showDeleteSnackBar,
}

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  final EmployeeContract _employeeRepo;
  final List<EmployeeModel> _currentEmployees = [];
  final List<EmployeeModel> _pastEmployees = [];
  EmployeeListBloc({required EmployeeContract employeeRepo})
      : _employeeRepo = employeeRepo,
        super(EmployeeListLoadingState()) {
    on<EmployeeListInitEvent>(_init);
    on<EmployeeListUndoDeleteEvent>(_onUndoDelete);
    on<EmployeeDeleteEvent>(_onEmployeeDelete);

    _employeeRepo.employeeUpdateSub.listen((EmployeeOperation event) {
      switch (event) {
        case EmployeeOperation.read:
        case EmployeeOperation.readAll:
          break;
        case EmployeeOperation.delete:
        case EmployeeOperation.create:
        case EmployeeOperation.undo:
        case EmployeeOperation.update:
          add(EmployeeListInitEvent());
          break;
      }
    });

    add(EmployeeListInitEvent());
  }

  Future<void> _init(EmployeeListInitEvent event, emit) async {
    final List<EmployeeModel?> employees = await _employeeRepo.getEmployees([]);
    _currentEmployees.clear();
    _pastEmployees.clear();
    if (employees.isEmpty) {
      emit(EmployeeListEmptyState());
      return;
    }
    for (EmployeeModel? employee in employees) {
      if (employee != null) {
        if (employee.isCurrent) {
          _currentEmployees.add(employee);
        } else {
          _pastEmployees.add(employee);
        }
      }
    }
    emit(
      EmployeeListDataState(_currentEmployees, _pastEmployees),
    );
  }

  Future<void> _onUndoDelete(EmployeeListUndoDeleteEvent event, emit) async {
    await _employeeRepo.undoDeleteEmployee();
  }

  Future<void> _onEmployeeDelete(EmployeeDeleteEvent event, emit) async {
    final res = await _employeeRepo.deleteEmployee(event.id);
    if (res) {
      emit(
          const EmployeeListActionState(EmployeeListAction.showDeleteSnackBar));
    }
  }
}
