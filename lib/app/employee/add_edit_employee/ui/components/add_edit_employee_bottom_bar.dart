import 'package:flutter/material.dart';
import 'package:ri_tech/app/employee/add_edit_employee/ui/widgets/add_edit_employee_action_button.dart';
import 'package:ri_tech/design/colors.dart';
import 'package:ri_tech/design/padding.dart';

class AddEditEmployeeBottomBar extends StatelessWidget {
  const AddEditEmployeeBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: backgroundGrey, width: 2),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.padding.m,
        vertical: AppPadding.padding.s,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppButtonSmall.secondary(
            buttonText: "Cancel",
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            width: AppPadding.padding.m,
          ),
          AppButtonSmall.primary(
            buttonText: "Save",
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
