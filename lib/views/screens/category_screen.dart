import 'package:flutter/material.dart';
import 'package:wallpaper_app/controller/api_operation.dart';
import 'package:wallpaper_app/model/photo_model.dart';
import 'package:wallpaper_app/views/screens/full_screen.dart';
import 'package:wallpaper_app/views/widgets/customapp_bar.dart';

class CategoryScreen extends StatefulWidget {
  final String catName;
  final String catImgUrl;

  const CategoryScreen({super.key, required this.catImgUrl, required this.catName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late List<PhotosModel> categoryResults;
  bool isLoading  = true;
  getCatRelWall() async {
    categoryResults = await ApiOperations.searchWallpapers(widget.catName);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCatRelWall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const CustomAppBar(
          word1: "Wallpaper",
          word2: "Pexel",
        ),
      ),
      body: isLoading  ? const Center(child: CircularProgressIndicator(),)  : SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  widget.catImgUrl,
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black38,
                ),
                Positioned(
                  left: 120,
                  top: 40,
                  child: Column(
                    children: [
                      const Text("Category",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w300)),
                      Text(
                        widget.catName,
                        style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 700,
              child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 400,
                      crossAxisCount: 2,
                      crossAxisSpacing: 13,
                      mainAxisSpacing: 10),
                  itemCount: categoryResults.length,
                  itemBuilder: ((context, index) => GridTile(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullScreen(
                                    imgUrl:
                                    categoryResults[index].imgSrc)));
                      },
                      child: Hero(
                        tag: categoryResults[index].imgSrc,
                        child: Container(
                          height: 800,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              categoryResults[index].imgSrc,
                                height: 800,
                                width: 50,
                                fit: BoxFit.cover,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ))),
            )
          ],
        ),
      ),
    );
  }
}