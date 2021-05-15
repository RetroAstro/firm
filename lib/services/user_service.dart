part of 'index.dart';

class UserService {
  Map<String, String> _avatarMap = {};
  Map<String, String> get avatarMap => _avatarMap;

  UserEntity _userInfo = UserEntity(
    avatar: 'default',
    userName: 'Alice',
    nickName: '王五',
    company: 'xxx',
    email: 'xxxx',
    phone: '12313',
  );

  UserEntity get userInfo => _userInfo;
}
