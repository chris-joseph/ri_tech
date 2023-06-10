import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ri_tech/app/employee/common/widgets/employee_appbar.dart';
import 'package:ri_tech/app/employee/employee_list/bloc/employee_list_bloc.dart';
import 'package:ri_tech/app/employee/employee_list/widgets/employee_list_no_records_widget.dart';
import 'package:ri_tech/data/models/employee/employee_model.dart';
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

class EmployeeListSection extends StatelessWidget {
  const EmployeeListSection({
    super.key,
    required EmployeeListBloc employeeListBloc,
    required this.isPast,
    required this.list,
  }) : _employeeListBloc = employeeListBloc;

  final EmployeeListBloc _employeeListBloc;
  final bool isPast;
  final List<EmployeeModel> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: backgroundGrey,
          padding: EdgeInsets.all(AppPadding.padding.m),
          width: double.infinity,
          height: 56,
          child: Text(
            isPast ? "Previous employees" : "Current employees",
            style: AppFonts.fonts.h2
                .copyWith(color: AppColors.colors.buttonTextSecondary),
          ),
        ),
        Expanded(
          child: Container(
            color: white,
            child: ListView.separated(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) => Dismissible(
                key: ObjectKey(DateTime.now()),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                  color: AppColors.colors.tertiary,
                  child: SvgPicture.asset(Assets.delete),
                ),
                onDismissed: (direction) {
                  _employeeListBloc.add(
                    EmployeeDeleteEvent(list[index].id ?? 0),
                  );
                },
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, editEmployee,
                        arguments: list[index].id);
                  },
                  child: Container(
                    color: white,
                    padding: EdgeInsets.all(AppPadding.padding.m),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          list[index].name ?? "",
                          style: AppFonts.fonts.h2
                              .copyWith(color: AppColors.colors.textPrimary),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          list[index].role?.title ?? "",
                          style: AppFonts.fonts.b1
                              .copyWith(color: AppColors.colors.textSecondary),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            Text(
                              "From ${Jiffy.parseFromDateTime(list[index].startDate ?? DateTime.now()).format(pattern: "d MMM, y")}",
                              style: AppFonts.fonts.b2.copyWith(
                                  color: AppColors.colors.textSecondary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                color: outlineGrey,
                height: 1,
                thickness: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
