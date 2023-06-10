import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ri_tech/app/employee/employee_list/bloc/employee_list_bloc.dart';
import 'package:ri_tech/data/models/employee/employee_model.dart';
import 'package:ri_tech/design/design.dart';
import 'package:ri_tech/routes/routes.dart';

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
            style: AppFonts.fonts.h2.copyWith(
                color: AppColors.colors.buttonTextSecondary,
                fontWeight: FontWeight.w500),
          ),
        ),
        Flexible(
          child: ListView.separated(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: list.length,
            padding: EdgeInsets.zero,
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
                      if (!isPast)
                        Row(
                          children: [
                            Text(
                              "From ${Jiffy.parseFromDateTime(list[index].startDate ?? DateTime.now()).format(pattern: "d MMM, y")}",
                              style: AppFonts.fonts.b2.copyWith(
                                  color: AppColors.colors.textSecondary),
                            ),
                          ],
                        ),
                      if (isPast)
                        Row(
                          children: [
                            Text(
                              "${Jiffy.parseFromDateTime(list[index].startDate ?? DateTime.now()).format(pattern: "d MMM, y")} - ${Jiffy.parseFromDateTime(list[index].endDate ?? DateTime.now()).format(pattern: "d MMM, y")}",
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
      ],
    );
  }
}
