class XKCD {
  String id;
  String imageURL;

  XKCD(this.id, this.imageURL);
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
