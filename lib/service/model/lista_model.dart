
class Data {
  String? tvglogo;
  String? grouptitle;
  String? name;
  String? link;

  Data({this.tvglogo, this.name, this.grouptitle, this.link});

  factory Data.fromMap(Map<String, dynamic> map) => Data(
    tvglogo: map["tvglogo"],
    grouptitle: map['grouptitle'],
    name: map['name'],
    link: map['link'],
  );

  Map<String, dynamic> toMap() {
    return {
      "tvglogo": tvglogo,
      "grouptitle": grouptitle,
      "name": name,
      "link": link
    };
  }
}