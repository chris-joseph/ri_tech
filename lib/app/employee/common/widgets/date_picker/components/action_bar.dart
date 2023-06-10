import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ri_tech/app/employee/add_edit_employee/ui/widgets/add_edit_employee_action_button.dart';
import 'package:ri_tech/app/employee/common/widgets/date_picker/date_picker.dart';
import 'package:ri_tech/design/design.dart';

class DatePickerBottomBar extends StatelessWidget {
  final Jiffy? selectedDate;
  final Function(DateTime?) onTap;
  const DatePickerBottomBar({Key? key, this.selectedDate, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: backgroundGrey, width: 1),
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
          SvgPicture.asset(Assets.calendar),
          const SizedBox(
            width: 4,
          ),
          Text(
            getDateString(selectedDate?.dateTime),
            style: const TextStyle(fontFamily: fontFamily, fontSize: 16),
          ),
          const Spacer(),
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
              onTap(selectedDate?.dateTime);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
