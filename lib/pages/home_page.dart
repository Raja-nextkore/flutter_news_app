import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/helper/news.dart';
import 'package:flutter_news_app/helper/news_data.dart';
import 'package:flutter_news_app/model/artical_model.dart';
import 'package:flutter_news_app/model/category_model.dart';
import 'package:flutter_news_app/pages/artical_page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'category_news.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> _categories = [];
  List<ArticalModel> articles = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsInstance = News();
    await newsInstance.getNews();
    //print('check 1');
    setState(() {
      articles = newsInstance.news;
      _isLoading = false;
    });

    // print(articles.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: RichText(
          text: TextSpan(
              text: ' Flutter ',
              style: GoogleFonts.rakkas(
                textStyle: const TextStyle(
                    color: Colors.white,
                    letterSpacing: .8,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    backgroundColor: Colors.black),
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'News',
                  style: GoogleFonts.abrilFatface(
                    textStyle: const TextStyle(
                        color: Colors.blue,
                        letterSpacing: .8,
                        backgroundColor: Colors.white),
                  ),
                ),
              ]),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: Container(
              child: const CircularProgressIndicator(),
            ))
          : Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //! category
                  Container(
                    height: 70.0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        return CategoryTile(
                            imageUrl: _categories[index].imageUrl.toString(),
                            categoryName:
                                _categories[index].categoryName.toString());
                      },
                    ),
                  ),
                  //! Blogs
                  Expanded(
                    child: Container(
                      // height: 500.0,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return BlogTile(
                              imageUrl: articles[index].urlToImage,
                              title: articles[index].title,
                              description: articles[index].description,
                              url: articles[index].url,
                            );
                          }),
                    ),
                  ),
                ],
              )),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl;
  final String categoryName;
  const CategoryTile(
      {Key? key, required this.imageUrl, required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryNews(
              categoryNews: categoryName,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          right: 10.0,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: 120.0,
                height: 60.0,
              ),
            ),
            Container(
              height: 60.0,
              width: 120.0,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.399),
                borderRadius: BorderRadius.circular(6.0),
              ),
              alignment: Alignment.center,
              child: Text(
                categoryName,
                style: GoogleFonts.abrilFatface(
                  textStyle:
                      const TextStyle(color: Colors.white, letterSpacing: .5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String url;
  const BlogTile(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticalPage(blogUrl: url),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image.network(
                  imageUrl,
                  scale: 1.0,
                )),
            const SizedBox(
              height: 3.0,
            ),
            Text(
              title,
              style: GoogleFonts.raleway(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              description,
              style: GoogleFonts.raleway(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80.0),
                child: const Divider(
                  height: 5.0,
                  color: Colors.grey,
                  thickness: 3.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
