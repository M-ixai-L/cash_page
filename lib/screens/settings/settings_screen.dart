import 'package:cash/utils/values/colors.dart';
import 'package:cash/utils/values/constants.dart';
import 'package:cash/utils/values/lists.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  bool value = false;
  var valueList = <String?>['USD', 'USD', 'USD'];

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      appBar: appBar(context),
      body: Container(
        color: greyColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                titleWidget('Main'),
                separatorWidget,
                currencyWidget('Currency',
                    currencyList.map(currencyBuildMenu).toList(), 0),
                separatorWidget,
                currencyWidget('Appearance',
                    currencyList.map(currencyBuildMenu).toList(), 1),
                separatorWidget,
                currencyWidget('Additionally',
                    currencyList.map(currencyBuildMenu).toList(), 2),
                separatorWidget,
                titleWidget('Premium'),
                premiumSettings('Icon Set'),
                separatorWidget,
                premiumSettings('Backups'),
                separatorWidget,
                premiumSettings('Export'),
                separatorWidget,
                premiumSettings('Security'),
                separatorWidget,
                subscribeButton,
              ],
            ),
            Container(
              color: greyColor,
              padding: EdgeInsets.only(bottom: 44),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  sendButton,
                  rateButton,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> currencyBuildMenu(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
        ),
      );

  PreferredSize get separatorWidget {
    return PreferredSize(
      preferredSize: const Size.fromHeight(1),
      child: Container(
        color: Colors.black.withOpacity(0.1),
        height: 1,
      ),
    );
  }

  Widget currencyWidget(
      String title, List<DropdownMenuItem<String>>? items, int numItem) {
    return Container(
      color: whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, bottom: 13, top: 13),
            child: Text(
              title,
              style: TextStyle(
                  fontFamily: Constants.fontSFPro,
                  fontSize: 15,
                  color: blackColor.withOpacity(0.7)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              right: 11,
            ),
            child: DropdownButton<String>(
              value: valueList[numItem],
              alignment: Alignment.centerRight,
              style: TextStyle(
                  color: accentColor,
                  fontFamily: Constants.fontSFPro,
                  fontSize: 16),
              icon: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: blackColorOpacity30,
              ),
              underline: Container(),
              onChanged: (newValue) =>
                  setState(() => valueList[numItem] = newValue),
              items: items,
            ),
          ),
        ],
      ),
    );
  }

  Widget titleWidget(String title) {
    return Container(
      color: greyColor,
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(bottom: 8, left: 16),
      height: 50,
      child: Text(
        title,
        style: TextStyle(
            fontSize: 14,
            fontFamily: Constants.fontSFPro,
            color: blackColor.withOpacity(0.3)),
      ),
    );
  }

  Widget premiumSettings(String title) {
    return Container(
      color: whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, bottom: 13, top: 13),
            child: Text(
              title,
              style: TextStyle(
                  fontFamily: Constants.fontSFPro,
                  fontSize: 15,
                  color: blackColor.withOpacity(0.7)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12, bottom: 12, right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: accentColor,
            ),
            alignment: Alignment.center,
            height: 20,
            width: 33,
            child: Text(
              'PRO',
              style: TextStyle(
                fontFamily: Constants.fontSFPro,
                fontSize: 12,
                color: whiteColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget get subscribeButton {
    return Container(
      color: greyColor,
      padding: EdgeInsets.only(top: 24),
      child: TextButton(
          onPressed: () => showSnackBar(context, 'subscribe'),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: accentColor,
            ),
            alignment: Alignment.center,
            height: 50,
            child: Text(
              'Subscribe',
              style: TextStyle(
                fontFamily: Constants.fontSFPro,
                fontSize: 17,
                color: whiteColor,
              ),
            ),
          )),
    );
  }

  Widget get sendButton {
    return Container(
      color: greyColor,
      child: TextButton(
          onPressed: () => showSnackBar(context, 'send'),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: whiteColor,
            ),
            alignment: Alignment.center,
            height: 50,
            child: Text(
              'Send your review',
              style: TextStyle(
                fontFamily: Constants.fontSFPro,
                fontSize: 17,
                color: accentColor,
              ),
            ),
          )),
    );
  }

  Widget get rateButton {
    return Container(
      color: greyColor,
      child: TextButton(
          onPressed: () => showSnackBar(context, 'rate'),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: whiteColor,
            ),
            alignment: Alignment.center,
            height: 50,
            child: Text(
              'Rate in App Store',
              style: TextStyle(
                fontFamily: Constants.fontSFPro,
                fontSize: 17,
                color: accentColor,
              ),
            ),
          )),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leadingWidth: 87,
      elevation: 0,
      leading: TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          'Cancel',
          style: TextStyle(
              color: accentColor,
              fontFamily: Constants.fontSFPro,
              fontSize: 17),
        ),
      ),
      centerTitle: true,
      title: Text(
        'Settings',
        style: TextStyle(
            color: Colors.black,
            fontFamily: Constants.fontSFPro,
            fontSize: 17,
            fontWeight: FontWeight.w500),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            'Save',
            style: TextStyle(
                color: accentColor,
                fontFamily: Constants.fontSFPro,
                fontSize: 17),
          ),
        ),
      ],
      bottom: separatorWidget,
    );
  }
}
