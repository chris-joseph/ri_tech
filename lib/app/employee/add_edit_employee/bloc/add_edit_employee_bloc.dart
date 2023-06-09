import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ri_tech/data/models/employee/employee_model.dart';
import 'package:ri_tech/data/repository/employee/employee_repository.dart';

part 'add_edit_employee_event.dart';
part 'add_edit_employee_state.dart';

class AddEditEmployeeBloc
    extends Bloc<AddEditEmployeeEvent, AddEditEmployeeState> {
  final EmployeeRepo _employeeRepo;
  late int? _employeeId;
  late String _employeeName;
  EmployeeRole? _employeeRole;
  late DateTime _startDate;
  DateTime? _endDate;
  final bool isEditing;
  AddEditEmployeeBloc({
    required EmployeeRepo employeeRepo,
    required this.isEditing,
  })  : _employeeRepo = employeeRepo,
        super(AddEditEmployeeLoadingState()) {
    on<AddEditEmployeeInitEvent>(_init);
    on<AddEditEmployeeNameUpdateEvent>(_nameChange);
    on<AddEditEmployeeRoleUpdateEvent>(_roleChange);
    on<AddEditEmployeeStartDateChangeEvent>(_startDateChange);
    on<AddEditEmployeeEndDateChangeEvent>(_endDateChange);
    on<AddEditEmployeeSaveEvent>(_save);
  }

  AddEditEmployeeDataState get dataState => AddEditEmployeeDataState(
        employeeName: _employeeName,
        employeeRole: _employeeRole,
        startDate: _startDate,
        endDate: _endDate,
        isEditing: isEditing,
      );

  Future<void> _init(AddEditEmployeeInitEvent event, emit) async {
    if (isEditing) {
      final employee = await _employeeRepo.getEmployee(event.employeeId!);
      _employeeName = employee?.name ?? "";
      _employeeRole = employee?.role ?? EmployeeRole.flutterDeveloper;
      _startDate = employee?.startDate ?? DateTime.now();
      _endDate = employee?.endDate;
      _employeeId = employee?.id;
    } else {
      _employeeName = "";
      _startDate = DateTime.now();
    }
    emit(dataState);
  }

  Future<void> _nameChange(AddEditEmployeeNameUpdateEvent event, emit) async {
    _employeeName = event.employeeName;
  }

  Future<void> _roleChange(AddEditEmployeeRoleUpdateEvent event, emit) async {
    _employeeRole = event.employeeRole;
    emit(dataState);
  }

  Future<void> _startDateChange(
      AddEditEmployeeStartDateChangeEvent event, emit) async {
    _startDate = event.startDate;
    emit(dataState);
  }

  Future<void> _endDateChange(
      AddEditEmployeeEndDateChangeEvent event, emit) async {
    _endDate = event.endDate;
    emit(dataState);
  }

  Future<void> _save(AddEditEmployeeSaveEvent event, emit) async {
    //TODO(chris): Validate
    //name len>=3
    //startDate !=null
    //role !=null
    //if isEdit =>id !=null
    final employee = await _employeeRepo.createEmployee(
      EmployeeModel(
        name: _employeeName,
        role: _employeeRole,
        id: _employeeId,
        endDate: _endDate,
        startDate: _startDate,
      ),
    );
  }
}
