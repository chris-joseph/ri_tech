import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ri_tech/app/employee/add_edit_employee/bloc/add_edit_employee_bloc.dart';
import 'package:ri_tech/app/employee/add_edit_employee/ui/components/add_edit_employee_bottom_bar.dart';
import 'package:ri_tech/app/employee/common/widgets/date_picker.dart';
import 'package:ri_tech/app/employee/common/widgets/employee_appbar.dart';
import 'package:ri_tech/data/models/employee/employee_model.dart';
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

class AddEditEmployeeDateSection extends StatelessWidget {
  final Function(DateTime) onStartDateChange;
  final Function(DateTime?) onEndDateChange;
  final DateTime startDate;
  final DateTime? endDate;
  const AddEditEmployeeDateSection({
    super.key,
    required this.onStartDateChange,
    required this.onEndDateChange,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppPadding.padding.xl,
        horizontal: AppPadding.padding.m,
      ),
      child: Row(
        children: [
          AddEditEmployeeDateSectionWidget(
            selectedDate: startDate,
            onChange: (dateTime) {
              onStartDateChange(dateTime!);
            },
            quickSelectOptions: const [
              DatePickerQuickSelectOptions.today,
              DatePickerQuickSelectOptions.nextMonday,
              DatePickerQuickSelectOptions.nextTuesday,
              DatePickerQuickSelectOptions.nextWeek
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.padding.l,
            ),
            child: SvgPicture.asset(Assets.arrowRight),
          ),
          AddEditEmployeeDateSectionWidget(
            selectedDate: endDate,
            onChange: (dateTime) {
              onEndDateChange(dateTime);
            },
            quickSelectOptions: const [
              DatePickerQuickSelectOptions.today,
              DatePickerQuickSelectOptions.noDate
            ],
          ),
        ],
      ),
    );
  }
}

class AddEditEmployeeDateSectionWidget extends StatelessWidget {
  final List<DatePickerQuickSelectOptions> quickSelectOptions;
  final DateTime? selectedDate;
  final Function(DateTime?) onChange;
  const AddEditEmployeeDateSectionWidget({
    super.key,
    required this.quickSelectOptions,
    this.selectedDate,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: () {
          showDialog(
            barrierColor: barrierGrey,
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: white,
                insetPadding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Container(
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(16)),
                  child: DatePicker(
                    selectedDate: selectedDate,
                    quickSelectOptions: quickSelectOptions,
                    onChange: onChange,
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: outlineGrey),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.padding.xxs,
                ),
                child: SvgPicture.asset(Assets.calendar),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                getDateString(selectedDate),
                style: AppFonts.fonts.h1,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddEditEmployeeRoleField extends StatelessWidget {
  final Function(EmployeeRole) onSelectionChange;
  const AddEditEmployeeRoleField({
    super.key,
    required EmployeeRole? selectedRole,
    required this.onSelectionChange,
  }) : _selectedRole = selectedRole;

  final EmployeeRole? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        useSafeArea: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
        ),
        constraints: const BoxConstraints(maxHeight: 212),
        barrierColor: barrierGrey,
        builder: (BuildContext context) {
          return Column(
            children: [
              ...List.generate(
                EmployeeRole.values.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      onSelectionChange(EmployeeRole.values[index]);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(AppPadding.padding.m),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: outlineGrey,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Text(
                        EmployeeRole.values[index].title,
                        style: AppFonts.fonts.h2,
                      ),
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
      child: Container(
        height: 40,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: AppPadding.padding.m),
        padding: EdgeInsets.symmetric(horizontal: AppPadding.padding.xxs),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: outlineGrey),
        ),
        child: Row(
          children: [
            SvgPicture.asset(Assets.role),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                _selectedRole?.title ?? "Select Role",
                style: _selectedRole == null
                    ? AppFonts.fonts.h2.copyWith(color: disabledGrey)
                    : AppFonts.fonts.h2,
              ),
            ),
            SvgPicture.asset(Assets.dropDown),
          ],
        ),
      ),
    );
  }
}

class AddEditEmployeeTextField extends StatelessWidget {
  const AddEditEmployeeTextField({
    super.key,
    required TextEditingController employeeNameController,
    required this.inputBorder,
  }) : _employeeNameController = employeeNameController;

  final TextEditingController _employeeNameController;
  final OutlineInputBorder inputBorder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppPadding.padding.xl,
        horizontal: AppPadding.padding.m,
      ),
      child: TextField(
        onTapOutside: (e) => FocusManager.instance.primaryFocus?.unfocus(),
        controller: _employeeNameController,
        style: AppFonts.fonts.h2,
        cursorColor: blueDark,
        decoration: InputDecoration(
          enabledBorder: inputBorder,
          border: inputBorder,
          focusedBorder: inputBorder,
          constraints: const BoxConstraints.tightFor(height: 40),
          contentPadding: EdgeInsets.all(AppPadding.padding.xs),
          hintText: "Employee Name",
          hintStyle: AppFonts.fonts.b1.copyWith(color: disabledGrey),
          prefixIcon: Container(
            width: 44,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: AppPadding.padding.xxs),
            child: SvgPicture.asset(
              Assets.person,
              width: 24,
              height: 24,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
  }
}
