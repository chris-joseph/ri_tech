import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ri_tech/app/employee/add_edit_employee/bloc/add_edit_employee_bloc.dart';
import 'package:ri_tech/app/employee/add_edit_employee/ui/components/add_edit_employee_bottom_bar.dart';
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
    _addEditEmployeeBloc = AddEditEmployeeBloc(
        employeeRepo: EmployeeRepo(), isEditing: _isEditing);
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
        //resizeToAvoidBottomInset: false,
        appBar: getEmployeeAppBar("Add Employee Details", []),
        //bottomNavigationBar: const AddEditEmployeeBottomBar(),
        body: BlocBuilder<AddEditEmployeeBloc, AddEditEmployeeState>(
            bloc: _addEditEmployeeBloc,
            builder: (context, state) {
              if (state is AddEditEmployeeDataState) {
                return Column(
                  children: [
                    AddEditEmployeeTextField(
                      employeeNameController: _employeeNameController,
                      inputBorder: _inputBorder,
                    ),
                    AddEditEmployeeRoleField(selectedRole: state.employeeRole),
                    AddEditEmployeeDateSection(),
                    const Spacer(),
                    const AddEditEmployeeBottomBar()
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
  const AddEditEmployeeDateSection({
    super.key,
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
          AddEditEmployeeDateSectionWidget(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.padding.l,
            ),
            child: SvgPicture.asset(Assets.arrowRight),
          ),
          AddEditEmployeeDateSectionWidget(),
        ],
      ),
    );
  }
}

class AddEditEmployeeDateSectionWidget extends StatelessWidget {
  const AddEditEmployeeDateSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(
              const Duration(days: 365),
            ),
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
              Text("today")
            ],
          ),
        ),
      ),
    );
  }
}

class AddEditEmployeeRoleField extends StatelessWidget {
  const AddEditEmployeeRoleField({
    super.key,
    required EmployeeRole? selectedRole,
  }) : _selectedRole = selectedRole;

  final EmployeeRole? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        //useSafeArea: true,
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
                  return Container(
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
                      style: AppFonts().getTextStyle(TStyle.h2),
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
                    ? AppFonts()
                        .getTextStyle(TStyle.h2)
                        ?.copyWith(color: disabledGrey)
                    : AppFonts().getTextStyle(TStyle.h2),
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
        controller: _employeeNameController,
        style: AppFonts().getTextStyle(TStyle.h2),
        cursorColor: blueDark,
        decoration: InputDecoration(
          enabledBorder: inputBorder,
          border: inputBorder,
          focusedBorder: inputBorder,
          constraints: const BoxConstraints.tightFor(height: 40),
          contentPadding: EdgeInsets.all(AppPadding.padding.xs),
          hintText: "Employee Name",
          hintStyle: AppFonts()
              .getTextStyle(TStyle.h2)
              ?.copyWith(color: disabledGrey, fontSize: 14),
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
