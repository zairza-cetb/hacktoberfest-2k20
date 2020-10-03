import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:url_launcher/url_launcher.dart';


class WallpaperDetailScreen extends StatefulWidget {

  WallpaperDetailScreen({this.snapshot_data});
  final snapshot_data;

  @override
  _WallpaperDetailScreenState createState() => _WallpaperDetailScreenState();
}

class _WallpaperDetailScreenState extends State<WallpaperDetailScreen> {

  Future<void> downloadWallpaper(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('couldnt launch url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: widget.snapshot_data['id'],
                  child: Image.network(
                    widget.snapshot_data['urls']['small'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(16.0), top: ScreenUtil().setHeight(40.0)),
                  child: FloatingActionButton(
                    child: Icon(Icons.arrow_back,
                      color: Colors.black,
                    ),
                    mini: true,
                    backgroundColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(30.0)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.network(
                      widget.snapshot_data['user']['profile_image']['small'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(10),),
                  Text(widget.snapshot_data['user']['name'].toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Spacer(),
                  FlatButton(
                    child: Text("Download"),
                    onPressed: () {
                      downloadWallpaper(widget.snapshot_data['urls']['raw']);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
