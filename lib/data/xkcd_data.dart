class XKCD {
  final int id;
  final String imageURL;
  final String safeTitle;

  XKCD({this.id, this.imageURL, this.safeTitle});

  factory XKCD.fromJson(Map<String, dynamic> json){
    return XKCD(
    id: json['num'],
    imageURL:json['img'],
    safeTitle:json['safe_title'],
    );
  }
}
