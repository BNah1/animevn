import 'dart:convert';
import 'package:animevn/bloc/storage/storage_event.dart';
import 'package:animevn/bloc/storage/storage_state.dart';
import 'package:animevn/model/apirespone.dart';
import 'package:animevn/model/apistatus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/utils.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  StorageBloc() : super(StorageState({})) {
    on<LoadJson>((event, emit) async {
      final items = await getApiFromStorage();
      emit(StorageState(items));
    });
    add(LoadJson());

    on<AddToStorage>((event, emit) {
      final items = Map<String, ApiStatus>.from(state.items);
      print('add : ${event.slug}, seen: ${event.seen}, favourite: ${event
          .favourite} ');
      if (items.containsKey(event.slug)) {
        print('ton tai roi');
      } else {
        items[event.slug] = ApiStatus(
            api: ApiResponse(
            name: event.name,
            slug: event.slug,
            originName: event.originName,
            posterUrl: event.posterUrl,
            thumbUrl: event.thumbUrl,
            year: event.year),
        );
      }
      emit(StorageState(items));
    });

    on<FavouriteApiStatus>((event, emit){
      final items = Map<String, ApiStatus>.from(state.items);
      if(items.containsKey(event.slug) && items[event.slug]?.favourite == false){
          items[event.slug] = ApiStatus(
              api: items[event.slug]!.api,
              seen:items[event.slug]!.seen,
              favourite: true
          );
          showToastMessage(text: 'Đã thêm  ${event.slug} vào yêu thích');
      } else if (items.containsKey(event.slug) && items[event.slug]?.favourite == true){
        if(items[event.slug]?.seen == true){
          items[event.slug] = ApiStatus(
              api: items[event.slug]!.api,
              seen:items[event.slug]!.seen,
              favourite: false
          );
        } else {
          items.remove(event.slug);
          showToastMessage(text: 'Đã xoá ${event.slug} ra khỏi danh sách');
        }
      }
      emit(StorageState(items));
    });

    on<SeenApiStatus>((event, emit){
      final items = Map<String, ApiStatus>.from(state.items);
      if(items.containsKey(event.slug)){
          items[event.slug] = ApiStatus(
              api: items[event.slug]!.api,
              favourite:items[event.slug]!.favourite,
              seen: true
          );
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
      }
      emit(StorageState(items));
    });

  }
}

Future<Map<String, ApiStatus>> getApiFromStorage() async {
  try {
    final String response = await rootBundle.loadString('assets/storage.json');
    final List<dynamic> data = json.decode(response);
    final Map<String, ApiStatus> items = {};

    for (var jsonItem in data) {
      ApiStatus apiStatus = ApiStatus.fromJson(jsonItem);
      items[apiStatus.api.slug] = apiStatus;
    }
    print('thanh cong');
    print(items);
    return items;
  } catch (e) {
    print('Error: $e');
    return {};
  }
}
