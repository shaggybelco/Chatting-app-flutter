import 'package:hive/hive.dart';
part 'user.adapter.g.dart';

@HiveType(typeId: 1)
class UserDataAdapter {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? cellphone;  
  @HiveField(3)
  String? avatar;
  @HiveField(4)
  bool? isAvatar;

  UserDataAdapter({
    this.name,
    this.cellphone,
    this.avatar,
    this.isAvatar,
  });
}
