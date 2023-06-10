import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ri_tech/data/models/employee/employee_model.dart';
import 'package:ri_tech/design/design.dart';

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
        barrierColor: barrierGrey,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
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
