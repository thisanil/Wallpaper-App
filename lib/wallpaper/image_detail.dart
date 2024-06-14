import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get/get.dart';
import 'package:widget_zoom/widget_zoom.dart';

class ImageDetail extends StatefulWidget {
  final String imageUrl;
  const ImageDetail({super.key, required this.imageUrl});

  @override
  State<ImageDetail> createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  @override
  Future<void> setWallpaer() async {
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);
    bool result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0019),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 236, 235, 225),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: WidgetZoom(
                    zoomWidget: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    heroAnimationTag: "tag",
                  ),
                ),
              )),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                overlayColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                onTap: () {
                  showBottomSheet();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.yellow),
                  child: const Text(
                    "Set Wallpaper",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 0,
              )
            ],
          ),
        ),
      ),
    );
  }

  showBottomSheet() {
    Get.bottomSheet(
      Container(
         margin:const EdgeInsets.all(10),
        height: 150,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: const Color(0xFF0B0019),
          borderRadius: BorderRadius.circular(20)

        ),
       child: Column(
   crossAxisAlignment: CrossAxisAlignment.center,
   children: [
     const SizedBox(
       height: 15,
     ),
     InkWell(
       overlayColor:
           const MaterialStatePropertyAll(Colors.transparent),
       onTap: () async {
         int location = WallpaperManager.HOME_SCREEN;
         var file = await DefaultCacheManager()
             .getSingleFile(widget.imageUrl);
         bool result = await WallpaperManager.setWallpaperFromFile(
             file.path, location);
       },
       child: const Text(
         "Home Screen",
         style: TextStyle(
             fontSize: 20,
             fontWeight: FontWeight.w600,
             color: Colors.white),
       ),
     ),
     const SizedBox(
       height: 15,
     ),
     InkWell(
       overlayColor:
           const MaterialStatePropertyAll(Colors.transparent),
       onTap: () async {
         int location = WallpaperManager.LOCK_SCREEN;
         var file = await DefaultCacheManager()
             .getSingleFile(widget.imageUrl);
         bool result = await WallpaperManager.setWallpaperFromFile(
             file.path, location);
       },
       child: const Text(
         "Lock Screen",
         style: TextStyle(
             fontSize: 20,
             fontWeight: FontWeight.w600,
             color: Colors.white),
       ),
     ),
     const SizedBox(
       height: 15,
     ),
     InkWell(
       overlayColor:
           const MaterialStatePropertyAll(Colors.transparent),
       onTap: () async {
         int location = WallpaperManager.BOTH_SCREEN;
         var file = await DefaultCacheManager()
             .getSingleFile(widget.imageUrl);
         bool result = await WallpaperManager.setWallpaperFromFile(
             file.path, location);
       },
       child: const Text(
         "Both",
         style: TextStyle(
             fontSize: 20,
             fontWeight: FontWeight.w600,
             color: Colors.white),
       ),
     )
   ],
 ),
    ));
  }
}
