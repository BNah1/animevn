import 'dart:convert';
import 'package:animevn/bloc/storage/storage_event.dart';
import 'package:animevn/bloc/storage/storage_state.dart';
import 'package:animevn/database/storage_table.dart';
import 'package:animevn/model/apirespone.dart';
import 'package:animevn/model/apistatus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/utils.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  StorageBloc() : super(StorageState({})) {
    StorageTable _storageTable = StorageTable();

    // // Xử lý sự kiện LoadDatabase
    // on<LoadDatabase>((event, emit) async {
    //   // Lấy dữ liệu từ SQLite
    //   final itemsFromSQLite = await getApiFromSQLITE();
    //   if (itemsFromSQLite.isNotEmpty) {
    //     // Nếu có dữ liệu từ SQLite, emit state với dữ liệu đó
    //     emit(StorageState(itemsFromSQLite));
    //   } else {
    //     // Nếu không có dữ liệu từ SQLite, lấy dữ liệu từ JSON
    //     final itemsFromStorage = await getApiFromStorage();
    //     emit(StorageState(itemsFromStorage));
    //   }
    // });

    on<LoadDatabase>((event, emit) async {
      final items = await getApiFromSQLITE();
      print(items);
      emit(StorageState(items));
    });
    add(LoadDatabase());

    on<AddToStorage>((event, emit) {
      ApiStatus api = ApiStatus(
          api: ApiResponse(
              name: event.name,
              slug: event.slug,
              originName: event.originName,
              posterUrl: event.posterUrl,
              thumbUrl: event.thumbUrl,
              year: event.year)
      );
      final items = Map<String, ApiStatus>.from(state.items);
      print('add : ${event.slug}, seen: ${event.seen}, favourite: ${event
          .favourite} ');
      if (items.containsKey(event.slug)) {
        print('ton tai roi');
      } else {
        items[event.slug] = api;
        _storageTable.insertApiStatus(api);
      }
      emit(StorageState(items));
    });

    on<FavouriteApiStatus>((event, emit){
      final items = Map<String, ApiStatus>.from(state.items);
      if(items.containsKey(event.slug) && items[event.slug]?.favourite == false){
        ApiStatus api = ApiStatus(
            api: items[event.slug]!.api,
            seen: items[event.slug]!.seen,
            favourite: true);
        items[event.slug] = api;
        _storageTable.updateApiFavourite(api.api.slug);
        showToastMessage(text: 'Đã thêm  ${event.slug} vào yêu thích');
      }

      else if (items.containsKey(event.slug) && items[event.slug]?.favourite == true){

        if(items[event.slug]?.seen == true){
          ApiStatus api = ApiStatus(
              api: items[event.slug]!.api,
              seen: items[event.slug]!.seen,
              favourite: false);
          items[event.slug] = api;
          _storageTable.updateApiFavourite(api.api.slug);
          showToastMessage(text: 'Đã xoá ${event.slug} ra khỏi danh sách');
        }

        else {
          items.remove(event.slug);
          _storageTable.deleteMovieDatabase(event.slug);
          showToastMessage(text: 'Đã xoá ${event.slug} ra khỏi database');
        }
      }

      emit(StorageState(items));
    });

    on<SeenApiStatus>((event, emit){
      final items = Map<String, ApiStatus>.from(state.items);
      if(items.containsKey(event.slug)){
        ApiStatus api = ApiStatus(
            api: items[event.slug]!.api,
            favourite:items[event.slug]!.favourite,
            seen: true
        );
          items[event.slug] = api;
          _storageTable.updateApiSeen(api.api.slug);
      }
      emit(StorageState(items));
    });

    on<RemoveSeen>((event, emit){
      final items = Map<String, ApiStatus>.from(state.items);
      if(items[event.slug]?.favourite == true){
        items[event.slug] = ApiStatus(
            api: items[event.slug]!.api,
            favourite:items[event.slug]!.favourite,
            seen: false
        );
      } else {
        items.remove(event.slug);
        print(event.slug);
        _storageTable.deleteMovieDatabase(event.slug);
      }
      emit(StorageState(items));
    });

  }
}



Future<Map<String,ApiStatus>> getApiFromSQLITE() async{
  StorageTable _storageTable = StorageTable();
  // Load dữ liệu từ SQLite
  final List<ApiStatus> apiStatusList = await _storageTable.selectAllTodo();
  // Chuyển đổi List<ApiStatus> thành Map<String, ApiStatus>
  final Map<String, ApiStatus> items = {};
  for (var apiStatus in apiStatusList) {
    items[apiStatus.api.slug] = apiStatus;
    print(apiStatus.favourite.toString() +"     " + apiStatus.seen.toString() + "     " + apiStatus.api.slug);
  }
  return items;
}


Future<Map<String, ApiStatus>> getApiFromStorage() async {
  try {
    final String response = await rootBundle.loadString('assets/storage.json');
    final List<dynamic> data = json.decode(response);
    final Map<String, ApiStatus> items = {};

    for (var jsonItem in data) {
      ApiStatus apiStatus = ApiStatus.fromJson(jsonItem);
      items[apiStatus.api.slug] = apiStatus;
      print(apiStatus.favourite.toString() +"     " + apiStatus.seen.toString() + "     " + apiStatus.api.slug);
    }
    print(items);
    return items;
  } catch (e) {
    print('Error: $e');
    return {};
  }
}
