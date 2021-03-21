import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:firm/constants/index.dart';

class Mine extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final divider = Divider(height: 1, color: Color(AppColors.DividerColor));
    return Scaffold(
        appBar: AppBar(
          title: Text('个人信息'),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '头像',
                        style: TextStyle(
                          color: AppColors.AppTextBColor,
                          fontSize: 18,
                        ),
                      ),
                      Image.asset(
                        'assets/default_avatar.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
              divider,
              buildItem(key: '昵称', value: 'xxxx', isEdit: true),
              divider,
              buildItem(key: '企业组织', value: 'xxxx', isEdit: true),
              divider,
              buildItem(key: '邮箱', value: 'xxxxxxx'),
              divider,
              buildItem(key: '电话', value: 'xxxxxxxxxx'),
              divider,
            ],
          ),
        ));
  }

  Widget buildItem({String key, String value, bool isEdit = false}) {
    final context = useContext();
    final rowItem = Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            key,
            style: TextStyle(color: AppColors.AppTextBColor, fontSize: 18),
          ),
          Text(
            value,
            style: TextStyle(color: AppColors.AppTextGColor, fontSize: 18),
          ),
        ],
      ),
    );
    if (isEdit) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: rowItem,
        onTap: () {
          print('xxxx');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Edit(label: key)),
          );
        },
      );
    }
    return rowItem;
  }
}

class Edit extends HookWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final String label;

  Edit({Key key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: 'xxxx');

    void handleSubmmited() {
      final form = _formKey.currentState;
      if (!form.validate()) {
        _autovalidateMode = AutovalidateMode.always;
      } else {
        print(controller.text);
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: Text(''),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: label,
                    ),
                    controller: controller,
                    onFieldSubmitted: (value) {},
                    maxLength: 11,
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return '输入不能为空';
                      }
                      return null;
                    },
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: handleSubmmited,
                      child: Text('保存'),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
