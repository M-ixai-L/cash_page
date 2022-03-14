import 'package:cash/utils/navigation/navigation.dart';
import 'package:cash/utils/navigation/project_router.dart';
import 'package:cash/utils/values/colors.dart';
import 'package:cash/utils/values/constants.dart';
import 'package:cash/utils/values/lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CashScreen extends StatefulWidget {
  const CashScreen({Key? key}) : super(key: key);

  @override
  State<CashScreen> createState() => _CashScreenState();
}

class _CashScreenState extends State<CashScreen> with TickerProviderStateMixin {
  late final tabController;

  final cash = 23092.20;
  final interest = 28.03;
  final interestIncome = 45;
  final expenses = -5320.80;
  final incomes = 9821;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

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
    final appbar = appBar(context);
    final heightList = MediaQuery.of(context).size.height -
        appbar.preferredSize.height -
        MediaQuery.of(context).padding.top -
        165;

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
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 150,
                                child: TabBarView(
                                  controller: tabController,
                                  children: [
                                    balanceWidget,
                                    balanceIncomeWidget,
                                  ],
                                ),
                              ),
                              TabPageSelector(
                                controller: tabController,
                                color: whiteColor.withOpacity(0.30),
                                selectedColor: whiteColor,
                                indicatorSize: 7,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    balanceChangeWidget(heightList),
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
              color: whiteColor.withOpacity(0.5),
            ),
          ),
        ),
        Container(
          child: Text(
            '\$${cash.toStringAsFixed(2)}',
            style: TextStyle(
                fontSize: 40,
                color: whiteColor,
                fontFamily: Constants.FontSFPro,
                fontWeight: FontWeight.w700),
          ),
          padding: const EdgeInsets.only(bottom: 5),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 0),
          child: Text(
            '+ $interest%',
            style: TextStyle(
              fontSize: 16,
              color: whiteColor.withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }

  Widget get balanceIncomeWidget {
    const double indicatorRadius = 115;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding: EdgeInsets.only(right: 48, left: 25),
          child: SizedBox(
            width: indicatorRadius,
            height: indicatorRadius,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: interestIncome / 100,
                  strokeWidth: 6,
                  valueColor: AlwaysStoppedAnimation(whiteColor),
                  backgroundColor: whiteColor.withOpacity(0.15),
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$interestIncome',
                        style: TextStyle(
                            fontSize: 40,
                            color: whiteColor,
                            fontFamily: Constants.FontSFPro,
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(bottom: 15),
                        child: Text(
                          '%',
                          style: TextStyle(
                            fontSize: 19,
                            color: whiteColor.withOpacity(0.5),
                            fontFamily: Constants.FontSFPro,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'INCOMES',
                  style: TextStyle(
                    fontSize: 12,
                    color: whiteColor.withOpacity(0.5),
                    fontFamily: Constants.FontSFPro,
                  ),
                ),
              ),
              Text(
                '\$ $incomes',
                style: TextStyle(
                    fontSize: 24,
                    color: whiteColor,
                    fontFamily: Constants.FontSFPro),
              ),
              Container(
                padding: const EdgeInsets.only(right: 131, top: 16),
                child: Text(
                  'EXPENSES',
                  style: TextStyle(
                    //fontFamily: SF,
                    fontSize: 12,
                    fontFamily: Constants.FontSFPro,
                    color: whiteColor.withOpacity(0.5),
                  ),
                ),
              ),
              Text(
                getSignText(expenses),
                style: TextStyle(
                    fontSize: 24,
                    color: whiteColor,
                    fontFamily: Constants.FontSFPro),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget balanceChangeWidget(double heightList) {
    const Key centerKey = ValueKey<String>('bottom-sliver-list');
    return SizedBox(
      height: heightList,
      child: CustomScrollView(
        center: centerKey,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 28),
                  child: TextButton(
                    onPressed: () => Navigation.toScreen(
                      Routes.addNewTransaction,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: whiteColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8)),
                      height: 40,
                      width: 100,
                      child: Text(
                        'Add new',
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 17,
                          fontFamily: 'SFPro',
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
          SliverList(
            key: centerKey,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListView.separated(
                    itemCount: titleList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => customDivider,
                    itemBuilder: (_, index) => customTile(index),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget get customDivider => Divider(
        color: blackColor.withOpacity(0.1),
        height: 1.0,
      );

  Widget simpleTab(String tabName) {
    return Container(color: whiteColor, child: Center(child: Text(tabName)));
  }

  Widget customTile(int index) {
    return ListTile(
      leading: CircleAvatar(
        radius: 17,
        backgroundColor: accentColor.withOpacity(0.1),
        child: SvgPicture.asset(
          'assets/icons/${iconList[titleList[index]]}.svg',
          // height: 15,
          // width: 13,
          color: accentColor,
        ),
      ),
      title: Text(
        titleList[index],
        style: TextStyle(
            color: blackColor.withOpacity(0.8),
            fontFamily: Constants.FontSFPro,
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
      trailing: Text(
        getSignText(valuesList[index]),
        style: TextStyle(
            color: getColor(valuesList[index]),
            fontSize: 22,
            fontFamily: Constants.FontSFPro,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: accentColor,
      leading: TextButton(
        onPressed: () => Navigator.pop(context),
        child: Row(
          children: const <Widget>[
            Icon(
              Icons.arrow_back_ios_outlined,
              color: whiteColor,
            ),
            Text(
              'Accounts',
              style: TextStyle(
                  fontFamily: Constants.FontSFPro,
                  fontSize: 17,
                  color: whiteColor),
            ),
          ],
        ),
      ),
      leadingWidth: 120,
      title: const Text(
        'Cash',
        style: TextStyle(
            color: Color(0xCCFFFFFF),
            fontFamily: Constants.FontSFPro,
            fontSize: 17),
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => showSnackBar(context, 'Search'),
        ),
        IconButton(
            icon: const Icon(CupertinoIcons.add),
            onPressed: () => Navigation.toScreen(Routes.addNewTransaction)),
      ],
      elevation: 0.0,
      bottom: const TabBar(
        indicatorColor: whiteColor,
        labelStyle: TextStyle(
            fontSize: 13,
            fontFamily: Constants.FontSFPro,
            color: Color(0xB3FFFFFF),
            fontWeight: FontWeight.w600),
        tabs: [
          Tab(
            text: Constants.dailyTabName,
          ),
          Tab(text: Constants.weeklyTabName),
          Tab(text: Constants.monthlyTabName),
          Tab(text: Constants.yearlyTabName),
        ],
      ),
    );
  }
}
