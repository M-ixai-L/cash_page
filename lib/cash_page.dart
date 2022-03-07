import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:cash/custom_icons.dart';
class CashPage extends StatelessWidget {
  const CashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var cash = 23092.20;
    var interest = 28.03;
    //var iconlist = List<int>.filled(5, 0);
    String c = '0xFF11E5E0';
    var IconList = [
      Icons.home_filled,
      CustomIcons.cab,
      CustomIcons.money,
      CustomIcons.food,
      CustomIcons.coffee_cup,
      CustomIcons.food,
      CustomIcons.mobile,
      CustomIcons.mobile,
      CustomIcons.mobile,
    ];
    var TitleList = [
      'Rental revenue',
      'Car',
      'Salary',
      'Food & Restaurants',
      'Coffe',
      'Food & Restaurants',
      'Mobile Account',
      'Mobile Account',
      'Mobile Account',
    ];
    var ValuesList = [
      1500,-193.02, 7500, 37, 2, 5, 19.99, -5454, 64
    ];
    dynamic GetSign( dynamic valeue){
      if (valeue >= 0 ) {
        return valeue;
      }
      else{return valeue*-1;}
    }
    String GetSignString( dynamic valeue){
      if (valeue >= 0 ) {
        return '';
      }
      else{return '-';}
    }
    int GetColor( dynamic value){
      if (value >= 0) {return 0xFF11E5E0;}
      else{return 0xFFF8226D;}
    }
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF11E5E0),
          leading: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_outlined,
                ),
                // padding: EdgeInsets.all(12.0),

                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Go to home')));
                },
              ),
              Text(
                'Accounts',
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
          title: const Text('Cash'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Search')));
              },
            ),
            IconButton(
              icon: const Icon(CupertinoIcons.add),
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('New')));
              },
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: 'DAILY',
              ),
              Tab(
                text: 'WEELY',
              ),
              Tab(
                text: 'MONTHLY',
              ),
              Tab(
                text: 'YEARLY',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Container(
                color: Color(0xFF11E5E0),
                child: Column(

                  children: <Widget>[
                    Container(
                      color: Color(0xFF11E5E0),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(bottom: 50),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 30, bottom: 10),
                            child: Text(
                              'BALANCE',
                              style:
                              TextStyle(fontSize: 13, color: Color(0xFFDEDEDE)),
                            ),
                          ),
                          Container(
                            child: Text(
                              '\$ $cash',
                              style: TextStyle(fontSize: 30, color: Colors.white),
                            ),
                            padding: EdgeInsets.only(bottom: 5),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 30),
                            child: Text(
                              '+ $interest %',
                              style: TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                          Flexible(

                            child: ListView.builder(

                              itemCount:TitleList.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return
                                  Container(
                                    margin: EdgeInsets.only(left: 7, right: 7),
                                    color: Colors.white,
                                    // decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
                                    child: ListTile(
                                      leading: Icon(
                                        IconList[index], color: Color(0xFF11E5E0),),
                                      title: Text(TitleList[index]),
                                      trailing: Text(
                                        '${GetSignString(ValuesList[index])}\$ ${GetSign(
                                            ValuesList[index])}', style: TextStyle(
                                          color: Color(GetColor(ValuesList[index])),
                                          fontSize: 20),),

                                    ),
                                  );
                              },),
                          ),
                        ],

                      ),
                    ),

                  ],
                ),
              ),
            ),
            Container(
              child: Center(
                child: Text('WEKENDLY'),
              ),
            ),
            Container(
              child: Center(
                child: Text('MONTHLY'),
              ),
            ),
            Container(
              child: Center(
                child: Text('YEARLY'),
              ),
            ),
          ],
        ),
      ),
    );

  }

}
