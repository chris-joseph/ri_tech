import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ri_tech/app/employee/add_edit_employee/ui/widgets/add_edit_date_section_widget.dart';
import 'package:ri_tech/app/employee/common/widgets/date_picker/date_picker.dart';
import 'package:ri_tech/design/design.dart';

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
            firstDate: DateTime.now(),
            //lastDate: DateTime.now().add(Duration(days: 5)),
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
