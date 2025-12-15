import 'package:animevn/core/state/base_cubit.dart';
import 'package:animevn/core/state/base_state.dart';
import 'package:animevn/model/apirespone.dart';

enum ListTypeEnum {
  initial,
  loading,
  loaded,
  error,
  empty,
  resetInputs
}

class MovieListState extends BaseState{
  final List<ApiResponse> listApi;
  MovieListState({super.status, super.errorMessage, required this.listApi});


  @override
  BaseState copyWith({BaseStatus? status, String? errorMessage, List<ApiResponse>? listApi}) {
    return MovieListState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      listApi: listApi ?? this.listApi,
    );
  }
}


class MovieListCubit extends BaseCubit<MovieListState>{
  final String url;

  MovieListCubit(this.url)
      : super(MovieListState(listApi: [])){
    // init();
  }

  // Future<void> init()async {
  //   setLoading();
  //   final link =
  //       'https://phimapi.com/phim/$url';
  //   try{
  //     Movie movie = await MovieService.getMovie(link);
  //     final result = state.copyWith(movie: movie);
  //     setLoaded(result);
  //   }catch(e){
  //     setError('Failed to load : ${e.toString()}');
  //   }
  // }

  // on<UploadCurrentPage>((event, emit) async {
  // emit(MovieLoading());
  // String link =
  // 'https://phimapi.com/danh-sach/phim-moi-cap-nhat?page=${event.page}';
  // try {
  // List<ApiResponse> api = await MovieService.fetchApiWithPage(link);
  // emit(ApiLoaded(api));
  // print('da cap nhap');
  // } catch (e) {
  // emit(MovieError('Failed to load : ${e.toString()}'));
  // }
  // });
  //
  // on<LoadApiResponse>((event, emit) async {
  // emit(MovieLoading());
  // try {
  // List<ApiResponse> api = await MovieService.fetchApi(event.url);
  // emit(ApiLoaded(api));
  // } catch (e) {
  // emit(MovieError('Failed to load : ${e.toString()}'));
  // }
  // });
  //
  // on<SearchMovies>((event, emit) async {
  // emit(MovieLoading());
  // try {
  // List<ApiResponse> api = await MovieService.fetchSearch(event.words);
  // emit(ApiLoaded(api));
  // } catch (e) {
  // emit(MovieError('Failed to load : ${e.toString()}'));
  // }
  // });
  //
  // on<LoadApiResponseWithPage>((event, emit) async {
  // emit(MovieLoading());
  // try {
  // List<ApiResponse> api = await MovieService.fetchApiWithPage(event.url);
  // emit(ApiLoaded(api));
  // } catch (e) {
  // emit(MovieError('Failed to load : ${e.toString()}'));
  // }
  // });

}