import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/api/api_helper.dart';
import 'package:wallpaper_app/bloc/wallpaper_bloc.dart';
import 'package:wallpaper_app/splash_screen.dart';
import 'package:wallpaper_app/wallpaper_page.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => WallpaperBloc(apiHelper: ApiHelper()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wallpaper App',
      theme: ThemeData(primaryColor: Colors.deepPurple),
      home: SplashScreen(),
    );
  }
}
