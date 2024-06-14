import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart ' as http;
import 'package:untitled/wallpaper/app_utils.dart';
import 'package:untitled/wallpaper/auth_screen.dart';
import 'package:untitled/wallpaper/image_detail.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  @override
  @override
  void initState() {
    fetchAPI();
    super.initState();
  }

  int page = 1;
  List image = [];
  fetchAPI() async {
    String uri = "https://api.pexels.com/v1/curated?per_page=80";
    await http.get(Uri.parse(uri), headers: {
      'Authorization':
          'Iy5zHOGVBzoX5jpZthUwGyrpV2kP6jS9E9hhikP2gdZoQ0Shk9qjrGYp'
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        image = result['photos'];
      });
    });
  }

  loadMore() async {
    setState(() {
      page = page + 1;
    });
    String uri =
        "https://api.pexels.com/v1/curated?per_page=80&page=" + page.toString();
    await http.get(Uri.parse(uri), headers: {
      'Authorization':
          'Iy5zHOGVBzoX5jpZthUwGyrpV2kP6jS9E9hhikP2gdZoQ0Shk9qjrGYp'
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        image.addAll(result['photos']);
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B0019),
      appBar: AppBar(
        backgroundColor: Color(0xFF0B0019),
        title: const Text(
          "Wallpapers",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            onSelected: (value) {
              if (value == 1) {
                AppUtils().setToken("");
                Get.offAll(() =>const AuthScreen());
              }
            },
            iconColor: Colors.white,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Logout",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ],
            offset: const Offset(0, 40),
            color: Colors.yellow,
            elevation: 2,
            // position: PopupMenuPosition.,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: GridView.builder(
                  itemCount: image.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2 / 3),
                  itemBuilder: (context, index) {
                    return InkWell(
                      overlayColor:
                          const MaterialStatePropertyAll(Colors.transparent),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageDetail(
                                      imageUrl: image[index]['src']['original'],
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 236, 235, 225),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            image[index]['src']['tiny'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }),
            )),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
              onTap: loadMore,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.yellow),
                child: const Text(
                  "Load More...",
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
    );
  }
}
