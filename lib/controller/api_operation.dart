import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/category_model.dart';
import 'package:wallpaper_app/model/photo_model.dart';

import 'dart:math';

class ApiOperations {
  static List<PhotosModel> trendingWallpapers = [];
  static List<PhotosModel> searchWallpapersList = [];
  static List<CategoryModel> categoryModelList = [];

  static const String _apiKey =
      "aJrBRjOQYV9g4RA49BiC4nfb5xybDgfsFsW2CivxMPCgr0ndFA1aDhJP";
  static Future<List<PhotosModel>> getTrendingWallpapers() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated"),
        headers: {"Authorization": _apiKey}).then((value) {
      debugPrint("RESPONSE REPORT");
      debugPrint(value.body);
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      for (var element in photos) {
        trendingWallpapers.add(PhotosModel.fromAPI2App(element));
      }
    });

    return trendingWallpapers;
  }

  static Future<List<PhotosModel>> searchWallpapers(String query) async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
        headers: {"Authorization": _apiKey}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchWallpapersList.clear();
      for (var element in photos) {
        searchWallpapersList.add(PhotosModel.fromAPI2App(element));
      }
    });

    return searchWallpapersList;
  }

  static List<CategoryModel> getCategoriesList() {
    List<String> categoryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];
    List<CategoryModel> categoryModelList = [];

    void processCategory(String catName) async {
      final random = Random();

      List<PhotosModel> wallpapers = await searchWallpapers(catName);
      if (wallpapers.isNotEmpty) {
        PhotosModel photoModel = wallpapers[0 + random.nextInt(11 - 0)];
        debugPrint("IMG SRC IS HERE");
        debugPrint(photoModel.imgSrc);
        categoryModelList.add(
          CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName),
        );
      }
    }

    for (final catName in categoryName) {
      processCategory(catName);
    }

    return categoryModelList;
  }

}