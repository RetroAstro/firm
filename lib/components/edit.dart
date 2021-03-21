import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Edit extends HookWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final String label;
  final String initialValue;

  Edit({Key key, this.label, this.initialValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialValue);

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