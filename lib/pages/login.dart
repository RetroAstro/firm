import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:firm/utils/util.dart';

class LoginInfo {
  String username;
  String email;
  String phone;
  String password;
}

class LoginPage extends HookWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final LoginInfo _loginInfo = LoginInfo();

  void handleSubmmited() {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidateMode = AutovalidateMode.always;
    } else {
      form.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24);

    final obscureText = useState(true);
    final passwordNode = useFocusNode();

    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: Scrollbar(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: <Widget>[
              sizedBoxSpace,
              Center(
                child: Image.asset(
                  'assets/icon.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              sizedBoxSpace,
              TextFormField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  hintText: '昵称 / 邮箱 / 手机号',
                  labelText: '用户',
                ),
                onSaved: (value) {
                  if (isEmail(value)) {
                    _loginInfo.email = value;
                  } else if (isPhone(value)) {
                    _loginInfo.phone = value;
                  } else {
                    _loginInfo.username = value;
                  }
                  passwordNode.requestFocus();
                },
                onFieldSubmitted: (_) {},
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return '该字段不能为空';
                  }
                  return null;
                },
              ),
              sizedBoxSpace,
              TextFormField(
                textInputAction: TextInputAction.next,
                focusNode: passwordNode,
                obscureText: obscureText.value,
                maxLength: 8,
                onSaved: (value) {
                  _loginInfo.password = value;
                },
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return '密码不能为空';
                  }
                  return null;
                },
                onFieldSubmitted: (_) {},
                decoration: InputDecoration(
                  filled: true,
                  hintText: '请输入密码',
                  labelText: '密码',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      obscureText.value = !obscureText.value;
                    },
                    child: Icon(
                      obscureText.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
              sizedBoxSpace,
              Center(
                child: ElevatedButton(
                  onPressed: handleSubmmited,
                  child: Text('确认'),
                ),
              ),
              sizedBoxSpace,
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PhoneLogin()),
                    );
                  },
                  child: Text('手机号登录'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneLoginInfo {
  String phone;
  String smscode;
}

class PhoneLogin extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final PhoneLoginInfo _phoneLoginInfo = PhoneLoginInfo();

  void handleSubmmited(BuildContext context) {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidateMode = AutovalidateMode.always;
    } else {
      form.save();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => buildVertification()),
        (route) => route == null,
      );
    }
  }

  Widget buildVertification() {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 150),
            child: Center(
              child: Text(
                '请输入验证码',
                style: TextStyle(fontSize: 18.0, color: Colors.blue),
              ),
            ),
          ),
          VerificationCode(
            textStyle: TextStyle(fontSize: 20.0, color: Colors.blue),
            keyboardType: TextInputType.number,
            underlineColor: Colors.blue,
            length: 6,
            onCompleted: (String value) {
              _phoneLoginInfo.smscode = value;
            },
            onEditing: (bool value) {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24);

    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: <Widget>[
            sizedBoxSpace,
            Center(
              child: Image.asset(
                'assets/icon.png',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            sizedBoxSpace,
            TextFormField(
              textInputAction: TextInputAction.next,
              maxLength: 11,
              decoration: InputDecoration(
                filled: true,
                hintText: '请输入电话号码',
                labelText: '电话',
                prefixText: '+86 ',
              ),
              keyboardType: TextInputType.phone,
              onSaved: (value) {
                _phoneLoginInfo.phone = value;
              },
              onFieldSubmitted: (_) {
                handleSubmmited(context);
              },
              validator: (value) {
                if (value.isEmpty || value == null) {
                  return '电话号码不能为空';
                }
                if (!isPhone(value)) {
                  return '电话号码格式不正确';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
