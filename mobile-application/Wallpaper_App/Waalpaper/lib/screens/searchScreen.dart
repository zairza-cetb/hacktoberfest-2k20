import 'dart:convert';
import 'package:Waalpaper/models/WallpaperModel.dart';
import 'package:Waalpaper/screens/wallpaperDetail.dart';
import 'package:http/http.dart' as http;
import 'package:Waalpaper/constants/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController _searchController = new TextEditingController();
  List singleResponse = [];

  _searchWallpapers({String query = ""}) async {
    singleResponse.clear();
    http.Response response = await http.get(
        'https://api.unsplash.com/search/photos?query=${query}&client_id=${CLIENT_ID}'
    );

    var _parsedResponse = json.decode(response.body)['results'];

    for(var data in _parsedResponse) {
      setState(() {
        singleResponse.add(data);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextFormField(
          controller: _searchController,
          maxLines: 1,
          onFieldSubmitted: (value) {
            _searchWallpapers(query: value);
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search",
            prefixIcon: Icon(Icons.search)
          )
        ),
      ),
      body: Container(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemCount: singleResponse.length,
                itemBuilder: (context, index) {
    return Padding(
    padding: EdgeInsets.only(
    left: index % 2 == 0 ? ScreenUtil().setWidth(8.0) : ScreenUtil().setWidth(2.0),
    right: index % 2 == 0 ? ScreenUtil().setWidth(2.0) : ScreenUtil().setWidth(8.0),
    ),
    child: InkWell(
    onTap: () {
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => WallpaperDetailScreen(snapshot_data: singleResponse[index]))
    );
    },
    child: Container(
    margin: EdgeInsets.all(ScreenUtil().setWidth(4)),
    child: ClipRRect(
    borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
    child: Hero(
    tag: singleResponse[index]['id'].toString(),
    child: Image.network(
    singleResponse[index]['urls']['small'],
    fit: BoxFit.cover,
    ),
    ),
    ),
    ),
    ),
    );
    }
    ),
    ),
    );
  }
}
