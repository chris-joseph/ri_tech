import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ri_tech/app/employee/common/widgets/employee_appbar.dart';
import 'package:ri_tech/app/employee/employee_list/bloc/employee_list_bloc.dart';
import 'package:ri_tech/app/employee/employee_list/components/employee_list_section.dart';
import 'package:ri_tech/app/employee/employee_list/widgets/employee_list_no_records_widget.dart';
import 'package:ri_tech/data/repository/employee/employee_repository.dart';
import 'package:ri_tech/design/design.dart';
import 'package:ri_tech/routes/routes.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late final EmployeeListBloc _employeeListBloc;
  @override
  void initState() {
    _employeeListBloc = EmployeeListBloc(employeeRepo: employeeRepo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getEmployeeAppBar("Employee List", []),
      backgroundColor: backgroundGrey,
      floatingActionButton: SizedBox(
        width: 50,
        height: 50,
        child: FittedBox(
          child: FloatingActionButton(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            onPressed: () {
              Navigator.pushNamed(context, addEmployee);
            },
            backgroundColor: AppColors.colors.buttonPrimary,
            child: SvgPicture.asset(Assets.plus),
          ),
        ),
      ),
      body: BlocConsumer<EmployeeListBloc, EmployeeListState>(
        bloc: _employeeListBloc,
        listener: (context, state) {
          if (state is EmployeeListActionState) {
            switch (state.action) {
              case EmployeeListAction.showDeleteSnackBar:
                final snackBar = SnackBar(
                  content: const Text('Employee data has been deleted'),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      _employeeListBloc.add(EmployeeListUndoDeleteEvent());
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                break;
              default:
            }
          }
        },
        buildWhen: (p, c) => c is! EmployeeListActionState,
        builder: (context, state) {
          if (state is EmployeeListEmptyState) {
            return const EmployeeListNoRecordsWidget();
          }
          if (state is EmployeeListDataState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.currentEmployees.isNotEmpty)
                  Expanded(
                    child: EmployeeListSection(
                        isPast: false,
                        employeeListBloc: _employeeListBloc,
                        list: state.currentEmployees),
                  ),
                if (state.pastEmployees.isNotEmpty)
                  Expanded(
                    child: EmployeeListSection(
                        isPast: true,
                        employeeListBloc: _employeeListBloc,
                        list: state.pastEmployees),
                  ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.padding.m,
                      vertical: AppPadding.padding.s),
                  height: 76,
                  color: backgroundGrey,
                  child: Text(
                    "Swipe left to delete",
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 15,
                      color: AppColors.colors.textSecondary,
                    ),
                  ),
                )
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
