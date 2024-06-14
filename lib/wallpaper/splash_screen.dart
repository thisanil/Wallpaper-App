import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:untitled/wallpaper/app_utils.dart';
import 'package:untitled/wallpaper/auth_screen.dart';
import 'package:untitled/wallpaper/wallpaper_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
       next();
       
    });
  }

  next() async {
    var token=await AppUtils().getToken();
    if(token.isEmpty)
      {
          Navigator.pushReplacement(context,MaterialPageRoute(
                            builder: (context) =>const  AuthScreen()));
      }
    else{
      Navigator.pushReplacement(context,MaterialPageRoute(
                            builder: (context) =>const  WallpaperScreen()));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B0019),
      body: Center(
        child: Entry.scale(
            duration: const Duration(milliseconds: 1500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logo.png",
                  height: 200,
                  width: double.maxFinite,
                ),
              ],
            )),
      ),
    );
  }
}
