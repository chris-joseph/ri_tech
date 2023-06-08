import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ri_tech/design/assets.dart';

class EmployeeListNoRecordsWidget extends StatelessWidget {
  const EmployeeListNoRecordsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 74),
      child: SvgPicture.asset(Assets.noEmployeeFound),
    );
  }
}
