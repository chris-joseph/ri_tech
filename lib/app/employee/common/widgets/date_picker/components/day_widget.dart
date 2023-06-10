import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ri_tech/design/design.dart';

class DatePickerDayWidget extends StatelessWidget {
  final Jiffy date;
  final Jiffy? selectedDate;
  final Jiffy currentDate;
  final bool isDisabled;
  final Function(Jiffy) onTap;
  const DatePickerDayWidget({
    super.key,
    required this.date,
    this.selectedDate,
    required this.currentDate,
    required this.onTap,
    required this.isDisabled,
  });
  Color _getFontColor() {
    if (isDisabled) {
      return outlineGrey;
    }
    if (selectedDate != null && date.isSame(selectedDate!, unit: Unit.day)) {
      return white;
    }
    if (date.isSame(Jiffy.now(), unit: Unit.day)) {
      return AppColors.colors.primary;
    }
    return AppColors.colors.textPrimary;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? null : () => onTap(date),
      child: Container(
        margin: const EdgeInsets.all(3),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selectedDate != null
                ? date.isSame(selectedDate!, unit: Unit.day)
                    ? AppColors.colors.primary
                    : white
                : white,
            border: date.isSame(Jiffy.now(), unit: Unit.day)
                ? Border.all(color: AppColors.colors.primary)
                : null),
        child: Text(
          date.dateTime.day.toString(),
          style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 15,
              color: _getFontColor(),
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
