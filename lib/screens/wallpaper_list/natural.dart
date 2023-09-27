import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/bloc/wallpaper_bloc.dart';
import 'package:wallpaper_app/model/photo_model.dart';
import 'package:wallpaper_app/screens/wallpaper_detail_page.dart';
import 'package:wallpaper_app/screens/wallpaper_list/bloc/wallpaper_list_bloc.dart';

class WallpaperListPage extends StatefulWidget {
  String mQuery;
  String? mColor;

  WallpaperListPage({required this.mQuery, this.mColor});

  @override
  State<WallpaperListPage> createState() => _WallpaperListPageState();
}

List<PhotoModel> arrPhotos = [];

class _WallpaperListPageState extends State<WallpaperListPage> {

  int mPageNo = 1;
  late ScrollController mController;
  int totalResults = 0;
  bool isFirst = true;

  @override
  void initState() {
    super.initState();
    arrPhotos.clear();

    mController = ScrollController()..addListener(() {
      if(mController.position.pixels==mController.position.maxScrollExtent){
        print("End of List");

        mPageNo++;
        context.read<WallpaperListBloc>().add(GetSearchWallpaper(
            query: widget.mQuery.replaceAll(" ", "%20"), mColor: widget.mColor, pageNo: mPageNo));
      }
    });

    context.read<WallpaperListBloc>().add(GetSearchWallpaper(
        query: widget.mQuery.replaceAll(" ", "%20"), mColor: widget.mColor));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.mQuery),
        ),
        backgroundColor: Colors.black,
        // backgroundColor: Color(0xffD8EBED),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.mQuery,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: BlocListener<WallpaperListBloc, WallpaperListState>(
                listener: (_, state) {

                  if (state is WallpaperListLoadingState) {
                    /*return Center(
                      child: CircularProgressIndicator(),
                    );*/
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mPageNo==1?"Loading": "Loading Next Page")));
                  }

                  else if (state is WallpaperListErrorState) {
                   /* return Center(child: Text(state.errorMsg));*/
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));

                  }


                  else if (state is WallpaperListLoadedState) {
                    totalResults = state.wallpaperModel.total_results!;
                    arrPhotos.addAll(state.wallpaperModel.photos!);
                    setState(() {

                    });

                    /*if (state.wallpaperModel.photos!.isNotEmpty) {
                      arrPhotos.addAll(state.wallpaperModel.photos!);
                      print("arrLength : ${arrPhotos.length}");
                      return Column(
                        children: [
                          Text(
                            '${state.wallpaperModel.total_results} wallpaper available',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // Image of the natural element
                          Expanded(
                            child: GridView.builder(
                              controller: mController,
                              itemCount: arrPhotos.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 11,
                                mainAxisSpacing: 11,
                                childAspectRatio: 9 / 16,
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              WallpaperDetailPage(
                                                  imgUrl: arrPhotos[index]
                                                      .src!
                                                      .portrait!),
                                        ));
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 300,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          arrPhotos[index]
                                              .src!.portrait!,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      );
                    } else {
                      return Center(
                        child: Text('No Wallpaper found!!'),
                      );
                    }*/

                  }


                },
                    child: Column(
                      children: [
                        Text(
                          '$totalResults wallpaper available',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Image of the natural element
                        Expanded(
                          child: GridView.builder(
                            controller: mController,
                            itemCount: arrPhotos.length,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 11,
                              mainAxisSpacing: 11,
                              childAspectRatio: 9 / 16,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            WallpaperDetailPage(
                                                imgUrl: arrPhotos[index]
                                                    .src!
                                                    .portrait!),
                                      ));
                                },
                                child: Container(
                                  width: 150,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        arrPhotos[index]
                                            .src!.portrait!,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
