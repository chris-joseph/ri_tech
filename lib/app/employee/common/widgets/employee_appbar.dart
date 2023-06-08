import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ri_tech/design/design.dart';

class EmployeeAppbar extends StatelessWidget {
  const EmployeeAppbar({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar();
  }
}

PreferredSizeWidget getEmployeeAppBar(String title, actions) {
  return AppBar(
    titleSpacing: AppPadding.m,
    centerTitle: false,
    leadingWidth: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: blueDark,
      systemNavigationBarColor: blueDark,
      systemNavigationBarDividerColor: blueDark,
      systemStatusBarContrastEnforced: true,
    ),
    backgroundColor: AppColors().appBarBackground,
    title: Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.l),
      child: Text(
        title,
        style: AppFonts().getTextStyle(TStyle.h1)?.copyWith(
              color: AppColors().buttonTextPrimary,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1,
            ),
      ),
    ),
  );
}
