import 'package:flutter/material.dart';
import 'package:wallpaper_app/controller/api_operation.dart';
import 'package:wallpaper_app/model/photo_model.dart';
import 'package:wallpaper_app/views/screens/full_screen.dart';
import 'package:wallpaper_app/views/widgets/customapp_bar.dart';
import 'package:wallpaper_app/views/widgets/search_bar.dart';

class SearchScreen extends StatefulWidget {
  final String query;
  const SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<PhotosModel> searchResults;
  bool isLoading = true;
  getSearchResults() async {
    searchResults = await ApiOperations.searchWallpapers(widget.query);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchResults();
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
      body: isLoading ? const Center(child: CircularProgressIndicator(),)  : SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SearchAppBar()),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 400,
                      crossAxisCount: 2,
                      crossAxisSpacing: 13,
                      mainAxisSpacing: 10),
                  itemCount: searchResults.length,
                  itemBuilder: ((context, index) => GridTile(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullScreen(
                                    imgUrl: searchResults[index].imgSrc)));
                      },
                      child: Hero(
                        tag: searchResults[index].imgSrc,
                        child: Container(
                          height: 800,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                                height: 800,
                                width: 50,
                                fit: BoxFit.cover,
                                searchResults[index].imgSrc),
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