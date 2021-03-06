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

Future<LCUser> searchUserByUsername(String username) async {
  final res = await LCCloud.rpc(
    'searchUserByUsername',
    params: {'username': username},
  );
  if (res is String && res == 'empty') {
    return null;
  }
  return res;
}

Future<List<LCUser>> searchUserByUserId(List<String> userIds) async {
  return await LCCloud.rpc('searchUserByUserId', params: {'userIds': userIds});
}

Future<void> requestFriendship(
  String userId,
  String remark,
  String group,
) async {
  await LCFriendship.request(userId, attributes: {
    'remark': remark,
    'group': group,
  });
}

Future<List<LCUser>> friendshipRequest() async {
  LCQuery<LCObject> query = LCQuery('_FriendshipRequest');
  List<LCFriendshipRequest> requests =
      await query.whereEqualTo('status', 'pending').find();
  List<String> userIds = requests.map((item) => item.objectId).toList();
  return await searchUserByUserId(userIds);
}

Future<void> acceptFriendshipRequest(String userId) async {
  LCQuery<LCObject> query = LCQuery('_FriendshipRequest');
  query.whereEqualTo('status', 'pending');
  List<LCFriendshipRequest> requests = await query.find();
  requests.forEach((request) {
    if (request.objectId == userId) {
      LCFriendship.acceptRequest(request);
    }
  });
}

Future<void> declineFriendshipRequest(String userId) async {
  LCQuery<LCObject> query = LCQuery('_FriendshipRequest');
  query.whereEqualTo('status', 'pending');
  List<LCFriendshipRequest> requests = await query.find();
  requests.forEach((request) {
    if (request.objectId == userId) {
      LCFriendship.declineRequest(request);
    }
  });
}

Future<List<LCUser>> getFriendList() async {
  LCQuery<LCObject> query = LCQuery('_Followee');
  query
      .whereEqualTo('user', await currentUser())
      .whereEqualTo('friendStatus', true);
  List<LCObject> friends = await query.find();
  List<String> userIds = friends.map((item) => item.objectId).toList();
  return await searchUserByUserId(userIds);
}

Future<void> setFriendProps(String userId, String remark, String group) async {
  LCObject followee = LCObject.createWithoutData('_Followee', userId);
  followee['remark'] = remark;
  followee['group'] = group;
  await followee.save();
}

Future<void> deleteFriend(String userId) async {
  LCUser user = await currentUser();
  await user.unfollow(userId);
}
