import 'package:leancloud_storage/leancloud.dart';

Future<void> register({
  String username,
  String password,
  String email,
  String mobile,
  String gender,
}) async {
  final LCUser user = LCUser();

  user
    ..username = username
    ..password = password
    ..email = email
    ..mobile = mobile;
  user['gender'] = gender;

  await user.signUp();
}

Future<void> loginByUsernamePassword(String username, String password) async {
  await LCUser.login(username, password);
}

Future<void> loginByEmailPassword(String email, String password) async {
  await LCUser.loginByEmail(email, password);
}

Future<void> loginByMobilePassword(String mobile, String password) async {
  await LCUser.loginByMobilePhoneNumber(mobile, password);
}

Future<void> requestLoginSMSCode(String mobile) async {
  await LCUser.requestLoginSMSCode(mobile);
}

Future<void> loginByMobileSMSCode(String mobile, String smscode) async {
  await LCUser.signUpOrLoginByMobilePhone(mobile, smscode);
}

Future<void> requestMobileVerify(String mobile) async {
  await LCUser.requestMobilePhoneVerify(mobile);
}

Future<void> verifyMobile(String mobile, String verifyCode) async {
  await LCUser.verifyMobilePhone(mobile, verifyCode);
}

Future<void> requestPasswordResetSMSCode(String mobile) async {
  await LCUser.requestPasswordRestBySmsCode(mobile);
}

Future<void> resetPasswordBySMSCode(
  String mobile,
  String smscode,
  String password,
) async {
  await LCUser.resetPasswordBySmsCode(mobile, smscode, password);
}

Future<LCUser> currentUser() async {
  return await LCUser.getCurrent();
}

void test(String userId) async {
  LCFriendship.request(userId);
  LCQuery<LCObject> query = LCQuery('_FriendshipRequest');
  query.whereEqualTo('status', 'pending');
  List<LCFriendshipRequest> requests = await query.find();
  requests.forEach((request) => LCFriendship.acceptRequest(request));
}
