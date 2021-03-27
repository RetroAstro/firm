import 'package:firm/cloud_sdk/index.dart';
import 'package:firm/components/contacts_item.dart';
import 'package:firm/hooks/useAutomaticKeepAlive.dart';
import 'package:firm/pages/new_friends.dart';
import 'package:firm/pages/user.dart';
import 'package:firm/services/index.dart';
import 'package:flutter/material.dart';
import 'package:azlistview/azlistview.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:firm/constants/index.dart';
import 'package:firm/components/mh_index_bar.dart';

class Contacts extends HookWidget {
  double _itemHeight = 60;
  double _suspensionHeight = 30;

  handleContactsTapped(BuildContext context, ContactsEntity item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => User()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final suspensionTag = useState('');
    useAutomaticKeepAlive();

    useEffect(() {
      contactsService.fetchContactsList();
    }, []);

    final state = Provider.of<ContactsService>(context);

    return Column(
      children: <Widget>[
        Expanded(
          child: AzListView(
            data: state.contactsList,
            itemBuilder: (context, item) => _buildListItem(item),
            isUseRealIndex: true,
            showIndexHint: false,
            itemHeight: _itemHeight.ceil(),
            suspensionHeight: _suspensionHeight.ceil(),
            header: AzListViewHeader(
              height: 60,
              builder: (context) => GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewFriends()),
                  );
                },
                child: _buildListHeader(),
              ),
            ),
            onSusTagChanged: (tag) {
              suspensionTag.value = tag;
            },
            indexBarBuilder: (
              BuildContext context,
              List<String> tagList,
              IndexBarTouchCallback onTouch,
            ) {
              return MHIndexBar(
                data: tagList,
                tag: suspensionTag.value,
                onTouch: onTouch,
              );
            },
          ),
        )
      ],
    );
  }

  Widget _buildListHeader() {
    return SizedBox(
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(width: 10),
          Image.asset(
            'assets/default_avatar.png',
            width: 42,
            height: 42,
            fit: BoxFit.cover,
          ),
          Container(width: 15),
          Text(
            '新的朋友',
            style: TextStyle(color: AppColors.AppTextBColor, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(ContactsEntity item) {
    String susTag = item.getSuspensionTag();
    return Column(
      children: <Widget>[
        Offstage(
          offstage: item.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        ContactsItem(
          contactsitem: item,
          handleTap: handleContactsTapped,
        ),
        Divider(height: 0.5, color: Color(AppColors.DividerColor))
      ],
    );
  }

  Widget _buildSusWidget(String susTag) {
    return Container(
      height: _suspensionHeight,
      padding: EdgeInsets.only(left: 16),
      decoration: BoxDecoration(color: AppColors.AppBgColor),
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        style: TextStyle(fontSize: 14, color: Color(AppColors.SusTagColor)),
      ),
    );
  }
}
