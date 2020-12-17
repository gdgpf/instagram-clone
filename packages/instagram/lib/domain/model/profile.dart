class Profile {
    Profile({
        this.id,
        this.username,
        this.imageId,
        this.pathCode,
    });

    int id;
    String username;
    int imageId;
    String pathCode;

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
        imageId: json["imageID"] == null ? null : json["imageID"],
        pathCode: json["pathCode"] == null ? null : json["pathCode"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "imageID": imageId == null ? null : imageId,
        "pathCode": pathCode == null ? null : pathCode,
    };
}
