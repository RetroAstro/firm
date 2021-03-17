import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

typedef AsyncImageWidgetBuilder = Widget Function(
  BuildContext context,
  AsyncSnapshot snapshot,
  String url,
);

typedef AsyncImageFileWidgetBuilder = Widget Function(
  BuildContext context,
  AsyncSnapshot snapshot,
  String file,
);

typedef AsyncImageMemoryWidgetBuilder = Widget Function(
  BuildContext context,
  AsyncSnapshot snapshot,
  Uint8List bytes,
);

enum AspectImageType { NETWORK, FILE, ASSET, MEMORY }

class AspectImage extends StatelessWidget {
  String url;
  String file;
  Uint8List bytes;
  AspectImageType type;
  AsyncImageWidgetBuilder builder;
  AsyncImageFileWidgetBuilder filebBuilder;
  AsyncImageMemoryWidgetBuilder memoryBuilder;

  final ImageProvider provider;

  AspectImage.network(url, {Key key, @required this.builder})
      : provider = NetworkImage(url),
        type = AspectImageType.NETWORK,
        this.url = url;

  AspectImage.file(
    file, {
    Key key,
    @required this.filebBuilder,
  })  : provider = FileImage(File(file)),
        type = AspectImageType.FILE,
        this.file = file;

  AspectImage.asset(name, {Key key, @required this.builder})
      : provider = AssetImage(name),
        type = AspectImageType.ASSET,
        this.url = name;

  AspectImage.memory(bytes, {Key key, @required this.memoryBuilder})
      : provider = MemoryImage(bytes),
        type = AspectImageType.MEMORY,
        this.bytes = bytes;

  @override
  Widget build(BuildContext context) {
    final ImageConfiguration config = createLocalImageConfiguration(context);
    final Completer completer = Completer();
    final ImageStream stream = provider.resolve(config);

    ImageStreamListener listener;
    listener = ImageStreamListener(
      (ImageInfo image, bool sync) {
        completer.complete(image.image);
        stream.removeListener(listener);
      },
      onError: (dynamic exception, StackTrace stackTrace) {
        completer.complete();
        stream.removeListener(listener);
        FlutterError.reportError(FlutterErrorDetails(
          context: ErrorDescription('image failed to precache'),
          library: 'image resource service',
          exception: exception,
          stack: stackTrace,
          silent: true,
        ));
      },
    );
    stream.addListener(listener);

    return FutureBuilder(
      future: completer.future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (type == AspectImageType.FILE) {
            return filebBuilder(context, snapshot, file);
          } else if (type == AspectImageType.MEMORY) {
            return memoryBuilder(context, snapshot, bytes);
          } else {
            return builder(context, snapshot, url);
          }
        } else {
          return Container();
        }
      },
    );
  }
}
