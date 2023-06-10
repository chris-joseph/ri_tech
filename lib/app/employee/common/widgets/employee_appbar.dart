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

PreferredSizeWidget getEmployeeAppBar(String title, List<Widget>? actions) {
  return AppBar(
    titleSpacing: AppPadding.padding.m,
    centerTitle: false,
    leadingWidth: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: blueDark,
      systemNavigationBarColor: blueDark,
      systemNavigationBarDividerColor: blueDark,
      systemStatusBarContrastEnforced: true,
    ),
    backgroundColor: AppColors.colors.appBarBackground,
    actions: actions ?? <Widget>[],
    automaticallyImplyLeading: false,
    title: Padding(
      padding: EdgeInsets.symmetric(vertical: AppPadding.padding.l),
      child: Text(
        title,
        style: AppFonts.fonts.h1.copyWith(
          color: AppColors.colors.buttonTextPrimary,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
    ),
  );
}
