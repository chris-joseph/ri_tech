import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ri_tech/app/employee/add_edit_employee/bloc/add_edit_employee_bloc.dart';
import 'package:ri_tech/app/employee/add_edit_employee/ui/components/add_edit_date_section.dart';
import 'package:ri_tech/app/employee/add_edit_employee/ui/components/add_edit_employee_bottom_bar.dart';
import 'package:ri_tech/app/employee/add_edit_employee/ui/components/add_edit_name_section.dart';
import 'package:ri_tech/app/employee/add_edit_employee/ui/components/add_edit_role_section.dart';
import 'package:ri_tech/app/employee/common/widgets/employee_appbar.dart';
import 'package:ri_tech/data/repository/employee/employee_repository.dart';
import 'package:ri_tech/design/design.dart';

class AddEditEmployeeScreen extends StatefulWidget {
  final int? employeeId;
  const AddEditEmployeeScreen({this.employeeId, Key? key}) : super(key: key);

  @override
  State<AddEditEmployeeScreen> createState() => _AddEditEmployeeScreenState();
}

class _AddEditEmployeeScreenState extends State<AddEditEmployeeScreen> {
  late TextEditingController _employeeNameController;
  late final AddEditEmployeeBloc _addEditEmployeeBloc;
  late bool _isEditing;
  final _inputBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: outlineGrey, width: 1),
  );
  @override
  void initState() {
    super.initState();
    _isEditing = widget.employeeId != null;
    _addEditEmployeeBloc =
        AddEditEmployeeBloc(employeeRepo: employeeRepo, isEditing: _isEditing);
    _employeeNameController = TextEditingController();
    _employeeNameController.addListener(
      () {
        _addEditEmployeeBloc
            .add(AddEditEmployeeNameUpdateEvent(_employeeNameController.text));
      },
    );
    _addEditEmployeeBloc.add(AddEditEmployeeInitEvent(widget.employeeId));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: getEmployeeAppBar(
            "Add Employee Details",
            _isEditing
                ? [
                    GestureDetector(
                      onTap: () {
                        _addEditEmployeeBloc.add(
                            AddEditEmployeeDeleteEvent(widget.employeeId!));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: SvgPicture.asset(Assets.delete),
                      ),
                    )
                  ]
                : []),
        body: BlocConsumer<AddEditEmployeeBloc, AddEditEmployeeState>(
            bloc: _addEditEmployeeBloc,
            listener: (context, state) {
              if (state is AddEditEmployeeActionState) {
                switch (state.action) {
                  case AddEditEmployeeListAction.validation:
                    final snackBar = SnackBar(
                      content: Text(state.data ?? ""),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    break;
                  case AddEditEmployeeListAction.pop:
                    Navigator.pop(context);
                    break;
                  case AddEditEmployeeListAction.showDeleteSnackBar:
                    final snackBar = SnackBar(
                      content: const Text('Employee data has been deleted'),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          _addEditEmployeeBloc
                              .add(const AddEditEmployeeUndoEvent());
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
                    break;
                  default:
                }
              }
            },
            buildWhen: (p, c) => c is! AddEditEmployeeActionState,
            builder: (context, state) {
              if (state is AddEditEmployeeDataState) {
                _employeeNameController.text = state.employeeName;
                return Column(
                  children: [
                    AddEditEmployeeTextField(
                      employeeNameController: _employeeNameController,
                      inputBorder: _inputBorder,
                    ),
                    AddEditEmployeeRoleField(
                      selectedRole: state.employeeRole,
                      onSelectionChange: (role) {
                        _addEditEmployeeBloc
                            .add(AddEditEmployeeRoleUpdateEvent(role));
                      },
                    ),
                    AddEditEmployeeDateSection(
                      startDate: state.startDate,
                      endDate: state.endDate,
                      onStartDateChange: (date) => _addEditEmployeeBloc
                          .add(AddEditEmployeeStartDateChangeEvent(date)),
                      onEndDateChange: (date) => _addEditEmployeeBloc
                          .add(AddEditEmployeeEndDateChangeEvent(date)),
                    ),
                    const Spacer(),
                    AddEditEmployeeBottomBar(
                      onSave: () => _addEditEmployeeBloc.add(
                        AddEditEmployeeSaveEvent(),
                      ),
                    ),
                  ],
                );
              }
              if (state is AddEditEmployeeLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const SizedBox();
            }),
      ),
    );
  }
}
