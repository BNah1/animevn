import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

void showToastMessage({
  required String text,
}) {
  Fluttertoast.showToast(
    msg: text,
    backgroundColor: Colors.black54,
    fontSize: 18,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
  );
}

void checkToClearCache(DateTime time) {
  Timer.periodic(Duration(minutes: 5), (timer){
    final now = DateTime.now();
    DateTime timeCheck = time.add(Duration(minutes: 10));
    if(now.isAfter(timeCheck)){
      clearCache();
      print('daclear');
    }
  });
}

// giai phong cache
void clearCache() {
  DefaultCacheManager().emptyCache();
}
