import 'package:animevn/database/storage_database.dart';
import 'package:animevn/model/apirespone.dart';
import 'package:animevn/model/apistatus.dart';
import 'package:sqflite/sqflite.dart';

class StorageTable {
  static const TABLE_NAME = 'storage';
  static const CREATE_TABLE_QUERY = '''
    CREATE TABLE $TABLE_NAME (
      slug TEXT PRIMARY KEY,                 
      name TEXT NOT NULL,                    
      origin_name TEXT,                      
      poster_url TEXT,                       
      thumb_url TEXT,                        
      year TEXT,                             
      favourite INTEGER DEFAULT 0,           -- Yêu thích (0: false, 1: true)
      seen INTEGER DEFAULT 0                 -- Đã xem (0: false, 1: true)
    )
  ''';

  Future<int?> insertApiStatus(ApiStatus apiStatus)async{
    final db = await StorageDatabase.instance.database;
    return await db?.insert(TABLE_NAME, {
      'name': apiStatus.api.name,
      'slug': apiStatus.api.slug,
      'origin_name': apiStatus.api.originName,
      'poster_url': apiStatus.api.posterUrl,
      'thumb_url': apiStatus.api.thumbUrl,
      'year': apiStatus.api.year,
      'favourite': apiStatus.favourite ? 1 : 0,
      'seen': apiStatus.seen ? 1 : 0,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateApiFavourite(String slug) async {
    final db = await StorageDatabase.instance.database;
    // Đảo ngược
    final result = await db?.rawUpdate(
      '''
    UPDATE $TABLE_NAME
    SET favourite = CASE WHEN favourite = 1 THEN 0 ELSE 1 END
    WHERE slug = ?
    ''',
      [slug],
    );
  }

  Future<void> updateApiSeen(ApiStatus apiStatus) async {
    final db = await StorageDatabase.instance.database;
    // Đảo ngược
    bool newSeen = !(apiStatus.seen);  // Đảo ngược giá trị seen
    // Cập nhật lại giá trị vào cơ sở dữ liệu
    await db?.update(
      TABLE_NAME,
      {
        'seen': newSeen ? 1 : 0,
      },
      where: 'slug = ?',
      whereArgs: [apiStatus.api.slug],
    );
  }




  Future<void> deleteTodo(String slug) async {
    final db = await StorageDatabase.instance.database;
    await db?.delete(TABLE_NAME, where: 'slug = ?', whereArgs: [slug]);
  }

  Future<List<ApiStatus>> selectAllTodo() async {
    final db = await StorageDatabase.instance.database;
    final List<Map<String, Object?>>? maps = await db?.query(TABLE_NAME);
    return List.generate(maps!.length, (i) {
      // Lấy thông tin từ map và kiểm tra null
      final api = ApiResponse(
        name: maps[i]['name'] as String,
        slug: maps[i]['slug'] as String,
        originName: maps[i]['origin_name'] as String? ?? '',  // Dùng giá trị mặc định nếu null
        posterUrl: maps[i]['poster_url'] as String? ?? '',    // Dùng giá trị mặc định nếu null
        thumbUrl: maps[i]['thumb_url'] as String? ?? '',      // Dùng giá trị mặc định nếu null
        year: maps[i]['year'] as String? ?? '',               // Dùng giá trị mặc định nếu null
      );
      return ApiStatus(
        api: api,
        favourite: (maps[i]['favourite'] as int) == 1,   // Chuyển đổi từ 1/0 thành boolean
        seen: (maps[i]['seen'] as int) == 1,               // Chuyển đổi từ 1/0 thành boolean
      );
    });
  }
}
