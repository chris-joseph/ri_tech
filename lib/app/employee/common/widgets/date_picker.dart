import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ri_tech/app/employee/add_edit_employee/ui/widgets/add_edit_employee_action_button.dart';
import 'package:ri_tech/design/design.dart';

enum DaysOfWeek {
  sunday("Sun"),
  monday("Mon"),
  tuesday("Tue"),
  wednesday("Wed"),
  thursday("Thu"),
  friday("Fri"),
  saturday("Sat");

  final String shortName;
  const DaysOfWeek(this.shortName);
}

enum DatePickerQuickSelectOptions {
  today("Today"),
  nextMonday("Next Monday"),
  nextTuesday("Next Tuesday"),
  nextWeek("After 1 Week"),
  noDate("No Date");

  final String title;
  const DatePickerQuickSelectOptions(this.title);
}

class DatePicker extends StatefulWidget {
  final List<DatePickerQuickSelectOptions> quickSelectOptions;
  final DateTime? selectedDate;
  final Function(DateTime?) onChange;
  const DatePicker(
      {Key? key,
      required this.quickSelectOptions,
      this.selectedDate,
      required this.onChange})
      : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  void initState() {
    super.initState();
  }

  Widget buildQuickOptions() {
    List<Widget> list = [];
    for (DatePickerQuickSelectOptions option in widget.quickSelectOptions) {
      switch (option) {
        case DatePickerQuickSelectOptions.noDate:
          list.add(DatePickerQuickOptionsWidget(
            title: option.title,
            onTap: () {
              selectedDate = null;
              setState(() {});
            },
            isSelected: selectedDate == null,
          ));
          break;
        case DatePickerQuickSelectOptions.today:
          list.add(DatePickerQuickOptionsWidget(
            title: option.title,
            onTap: () {
              selectedDate = Jiffy.now();
              setState(() {});
            },
            isSelected:
                selectedDate?.isSame(Jiffy.now(), unit: Unit.day) ?? false,
          ));
          break;
        case DatePickerQuickSelectOptions.nextMonday:
          list.add(DatePickerQuickOptionsWidget(
            title: option.title,
            onTap: () {
              selectedDate = next(2, Jiffy.now());
              setState(() {});
            },
            isSelected:
                selectedDate?.isSame(next(2, Jiffy.now()), unit: Unit.day) ??
                    false,
          ));
          break;
        case DatePickerQuickSelectOptions.nextTuesday:
          list.add(
            DatePickerQuickOptionsWidget(
              title: option.title,
              onTap: () {
                selectedDate = next(3, Jiffy.now());
                setState(() {});
              },
              isSelected:
                  selectedDate?.isSame(next(3, Jiffy.now()), unit: Unit.day) ??
                      false,
            ),
          );
          break;
        case DatePickerQuickSelectOptions.nextWeek:
          list.add(
            DatePickerQuickOptionsWidget(
              title: option.title,
              onTap: () {
                selectedDate = Jiffy.now().add(weeks: 1);
                setState(() {});
              },
              isSelected: selectedDate?.isSame(Jiffy.now().add(weeks: 1),
                      unit: Unit.day) ??
                  false,
            ),
          );
          break;
      }
    }
    return GridView.custom(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 36,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      childrenDelegate: SliverChildBuilderDelegate(
          childCount: list.length, (context, index) => list[index]),
    );
  }

  Jiffy currentDate = Jiffy.now();
  Jiffy? selectedDate;
  final today = Jiffy.now();

  Jiffy next(int nextWeekday, Jiffy fromDate) {
    return fromDate.add(
      days: (nextWeekday - fromDate.dayOfWeek) % DateTime.daysPerWeek,
    );
  }

  void setSelectedDate(Jiffy date) {
    selectedDate = date;
    setState(() {});
  }

  List<Widget> getDaysView() {
    final daysIn = currentDate.daysInMonth;
    final firstDay = Jiffy.parse("${currentDate.year}-${currentDate.month}-01");
    final list = List.generate(
      daysIn,
      (index) => DatePickerDayWidget(
        isDisabled: Jiffy.now().isAfter(
            Jiffy.parse(
                "${currentDate.year}-${currentDate.month}-${(index + 1)}"),
            unit: Unit.day),
        onTap: setSelectedDate,
        date: Jiffy.parse(
            "${currentDate.year}-${currentDate.month}-${(index + 1)}"),
        currentDate: currentDate,
        selectedDate: selectedDate,
      ),
    );
    final newList = [
      ...List.generate(
        DaysOfWeek.values.length,
        (index) => Container(
          alignment: Alignment.center,
          child: Text(DaysOfWeek.values[index].shortName),
        ),
      ),
      ...List.filled(firstDay.dayOfWeek - 1, const SizedBox()),
      ...list,
      ...List.filled(7 - (firstDay.dayOfWeek - 1), const SizedBox()),
    ];
    return newList;
  }

  void nextMonth() {
    currentDate = currentDate.add(months: 1);
    setState(() {});
  }

  void prevMonth() {
    currentDate = currentDate.subtract(months: 1);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> calendarDays = getDaysView();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 8,
        ),
        buildQuickOptions(),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                if (currentDate
                    .subtract(months: 1)
                    .isBefore(today, unit: Unit.month)) {
                  return;
                }
                prevMonth();
              },
              child: RotatedBox(
                quarterTurns: 2,
                child: SvgPicture.asset(
                  Assets.arrow,
                  color: currentDate
                          .subtract(months: 1)
                          .isBefore(today, unit: Unit.month)
                      ? outlineGrey
                      : disabledGrey,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              currentDate.format(pattern: 'MMMM y'),
              style: const TextStyle(
                fontFamily: fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            InkWell(
              onTap: () {
                nextMonth();
              },
              child: SvgPicture.asset(
                Assets.arrow,
                color: disabledGrey,
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
          child: GridView.custom(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisExtent: 36,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            childrenDelegate: SliverChildBuilderDelegate(
              childCount: calendarDays.length,
              (context, index) => calendarDays[index],
            ),
          ),
        ),
        DatePickerBottomBar(
          onTap: widget.onChange,
          selectedDate: selectedDate,
        ),
      ],
    );
  }
}

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

class DatePickerQuickOptionsWidget extends StatelessWidget {
  final String title;

  final bool isSelected;
  final Function onTap;
  const DatePickerQuickOptionsWidget({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.colors.buttonPrimary
              : AppColors.colors.buttonSecondary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 14,
            color: isSelected
                ? AppColors.colors.buttonTextPrimary
                : AppColors.colors.buttonTextSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

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

String getDateString(DateTime? dateTime) {
  if (dateTime == null) {
    return "No Date";
  }
  if (Jiffy.parseFromDateTime(dateTime).isSame(Jiffy.now(), unit: Unit.day)) {
    return "Today";
  }
  return Jiffy.parseFromDateTime(dateTime).format(pattern: 'd MMM y');
}
