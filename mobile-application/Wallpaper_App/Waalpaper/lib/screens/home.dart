import 'dart:convert';

import 'package:Waalpaper/constants/keys.dart';
import 'package:Waalpaper/screens/searchScreen.dart';
import 'package:Waalpaper/screens/wallpaperDetail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 423.5294196844927, height: 873.7255065343054);
    return Scaffold(
      body: FutureBuilder(
        future: _fetchWallpapers(),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index % 2 == 0 ? ScreenUtil().setWidth(8.0) : ScreenUtil().setWidth(2.0),
                      right: index % 2 == 0 ? ScreenUtil().setWidth(2.0) : ScreenUtil().setWidth(8.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => WallpaperDetailScreen(snapshot_data: snapshot.data[index]))
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(ScreenUtil().setWidth(4)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
                          child: Hero(
                            tag: snapshot.data[index]['id'].toString(),
                            child: Image.network(
                              snapshot.data[index]['urls']['small'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: CircularProgressIndicator()
              ),
            ],
          );
        }
      )
    );
  }
}

Future _fetchWallpapers() async {
  http.Response response = await http.get(
    'https://api.unsplash.com/photos?client_id=$CLIENT_ID'
  );
  var _parsedResponse = json.decode(response.body);
  return _parsedResponse;
}
