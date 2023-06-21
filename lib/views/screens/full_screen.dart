import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:open_file/open_file.dart';

class FullScreen extends StatelessWidget {
  final String imgUrl;

  const FullScreen({Key? key, required this.imgUrl}) : super(key: key);

  Future<void> setWallpaperFromFile(
      String wallpaperUrl, BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    scaffoldMessenger.showSnackBar(
      const SnackBar(content: Text("Downloading Started...")),
    );

    try {
      var imageId = await ImageDownloader.downloadImage(wallpaperUrl);
      if (imageId == null) {
        return;
      }

      var path = await ImageDownloader.findPath(imageId);

      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: const Text("Downloaded Successfully"),
          action: SnackBarAction(
            label: "Open",
            onPressed: () {
              OpenFile.open(path);
            },
          ),
        ),
      );

      debugPrint("IMAGE DOWNLOADED");
    } on PlatformException catch (error) {
      debugPrint(error.message);
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text("Error Occurred - ${error.message}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: ElevatedButton(
          onPressed: () async {
            await setWallpaperFromFile(imgUrl, context);
          },
          child: const Text("Set Wallpaper")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(imgUrl), fit: BoxFit.cover)),
      ),
    );
  }
}
