import 'package:instagram/domain/model/image.dart';
import 'package:instagram/domain/model/profile.dart';

class Feed {
  Feed({
    this.id,
    this.profile,
    this.image,
    this.description,
    this.creationDate,
  });

  int id;
  Profile profile;
  Image image;
  String description;
  DateTime creationDate;

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        id: json["id"],
        profile: Profile.fromJson(json["profile"]),
        image: Image.fromJson(json["image"]),
        description: json["description"],
        creationDate: DateTime.parse(json["creationDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "profile": profile.toJson(),
        "image": image.toJson(),
        "description": description,
        "creationDate": creationDate.toIso8601String(),
      };
}
