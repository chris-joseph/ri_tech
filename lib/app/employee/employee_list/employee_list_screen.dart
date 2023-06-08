import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ri_tech/app/employee/common/widgets/employee_appbar.dart';
import 'package:ri_tech/app/employee/employee_list/bloc/employee_list_bloc.dart';
import 'package:ri_tech/app/employee/employee_list/widgets/employee_list_no_records_widget.dart';
import 'package:ri_tech/data/repository/employee/employee_repository.dart';
import 'package:ri_tech/design/colors.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late final EmployeeListBloc _employeeListBloc;
  @override
  void initState() {
    _employeeListBloc = EmployeeListBloc(employeeRepo: EmployeeRepo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getEmployeeAppBar("Employee List", []),
      floatingActionButton: SizedBox(
        width: 50,
        height: 50,
        child: FittedBox(
          child: FloatingActionButton(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            onPressed: () {},
            backgroundColor: AppColors().buttonPrimary,
            child: Icon(
              Icons.add,
              size: 18,
              color: AppColors().iconSecondary,
            ),
          ),
        ),
      ),
      body: BlocBuilder<EmployeeListBloc, EmployeeListState>(
        bloc: _employeeListBloc,
        builder: (context, state) {
          if (state is EmployeeListEmptyState) {
            return const EmployeeListNoRecordsWidget();
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
