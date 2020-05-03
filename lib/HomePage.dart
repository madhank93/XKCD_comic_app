import 'package:flutter/material.dart';
import 'package:fluttermvpillustrativeapp/data/xkcd_data.dart';
import 'package:http/http.dart';
import 'package:photo_view/photo_view.dart';

import 'data/xkcd_data_prod.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<XKCD> comicPost;
  int maxCount;
  String baseURL = "http://xkcd.com/";

  @override
  void initState() {
    super.initState();
    comicPost = ProdXKCDRepo().fetchComicPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("XKCD comic"),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.file_download),
            tooltip: 'Download',
            onPressed: () {},
          ),
          IconButton(
            icon: new Icon(Icons.share),
            tooltip: 'Share',
            onPressed: () {},
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
            maxCount = snapshot.data.id;
            return Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: PhotoView(
                      imageProvider: NetworkImage('${snapshot.data.imageURL}'),
                    ),
                  ),
                  flex: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.fast_rewind), onPressed: () => last()),
                    IconButton(
                        icon: Icon(Icons.chevron_left),
                        onPressed: () => previous()),
                    IconButton(
                        icon: Icon(Icons.center_focus_strong),
                        onPressed: () => current()),
                    IconButton(
                        icon: Icon(Icons.chevron_right), onPressed: null),
                    IconButton(
                        icon: Icon(Icons.fast_forward),
                        onPressed: () => latest()),
                  ],
                )
              ],
            );
          }
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
    );
  }

  void last() {
    maxCount = 0;
    setState(() {
      comicPost = ProdXKCDRepo().fetchComicPostURL(maxCount);
    });
  }

  void previous() {
    if (maxCount!=0) {
      maxCount = maxCount - 1;
      setState(() {
        comicPost = ProdXKCDRepo().fetchComicPostURL(maxCount);
      });
    }
  }

  void current() {
    setState(() {
      comicPost = ProdXKCDRepo().fetchComicPost();
    });
  }

  void next() {
    maxCount = maxCount + 1;
    setState(() {
      comicPost = ProdXKCDRepo().fetchComicPostURL(maxCount);
    });
  }

  void latest() {
    setState(() {
      comicPost = ProdXKCDRepo().fetchComicPost();
    });
  }
}
