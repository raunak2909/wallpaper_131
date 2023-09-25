part of 'wallpaper_list_bloc.dart';

@immutable
abstract class WallpaperListEvent {}

class GetSearchWallpaper extends WallpaperListEvent{
  String query;
  String? mColor;
  String pageNo;
  GetSearchWallpaper({required this.query, this.mColor, this.pageNo="1"});
}