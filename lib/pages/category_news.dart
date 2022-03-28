import 'package:flutter/material.dart';
import 'package:flutter_news_app/model/artical_model.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/news.dart';
import 'artical_page.dart';

class CategoryNews extends StatefulWidget {
  final String categoryNews;
  const CategoryNews({Key? key, required this.categoryNews}) : super(key: key);

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticalModel> articles = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    Category categoryNews = Category();
    await categoryNews.getNews(widget.categoryNews);
    setState(() {
      articles = categoryNews.news;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
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
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : SingleChildScrollView(
            child: Container(
              //height: MediaQuery.of(context).size.height,
              //width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return CategoryBlogTile(
                            imageUrl: articles[index].urlToImage,
                            title: articles[index].title,
                            description: articles[index].description,
                            url: articles[index].url,
                          );
                        }),
                  ],
                ),
              ),
          ),
    );
  }
}

class CategoryBlogTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String url;
  const CategoryBlogTile(
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
       // padding: const EdgeInsets.symmetric(horizontal:10.0,),
        margin: const EdgeInsets.only(bottom: 10.0,top: 10.0,left: 10.0,right: 10.0),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image.network(
                  imageUrl,
                 // scale: 1.0,
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
