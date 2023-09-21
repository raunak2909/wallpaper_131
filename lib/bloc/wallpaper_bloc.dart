import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_app/api/my_exceptions.dart';
import 'package:wallpaper_app/model/data_photo_model.dart';

import '../api/api_helper.dart';
import '../api/urls.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  ApiHelper apiHelper;
  WallpaperBloc({required this.apiHelper}) : super(WallpaperInitialState()) {
    on<GetTrendingWallpaper>((event, emit) async{
      emit(WallpaperLoadingState());

      try{
        var res = await apiHelper.getApi(url: "${Urls.trendingWallpaper}");
        emit(WallpaperLoadedState(wallpaperModel: DataPhotoModel.fromJson(res)));
      } catch(e){
        if(e is FetchDataException){
          emit(WallpaperInternetErrorState(errorMsg: e.ToString()));
        } else {
          emit(WallpaperErrorState(errorMsg: (e as MyException).ToString()));
        }
      }

    });
  }
}
