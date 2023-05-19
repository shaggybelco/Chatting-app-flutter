class UserModel {
  String? name;
  String? cellphone;
  bool? isAvatar;
  String? avatar;
  UserModel({
    this.name,
    this.cellphone,
    this.isAvatar,
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"] ?? "",
      cellphone: json["cellphone"] ?? "",
      isAvatar: json["isAvatar"] ?? "",
      avatar: json["avatar"] ?? "",
    );
  }
}
