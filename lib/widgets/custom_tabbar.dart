import 'package:cash/utils/values/colors.dart';
import 'package:cash/utils/values/constants.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelPadding: EdgeInsets.zero,
      indicatorColor: whiteColor,
      labelStyle: TextStyle(
        fontSize: 13,
        fontFamily: Constants.fontSFPro,
        color: whiteColorOpacity70,
        fontWeight: FontWeight.w600,
      ),
      tabs: const [
        Tab(text: Constants.dailyTabName),
        Tab(text: Constants.weeklyTabName),
        Tab(text: Constants.monthlyTabName),
        Tab(text: Constants.yearlyTabName),
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 40);
}
