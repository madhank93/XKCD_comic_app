import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttermvpillustrativeapp/data/xkcd_data.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:photo_view/photo_view.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:http/http.dart' as http;

import 'data/xkcd_data_prod.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<XKCD> comicPost;
  static int count;
  static int maxCount = count;
  String imageURL;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    comicPost = ProdXKCDRepo().fetchComicPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("XKCD comic"),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.file_download),
            tooltip: 'Download',
            onPressed: () => imageDownload(),
          ),
          IconButton(
            icon: new Icon(Icons.share),
            tooltip: 'Share',
            onPressed: () => imageShare(),
          ),
        ],
      ),
      body: _comicBody(),
    );
  }

  Widget _comicBody() {
    return Center(
      child: FutureBuilder<XKCD>(
        future: comicPost,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            count = snapshot.data.id;
            imageURL = snapshot.data.imageURL;
            return Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Text(
                  snapshot.data.safeTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: PhotoView(
                    imageProvider: NetworkImage('${snapshot.data.imageURL}'),
                    minScale: PhotoViewComputedScale.contained * 0.8,
                    maxScale: PhotoViewComputedScale.covered * 2,
                    enableRotation: true,
                    backgroundDecoration:
                        BoxDecoration(color: Theme.of(context).canvasColor),
                  ),
                  flex: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        iconSize: 40,
                        icon: Icon(Icons.fast_rewind),
                        onPressed: () => last()),
                    IconButton(
                        iconSize: 40,
                        icon: Icon(Icons.chevron_left),
                        onPressed: () => previous()),
                    IconButton(
                        iconSize: 40,
                        icon: Icon(Icons.chevron_right),
                        onPressed: () => next()),
                    IconButton(
                        iconSize: 40,
                        icon: Icon(Icons.fast_forward),
                        onPressed: () => latest()),
                  ],
                )
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  void imageShare() async {
    var request = await HttpClient().getUrl(Uri.parse(imageURL));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    await Share.file('ESYS AMLOG', 'amlog.jpg', bytes, 'image/jpg');
  }

  void imageDownload() async {
    var response = await http.get(imageURL);
    var filePath =
        await ImagePickerSaver.saveFile(fileData: response.bodyBytes);
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Image downloaded: $filePath"),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void last() {
    print("Count" + count.toString());
    print("maxCount" + maxCount.toString());
    count = 1;
    setState(() {
      comicPost = ProdXKCDRepo().fetchComicPostURL(count);
    });
  }

  void previous() {
    print("Count" + count.toString());
    print("maxCount" + maxCount.toString());
    if (count != 1) {
      count = count - 1;
      setState(() {
        comicPost = ProdXKCDRepo().fetchComicPostURL(count);
      });
    }
  }

  void next() {
    print("Count" + count.toString());
    print("maxCount" + maxCount.toString());
    if (count != maxCount) {
      count = count + 1;
      setState(() {
        comicPost = ProdXKCDRepo().fetchComicPostURL(count);
      });
    }
  }

  void latest() {
    print("Count" + count.toString());
    print("maxCount" + maxCount.toString());
    setState(() {
      comicPost = ProdXKCDRepo().fetchComicPost();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
