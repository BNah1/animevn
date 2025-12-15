import 'dart:convert';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:typed_data';


class CacheService{
  static Future<void> cacheUrl(String url, Map<String, dynamic> jsonData) async {
    final cacheManager = DefaultCacheManager();
    final jsonString = jsonEncode(jsonData); // Mã hóa JSON thành chuỗi
    final byteData = utf8.encode(jsonString); // Chuyển đổi chuỗi thành List<int>
    final uint8ListData = Uint8List.fromList(byteData); // Chuyển List<int> thành Uint8List
    await cacheManager.putFile(url, uint8ListData); // Lưu vào cache
  }

  CacheService._();
}