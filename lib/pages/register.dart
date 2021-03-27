import 'package:firm/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:firm/utils/util.dart';

class RegisterInfo {
  String username;
  String password;
  String email;
  String phone;
}

class FocusNodeList<T> {
  T password;
  T retypePassword;
  T email;
  T phone;
}

FocusNodeList<T> useFocusNodeList<T extends FocusNode>() {
  FocusNodeList<T> list = FocusNodeList<T>()
    ..password = useFocusNode()
    ..retypePassword = useFocusNode()
    ..email = useFocusNode()
    ..phone = useFocusNode();
  return list;
}

class RegisterPage extends HookWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final RegisterInfo _registerInfo = RegisterInfo();

  void handleSubmmited() {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidateMode = AutovalidateMode.always;
    } else {
      form.save();
      print(
        '[User JSON]: ${_registerInfo.username} : ${_registerInfo.password} : ${_registerInfo.email} : ${_registerInfo.phone}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24);

    final obscureText = useState(true);
    FocusNodeList<FocusNode> list = useFocusNodeList<FocusNode>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '注册',
          style: TextStyle(color: AppColors.AppTextBColor),
        ),
        backgroundColor: AppColors.AppBgColor,
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
                  hintText: '为自己起一个昵称吧',
                  labelText: '昵称',
                ),
                onSaved: (value) {
                  _registerInfo.username = value;
                  list.password.requestFocus();
                },
                onFieldSubmitted: (_) {},
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return '昵称不能为空';
                  }
                  return null;
                },
              ),
              sizedBoxSpace,
              TextFormField(
                textInputAction: TextInputAction.next,
                key: _passwordFieldKey,
                focusNode: list.password,
                obscureText: obscureText.value,
                maxLength: 8,
                onSaved: (value) {
                  list.retypePassword.requestFocus();
                },
                validator: (_) {},
                onFieldSubmitted: (_) {},
                decoration: InputDecoration(
                  filled: true,
                  hintText: '',
                  labelText: '密码',
                  helperText: '请勿超过8个字符',
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
              TextFormField(
                textInputAction: TextInputAction.next,
                focusNode: list.retypePassword,
                decoration: InputDecoration(filled: true, labelText: '再次输入密码'),
                maxLength: 8,
                obscureText: true,
                validator: (value) {
                  final passwordField = _passwordFieldKey.currentState;
                  if (passwordField.value == null ||
                      passwordField.value.isEmpty) {
                    return '请输入密码';
                  }
                  if (passwordField.value != value) {
                    return '密码不一致';
                  }
                  return null;
                },
                onSaved: (value) {
                  _registerInfo.password = value;
                  list.email.requestFocus();
                },
                onFieldSubmitted: (_) {},
              ),
              sizedBoxSpace,
              TextFormField(
                focusNode: list.email,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  filled: true,
                  labelText: '邮箱',
                ),
                onSaved: (value) {
                  _registerInfo.email = value;
                  list.phone.requestFocus();
                },
                onFieldSubmitted: (_) {},
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return '邮箱不能为空';
                  }
                  if (!isEmail(value)) {
                    return '邮箱格式不正确';
                  }
                  return null;
                },
              ),
              sizedBoxSpace,
              TextFormField(
                textInputAction: TextInputAction.next,
                focusNode: list.phone,
                decoration: InputDecoration(
                  filled: true,
                  labelText: '电话号码',
                  prefixText: '+86 ',
                ),
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  _registerInfo.phone = value;
                  list.phone.unfocus();
                },
                onFieldSubmitted: (_) {},
                maxLength: 11,
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
              sizedBoxSpace,
              Center(
                child: ElevatedButton(
                  onPressed: handleSubmmited,
                  child: Text('确认'),
                ),
              ),
              sizedBoxSpace,
            ],
          ),
        ),
      ),
    );
  }
}
