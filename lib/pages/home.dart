import 'package:firm/constants/index.dart';
import 'package:firm/pages/add_friends.dart';
import 'package:firm/pages/contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:firm/pages/conversation.dart';
import 'package:firm/pages/mine.dart';

class Home extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final titleList = ['会话', '通讯录', '我'];
    final bodyList = [Conversation(), Contacts(), Mine()];

    final selectedIndex = useState(0);
    final pageController = usePageController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.AppBgColor,
        leading: Text(''),
        title: Text(
          titleList[selectedIndex.value],
          style: TextStyle(color: AppColors.AppTextBColor),
        ),
        actions: <Widget>[
          selectedIndex.value == 2
              ? Container()
              : PopupMenuButton(
                  icon:
                      Icon(Icons.add, size: 32, color: AppColors.AppTextBColor),
                  color: AppColors.AppPopMenuColor,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text(
                          '发起群聊',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      PopupMenuItem(
                        child: Text(
                          '添加朋友',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        value: 'add_friends',
                      ),
                    ];
                  },
                  onSelected: (route) {
                    if (route == 'add_friends') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddFriends(),
                        ),
                      );
                    }
                  },
                ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        backgroundColor: AppColors.AppBgColor,
        currentIndex: selectedIndex.value,
        onTap: (index) {
          selectedIndex.value = index;
          pageController.jumpToPage(index);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/conversation.png',
              fit: BoxFit.cover,
              width: 25,
              height: 25,
            ),
            activeIcon: Image.asset(
              'assets/conversation_active.png',
              fit: BoxFit.cover,
              width: 25,
              height: 25,
            ),
            label: '会话',
          ),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/contacts.png',
                fit: BoxFit.cover,
                width: 33,
                height: 33,
              ),
              activeIcon: Image.asset(
                'assets/contacts_active.png',
                fit: BoxFit.cover,
                width: 33,
                height: 33,
              ),
              label: '通讯录'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/mine.png',
                fit: BoxFit.cover,
                width: 25,
                height: 25,
              ),
              activeIcon: Image.asset(
                'assets/mine_active.png',
                fit: BoxFit.cover,
                width: 25,
                height: 25,
              ),
              label: '我'),
        ],
      ),
      body: PageView.builder(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return bodyList[index];
        },
      ),
    );
  }
}
