import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../api/api_helper.dart';
import '../../../api/my_exceptions.dart';
import '../../../api/urls.dart';
import '../../../model/data_photo_model.dart';

part 'wallpaper_list_event.dart';
part 'wallpaper_list_state.dart';

class WallpaperListBloc extends Bloc<WallpaperListEvent, WallpaperListState> {
  ApiHelper apiHelper;
  WallpaperListBloc({required this.apiHelper}) : super(WallpaperListInitialState()) {
    on<GetSearchWallpaper>((event, emit) async{
      emit(WallpaperListLoadingState());

      try{
        print("Url : ${Urls.searchWallpaper}?query=${event.query}&color=${event.mColor??""}&per_page=20&page=${event.pageNo}");
        var res = await apiHelper.getApi(url: "${Urls.searchWallpaper}?query=${event.query}&color=${event.mColor??""}&per_page=20&page=${event.pageNo}");
        emit(WallpaperListLoadedState(wallpaperModel: DataPhotoModel.fromJson(res)));
      } catch(e){
        emit(WallpaperListErrorState(errorMsg: (e as MyException).ToString()));
      }


    });
  }
}
