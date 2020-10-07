import 'dart:convert' as convert;

import 'package:Waalpaper/screens/searchScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:http/http.dart' as http;

import 'screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  int _selectedDrawerIndex = 0;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waalpaper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryIconTheme: IconThemeData(
          color: Colors.black,
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int index) {
    switch(index) {
      case 0 :
        return new HomeScreen();
      case 1 :
        return new SearchScreen();
      default:
        return new HomeScreen();
    }
  }

  _onSelectItem(int index) {
    setState(() {
      _selectedDrawerIndex = index;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 423.5294196844927, height: 873.7255065343054);
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Center(
            child: Padding(
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(48.0)),
              child: Text("Waalpaper",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          )
      ),
      drawer: Drawer(
        child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: ScreenUtil().setHeight(250),
                  color: Colors.black,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(190),
                      left: ScreenUtil().setWidth(25),
                    ),
                    child: Text("Waalpaper",
                      style: TextStyle(
                          color: Colors.white,
                          backgroundColor: Colors.black,
                          fontSize: ScreenUtil().setSp(40),
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(70)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                  child: InkWell(
                    onTap: () {
                      _onSelectItem(0);
                    },
                    child: Text("Home",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(25),
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(40.0),),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                  child: InkWell(
                    onTap: () {
                      _onSelectItem(1);
                    },
                    child: Text("Search",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(25),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Spacer()
              ],
            )
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
