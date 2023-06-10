import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ri_tech/design/design.dart';

class AddEditEmployeeTextField extends StatelessWidget {
  const AddEditEmployeeTextField({
    super.key,
    required TextEditingController employeeNameController,
    required this.inputBorder,
  }) : _employeeNameController = employeeNameController;

  final TextEditingController _employeeNameController;
  final OutlineInputBorder inputBorder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppPadding.padding.xl,
        horizontal: AppPadding.padding.m,
      ),
      child: TextField(
        onTapOutside: (e) => FocusManager.instance.primaryFocus?.unfocus(),
        controller: _employeeNameController,
        style: AppFonts.fonts.h2,
        cursorColor: blueDark,
        decoration: InputDecoration(
          enabledBorder: inputBorder,
          border: inputBorder,
          focusedBorder: inputBorder,
          constraints: const BoxConstraints.tightFor(height: 40),
          contentPadding: EdgeInsets.all(AppPadding.padding.xs),
          hintText: "Employee Name",
          hintStyle: AppFonts.fonts.h2
              .copyWith(color: disabledGrey, fontWeight: FontWeight.w400),
          prefixIcon: Container(
            width: 44,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: AppPadding.padding.xxs),
            child: SvgPicture.asset(
              Assets.person,
              width: 24,
              height: 24,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
  }
}
