import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ri_tech/app/employee/common/widgets/date_picker/date_picker.dart';
import 'package:ri_tech/design/design.dart';

class AddEditEmployeeDateSectionWidget extends StatelessWidget {
  final List<DatePickerQuickSelectOptions> quickSelectOptions;
  final DateTime? selectedDate;
  final Function(DateTime?) onChange;
  const AddEditEmployeeDateSectionWidget({
    super.key,
    required this.quickSelectOptions,
    this.selectedDate,
    required this.onChange,
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
              const SizedBox(
                width: 8,
              ),
              Text(
                getDateString(selectedDate),
                style: AppFonts.fonts.h1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
