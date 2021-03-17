import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:firm/constants/index.dart';
import 'package:firm/cloud_sdk/index.dart';
import 'package:firm/components/aspect.dart';

typedef BuildMessageWidget = Widget Function(MessageEntity chatitem);

final widgetMap = <int, BuildMessageWidget>{
  1: buildTextItem,
  2: buildImageItem,
  3: buildVoiceItem,
};

Widget buildTextItem(MessageEntity chatitem) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      color: chatitem.isSender ? AppColors.ChatBgColor : Colors.white,
    ),
    child: chatitem.isRichText
        ? buildRichText(chatitem.richTextList)
        : Text(
            chatitem.content,
            style: TextStyle(fontSize: 18, color: AppColors.AppTextBColor),
          ),
  );
}

Widget buildUnknownItem(MessageEntity chatitem) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      color: chatitem.isSender ? AppColors.ChatBgColor : Colors.white,
    ),
    child: Text(
      '[暂未支持该类型消息]',
      style: TextStyle(fontSize: 18, color: AppColors.AppTextBColor),
    ),
  );
}

Widget buildRichText(List<String> list) {
  return Container();
}

Widget buildImageItem(MessageEntity chatitem) {
  if (chatitem.imgUrl == '') {
    return Image.asset(
      'assets/icon/placeholder.png',
      width: 150,
      height: 150,
      fit: BoxFit.cover,
    );
  }
  return AspectImage.file(
    chatitem.imgUrl,
    filebBuilder: (context, snapshot, file) {
      var _imageWidth = snapshot.data.width;
      var _imageHeight = snapshot.data.height;
      var ratio = _imageHeight / _imageWidth;
      var width = _imageWidth < 220 ? _imageWidth : 220;
      var height = width * ratio;
      var img = chatitem.rawImgUrl != '' ? chatitem.rawImgUrl : file;

      return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Scaffold(
                body: Container(
                  color: AppColors.AppBgColor,
                  child: PhotoView(
                    imageProvider: FileImage(File(img)),
                    minScale: PhotoViewComputedScale.covered * 0.5,
                    maxScale: PhotoViewComputedScale.covered * 3.5,
                    loadingBuilder: (context, event) => Center(
                      child: Container(
                        width: 30.0,
                        height: 30.0,
                        child: CircularProgressIndicator(
                          backgroundColor: AppColors.AppBgColor,
                          valueColor: AlwaysStoppedAnimation(Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }));
        },
        child: Container(
          width: width.toDouble(),
          height: height.toDouble(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            image: DecorationImage(
              image: FileImage(File(file)),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    },
  );
}

Widget buildVoiceItem(MessageEntity chatitem) {
  var text = Text(
    '${chatitem.voiceLength}"',
    style: TextStyle(fontSize: 18),
  );
  return GestureDetector(
    onTap: () => {},
    child: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: chatitem.isSender ? AppColors.ChatBgColor : Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(width: 10),
          chatitem.isSender
              ? text
              : SvgPicture.asset(
                  'assets/icon/voice-left.svg',
                  width: 16,
                  height: 16,
                  fit: BoxFit.cover,
                ),
          chatitem.isSender
              ? SvgPicture.asset(
                  'assets/icon/voice-right.svg',
                  width: 16,
                  height: 16,
                  fit: BoxFit.cover,
                )
              : text,
          Container(width: 10),
        ],
      ),
    ),
  );
}
