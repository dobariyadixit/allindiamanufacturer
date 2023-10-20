import 'package:flutter/cupertino.dart';

class MyImageCache extends ImageCache {
  @override
  void clear() {
    print('Clearing cache!');
    super.clear();
  }
}