
import '../../db/database.dart';

class Data {
  //int? id;
  String? tvglogo;
  String? grouptitle;
  String? name;
  String? link;

  Data({ this.tvglogo, this.grouptitle, this.name, this.link});

  // converte um Canal em um Map
  Map<String, dynamic> toMap() {
    return {
      DatabaseProvider.columnTvgLogo: tvglogo,
      DatabaseProvider.columnGroupTitle: grouptitle,
      DatabaseProvider.columnName: name,
      DatabaseProvider.columnLink: link,
    };
  }

  // converte um Map em um Canal
  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
     // id: map[DatabaseProvider.columnId],
      tvglogo: map[DatabaseProvider.columnTvgLogo],
      grouptitle: map[DatabaseProvider.columnGroupTitle],
      name: map[DatabaseProvider.columnName],
      link: map[DatabaseProvider.columnLink],
    );
  }
}