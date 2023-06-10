import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ri_tech/app/employee/common/widgets/date_picker/components/action_bar.dart';
import 'package:ri_tech/app/employee/common/widgets/date_picker/components/day_widget.dart';
import 'package:ri_tech/app/employee/common/widgets/date_picker/components/quick_options.dart';
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
  final DateTime? firstDate;
  final DateTime? lastDate;

  final Function(DateTime?) onChange;
  const DatePicker({
    Key? key,
    required this.quickSelectOptions,
    this.selectedDate,
    required this.onChange,
    this.firstDate,
    this.lastDate,
  }) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  void initState() {
    super.initState();
    if (widget.selectedDate != null) {
      selectedDate = Jiffy.parseFromDateTime(widget.selectedDate!);
    }
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
    bool isDisabled(int day) {
      bool c1 = false;
      bool c2 = false;
      final date = Jiffy.parse("${currentDate.year}-${currentDate.month}-$day");
      if (widget.firstDate != null) {
        c1 = Jiffy.parseFromDateTime(widget.firstDate!)
            .isAfter(date, unit: Unit.day);
      }
      if (widget.lastDate != null) {
        c2 = Jiffy.parseFromDateTime(widget.lastDate!)
            .isBefore(date, unit: Unit.day);
      }
      return c1 || c2;
    }

    final list = List.generate(
      daysIn,
      (index) => DatePickerDayWidget(
        isDisabled: isDisabled(index + 1),
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
      ...List.filled(8 - (firstDay.dayOfWeek - 1), const SizedBox()),
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
                if (widget.firstDate != null &&
                    currentDate.subtract(months: 1).isBefore(
                        Jiffy.parseFromDateTime(widget.firstDate!),
                        unit: Unit.month)) {
                  return;
                }
                prevMonth();
              },
              child: RotatedBox(
                quarterTurns: 2,
                child: SvgPicture.asset(
                  Assets.arrow,
                  color: widget.firstDate != null &&
                          currentDate.subtract(months: 1).isBefore(
                              Jiffy.parseFromDateTime(widget.firstDate!),
                              unit: Unit.month)
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
                if (widget.lastDate != null &&
                    currentDate.add(months: 1).isAfter(
                        Jiffy.parseFromDateTime(widget.lastDate!),
                        unit: Unit.month)) {
                  return;
                }
                nextMonth();
              },
              child: SvgPicture.asset(
                Assets.arrow,
                color: widget.lastDate != null &&
                        currentDate.add(months: 1).isAfter(
                            Jiffy.parseFromDateTime(widget.lastDate!),
                            unit: Unit.month)
                    ? outlineGrey
                    : disabledGrey,
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

String getDateString(DateTime? dateTime) {
  if (dateTime == null) {
    return "No Date";
  }
  if (Jiffy.parseFromDateTime(dateTime).isSame(Jiffy.now(), unit: Unit.day)) {
    return "Today";
  }
  return Jiffy.parseFromDateTime(dateTime).format(pattern: 'd MMM y');
}
