import 'package:cash/utils/navigation/navigation.dart';
import 'package:cash/utils/navigation/project_router.dart';
import 'package:cash/utils/values/colors.dart';
import 'package:cash/utils/values/constants.dart';
import 'package:cash/utils/values/lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen>
    with TickerProviderStateMixin {
  late final tabController;
  final balance = -171559.8;
  final interest = 4.28;
  final interestIncome = 45;
  final expenses = -5320.80;
  final incomes = 9821;

  String getSignText(double sign) {
    final value = sign % 1 == 0 ? sign.toInt() : sign;
    if (!value.isNegative) return '\$$value';

    return value.toString().replaceRange(1, 1, '\$');
  }

  Color getColor(double value) => value >= 0 ? accentColor : redColor;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
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
        backgroundColor: getColor(balance),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Container(
                color: getColor(balance),
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
            getSignText(balance),
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        itemCount: accountList.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, index) => customTile(index),
        separatorBuilder: (_, __) => customDivider,
      ),
    );
  }

  Widget get customDivider => Divider(
        color: getColor(balance),
        height: 8.0,
      );

  Widget simpleTab(String tabName) {
    return Container(color: whiteColor, child: Center(child: Text(tabName)));
  }

  Widget customTile(int index) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: whiteColor),
      child: ListTile(
        onTap: () => Navigation.toScreen(Routes.cash),
        title: Text(
          accountList[index],
          style: TextStyle(
              color: blackColor.withOpacity(0.8),
              fontFamily: Constants.FontSFPro,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          getSignText(valuesList[index]),
          style: TextStyle(
              color: getColor(valuesList[index]),
              fontSize: 28,
              fontFamily: Constants.FontSFPro,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget get bottomSheetWidget {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 10),
      height: 230,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Container(
                  height: 38,
                  alignment: Alignment.center,
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: blackColor.withOpacity(0.3),
                      fontSize: 13,
                      fontFamily: 'SFPro',
                    ),
                  ),
                ),
                separatorWidget,
                Container(
                  height: 58,
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () => Navigation.toScreen(
                      Routes.addNewTransaction,
                    ),
                    child: Text(
                      'Operation',
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 20,
                        fontFamily: 'SFPro',
                      ),
                    ),
                  ),
                ),
                separatorWidget,
                Container(
                  height: 58,
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () => Navigation.toScreen(
                      Routes.addNewTransaction,
                    ),
                    child: Text(
                      'Account',
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 20,
                        fontFamily: 'SFPro',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              height: 57,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: accentColor,
                  fontSize: 20,
                  fontFamily: 'SFPro',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSize get separatorWidget {
    return PreferredSize(
      preferredSize: const Size.fromHeight(1),
      child: Container(
        color: Colors.black.withOpacity(0.1),
        height: 1,
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: getColor(balance),
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/settings.svg',
          color: whiteColor,
        ),
        onPressed: () => Navigation.toScreen(Routes.settings),
      ),
      leadingWidth: 48,
      title: const Text(
        'Accounts',
        style: TextStyle(fontFamily: Constants.FontSFPro, fontSize: 17),
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => print('Search'),
        ),
        IconButton(
          icon: const Icon(CupertinoIcons.add),
          onPressed: () => showModalBottomSheet<void>(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return bottomSheetWidget;
            },
          ),
        ),
      ],
      elevation: 0.0,
      bottom: const TabBar(
        indicatorColor: whiteColor,
        labelStyle: TextStyle(
            fontSize: 13,
            fontFamily: Constants.FontSFPro,
            color: whiteColorOpacity70,
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
