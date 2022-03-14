import 'package:cash/utils/values/colors.dart';
import 'package:cash/utils/values/constants.dart';
import 'package:cash/utils/values/lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewTransactionScreen extends StatefulWidget {
  const AddNewTransactionScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddNewTransactionScreenState();
}

class _AddNewTransactionScreenState extends State<AddNewTransactionScreen>
    with TickerProviderStateMixin {
  bool value = false;
  var valueList = <String?>[categoryList[0], accountList[0], 'Optional'];
  String? valueTransfer = 'Optional';
  DateTime? _dataTime = DateTime.now();

  Color getColor(bool value) => value == true ? redColor : accentColor;

  String getPrefix(bool value) => value == true ? '-\$0' : '\$0';

  String getTitle(bool value) => value == true ? 'Expense' : 'Income';

  List<String?> getList(bool value) => value == true ? expenseList : incomeList;

  String getDate(DateTime? date) {
    if (date == null) return "Today";
    if (DateFormat.MMMEd().format(date) ==
        DateFormat.MMMEd().format(DateTime.now())) {
      return "Today";
    }
    return DateFormat.MMMEd().format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: appBar(context),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            inputWidget,
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 16),
              padding: EdgeInsets.only(bottom: 7),
              child: Text(
                'Settings',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: Constants.fontSFPro,
                    color: blackColor.withOpacity(0.3)),
              ),
            ),
            separatorWidget,
            categoryWidget,
            separatorWidget,
            dateWidget,
            separatorWidget,
            accountWidget,
            separatorWidget,
            transferWidget,
            separatorWidget,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.topLeft,
              height: 120,
              child: TextFormField(
                maxLines: 4,
                maxLength: 250,
                style: TextStyle(
                    fontFamily: Constants.fontSFPro,
                    fontSize: 15,
                    color: blackColor),
                decoration: InputDecoration(
                  labelText: 'Notes',
                  labelStyle: TextStyle(
                      fontFamily: Constants.fontSFPro,
                      fontSize: 15,
                      color: blackColor.withOpacity(0.7)),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> categoryBuildMenu(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
        ),
      );

  DropdownMenuItem<String> accountBuildMenu(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
        ),
      );

  DropdownMenuItem<String> transferBuildMenu(String item) => DropdownMenuItem(
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

  Widget get inputWidget {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.only(left: 16),
            child: CupertinoSwitch(
              trackColor: redColor,
              activeColor: accentColor,
              value: !value,
              onChanged: (bool value) {
                setState(() {
                  this.value = !value;
                });
              },
            ),
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            height: 80,
            child: TextFormField(
              controller: TextEditingController(text: getPrefix(value)),
              textAlign: TextAlign.end,
              style: TextStyle(
                  color: getColor(value),
                  fontSize: 40,
                  fontFamily: Constants.fontSFPro,
                  fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ),
      ],
    );
  }

  Widget get categoryWidget {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16, bottom: 13, top: 13),
          child: Text(
            'Category',
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
            value: getList(value)[0],
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
                setState(() => getList(value)[0] = newValue),
            items: categoryList.map(categoryBuildMenu).toList(),
          ),
        ),
      ],
    );
  }

  Widget get dateWidget {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16, bottom: 13, top: 13),
          child: Text(
            'Date',
            style: TextStyle(
              fontFamily: Constants.fontSFPro,
              fontSize: 15,
              color: blackColor.withOpacity(0.7),
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.only(
              right: 11,
            ),
            child: TextButton(
              child: Text(
                getDate(_dataTime),
                style: TextStyle(
                  color: accentColor,
                  fontFamily: Constants.fontSFPro,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime.now(),
                ).then((date) => _dataTime = date);
              },
            )),
      ],
    );
  }

  Widget get accountWidget {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16, bottom: 13, top: 13),
          child: Text(
            'Account',
            style: TextStyle(
              fontFamily: Constants.fontSFPro,
              fontSize: 15,
              color: blackColor.withOpacity(0.7),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            right: 11,
          ),
          child: DropdownButton<String>(
            value: valueList[1],
            alignment: Alignment.centerRight,
            style: TextStyle(
              color: accentColor,
              fontFamily: Constants.fontSFPro,
              fontSize: 16,
            ),
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: blackColorOpacity30,
            ),
            underline: Container(),
            onChanged: (newValue) => setState(() => valueList[1] = newValue),
            items: accountList.map(accountBuildMenu).toList(),
          ),
        ),
      ],
    );
  }

  Widget get transferWidget {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16, bottom: 13, top: 13),
          child: Text(
            'Transfer ${(value ? 'to' : 'from')} Account',
            style: TextStyle(
              fontFamily: Constants.fontSFPro,
              fontSize: 15,
              color: blackColor.withOpacity(0.7),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 11),
          child: DropdownButton<String>(
            value: valueTransfer,
            alignment: Alignment.centerRight,
            style: TextStyle(
              color: blackColor.withOpacity(0.1),
              fontFamily: Constants.fontSFPro,
              fontSize: 16,
            ),
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: blackColorOpacity30,
            ),
            underline: Container(),
            onChanged: (newValue) => setState(() => valueTransfer = newValue),
            items: <String>['Optional'].map(transferBuildMenu).toList(),
          ),
        ),
      ],
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
            fontSize: 17,
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        getTitle(value),
        style: TextStyle(
          color: Colors.black,
          fontFamily: Constants.fontSFPro,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            'Done',
            style: TextStyle(
              color: accentColor,
              fontFamily: Constants.fontSFPro,
              fontSize: 17,
            ),
          ),
        ),
      ],
      bottom: separatorWidget,
    );
  }
}
