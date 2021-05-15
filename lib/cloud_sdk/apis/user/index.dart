import 'entity.dart';

class UserAPI {
  Future<UserEntity> fetchUserInfo() async {
    return UserEntity(
      avatar: 'default',
      userName: 'Alice',
      nickName: '王五',
      company: 'xxx',
      email: 'xxxx',
      phone: '12313',
    );
  }
}
