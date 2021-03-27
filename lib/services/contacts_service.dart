part of 'index.dart';

class ContactsService with ChangeNotifier {
  List<ContactsEntity> _contactsList = [];
  List<ContactsEntity> get contactsList => _contactsList;

  fetchContactsList() async {
    _contactsList.clear();

    final List mockDataList = json.decode(
      await rootBundle.loadString('mock/contacts.json'),
    );

    mockDataList.forEach((item) {
      _contactsList.add(
        ContactsEntity(
          avatar: item['profile_image_url'],
          userName: item['screen_name'],
        ),
      );
    });

    _contactsList.forEach((item) {
      String pinyin = PinyinHelper.getPinyinE(item.userName);
      String tag = pinyin.substring(0, 1).toUpperCase();

      if (RegExp('[A-Z]').hasMatch(tag)) {
        item.tagIndex = tag;
      } else {
        item.tagIndex = '#';
      }
    });

    SuspensionUtil.sortListBySuspensionTag(_contactsList);

    notifyListeners();
  }
}
