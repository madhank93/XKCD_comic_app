import 'package:fluttermvpillustrativeapp/data/xkcd_data.dart';

class MockXKCDRepository implements XKCDRepo {
  @override
  Future<List<XKCD>> fetchComicPost() {
    return Future.value(comicPost);
  }
}

var comicPost = <XKCD>[
  XKCD('700', 'https://imgs.xkcd.com/comics/complexion.png', 'Complexion'),
  XKCD('640', 'https://imgs.xkcd.com/comics/tornado_hunter.png', 'Tornado Hunter'),
  XKCD('320', 'https://imgs.xkcd.com/comics/28_hour_day.png', '28-Hour Day'),
  XKCD('500', 'https://imgs.xkcd.com/comics/election.png', 'Election'),
  XKCD('32', 'https://imgs.xkcd.com/comics/pillar.png', 'Pillar')
];