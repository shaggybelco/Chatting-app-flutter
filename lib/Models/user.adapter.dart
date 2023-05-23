import 'package:hive/hive.dart';
part 'user.adapter.g.dart';

@HiveType(typeId: 1)
class UserDataAdapter {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? cellphone;
  @HiveField(3)
  String? avatar;
  @HiveField(4)
  bool? isAvatar;

  UserDataAdapter({
    this.id,
    this.name,
    this.cellphone,
    this.avatar,
    this.isAvatar,
  });
}
