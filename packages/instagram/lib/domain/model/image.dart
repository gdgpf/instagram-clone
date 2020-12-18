class Image {
  Image({
    this.id,
    this.pathCode,
  });

  int id;
  String pathCode;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        pathCode: json["pathCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pathCode": pathCode,
      };
}
