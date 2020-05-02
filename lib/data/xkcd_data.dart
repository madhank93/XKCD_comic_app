class XKCD {
  String id;
  String imageURL;
  String safeTitle;

  XKCD(this.id, this.imageURL, this.safeTitle);

  XKCD.fromMap(Map<String, dynamic> map): id=map['num'], imageURL=map['img'], safeTitle=map['safe_title'];

}

abstract class XKCDRepo {
  Future<List<XKCD>> fetchComicPost();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
