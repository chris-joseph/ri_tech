import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ri_tech/app/employee/common/widgets/date_picker/date_picker.dart';
import 'package:ri_tech/design/design.dart';

class AddEditEmployeeDateSectionWidget extends StatelessWidget {
  final List<DatePickerQuickSelectOptions> quickSelectOptions;
  final DateTime? selectedDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Function(DateTime?) onChange;
  const AddEditEmployeeDateSectionWidget({
    super.key,
    required this.quickSelectOptions,
    this.selectedDate,
    required this.onChange,
    this.firstDate,
    this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: () {
          showDialog(
            barrierColor: barrierGrey,
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: white,
                insetPadding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Container(
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(16)),
                  child: DatePicker(
                    firstDate: firstDate,
                    lastDate: lastDate,
                    selectedDate: selectedDate,
                    quickSelectOptions: quickSelectOptions,
                    onChange: onChange,
                  ),
                ),
              );
            },
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
              Text(
                getDateString(selectedDate),
                style: AppFonts.fonts.b1.copyWith(
                    color: selectedDate == null
                        ? AppColors.colors.textSecondary
                        : AppColors.colors.textPrimary),
              )
            ],
          ),
        ),
      ),
    );
  }
}
