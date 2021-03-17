import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firm/constants/index.dart';

class InputArea extends StatelessWidget {
  final TextEditingController controller;
  final Function onMessageSended;
  final FocusNode focusNode;

  InputArea({
    Key key,
    this.controller,
    this.onMessageSended,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
          color: AppColors.InputBgColor,
          border: Border(
              top: BorderSide(
                  width: 0.5, color: Color(AppColors.DividerColor)))),
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 15),
              child: SvgPicture.asset(
                'assets/icon/record.svg',
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: RawKeyboardListener(
                focusNode: focusNode,
                onKey: (e) {
                  var isEnterKey = e.runtimeType == RawKeyDownEvent &&
                      e.logicalKey.keyId == 4295426088;
                  if (isEnterKey) {
                    onMessageSended();
                  }
                },
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 4,
                  style:
                      TextStyle(color: AppColors.AppTextBColor, fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8),
                  ),
                  enableInteractiveSelection: false,
                ),
              ),
            ),
          ),
          Container(width: 15),
          Material(
            color: Colors.white,
            child: InkWell(
              onTap: onMessageSended,
              child: Container(
                width: 70,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.ChatButtonColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  '发送',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
