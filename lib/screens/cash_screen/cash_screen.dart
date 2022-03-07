import 'package:cash/custom_icons.dart';
import 'package:cash/utils/values/colors.dart';
import 'package:cash/utils/values/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CashScreen extends StatelessWidget {
  CashScreen({Key? key}) : super(key: key);

  final cash = 23092.20;
  final interest = 28.03;

  final iconList = [
    Icons.home_filled,
    CustomIcons.cab,
    CustomIcons.money,
    CustomIcons.food,
    CustomIcons.coffeeCup,
    CustomIcons.food,
    CustomIcons.mobile,
    CustomIcons.mobile,
    CustomIcons.mobile,
  ];

  final titleList = [
    'Rental revenue',
    'Car',
    'Salary',
    'Food & Restaurants',
    'Coffee',
    'Food & Restaurants',
    'Mobile Account',
    'Mobile Account',
    'Mobile Account',
  ];

  final valuesList = <double>[1500, -193.02, 7500, 37, 2, 5, 19.99, -5454, 64];

  Color getColor(double value) => value >= 0 ? accentColor : redColor;

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  String getSignText(double sign) {
    final value = sign % 1 == 0 ? sign.toInt() : sign;

    if (!value.isNegative) return '\$$value';
    return value.toString().replaceRange(1, 1, '\$');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: appBar(context),
        backgroundColor: accentColor,
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Container(
                color: accentColor,
                child: Column(
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              Container(
                                height: 150,
                                child: PageView(
                                  children: [
                                    balanceWidget,
                                    balanceWidget,
                                  ],
                                ),
                              ),
                              TabPageSelector(
                                color: whiteOpacity,
                                selectedColor: Colors.white,
                                indicatorSize: 7,
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListView.separated(
                              itemCount: titleList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (_, __) => customDivider,
                              itemBuilder: (_, index) => customTile(index),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            simpleTab(Constants.weeklyTabName),
            simpleTab(Constants.monthlyTabName),
            simpleTab(Constants.dailyTabName),
          ],
        ),
      ),
    );
  }

  Widget get balanceWidget {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 30),
          child: Text(
            'BALANCE',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFFDEDEDE).withOpacity(0.5),
            ),
          ),
        ),
        Container(
          child: Text(
            '\$ $cash',
            style: TextStyle(fontSize: 40, color: Colors.white),
          ),
          padding: const EdgeInsets.only(bottom: 5),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 0),
          child: Text(
            '+ $interest %',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }

  Widget get customDivider => Divider(
        color: Colors.black.withOpacity(0.1),
        height: 1.0,
      );

  Widget simpleTab(String tabName) {
    return Container(color: Colors.white, child: Center(child: Text(tabName)));
  }

  Widget customTile(int index) {
    const leadingSize = 34.0;
    return ListTile(
      leading: Container(
        height: leadingSize,
        width: leadingSize,
        decoration: BoxDecoration(
          color: accentColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconList[index],
          color: accentColor,
        ),
      ),
      title: Text(titleList[index]),
      trailing: Text(
        getSignText(valuesList[index]),
        style: TextStyle(
          color: getColor(valuesList[index]),
          fontSize: 20,
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: accentColor,
      leading: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined),
            onPressed: () => showSnackBar(context, 'Go to home'),
          ),
          Text('Accounts', style: TextStyle(fontSize: 17)),
        ],
      ),
      leadingWidth: 120,
      title: const Text('Cash'),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => showSnackBar(context, 'Search'),
        ),
        IconButton(
          icon: const Icon(CupertinoIcons.add),
          onPressed: () => showSnackBar(context, 'New'),
        ),
      ],
      elevation: 0.0,
      bottom: const TabBar(
        indicatorColor: Colors.white,
        labelStyle: TextStyle(fontSize: 13),
        tabs: [
          Tab(text: Constants.dailyTabName),
          Tab(text: Constants.weeklyTabName),
          Tab(text: Constants.monthlyTabName),
          Tab(text: Constants.yearlyTabName),
        ],
      ),
    );
  }
}
