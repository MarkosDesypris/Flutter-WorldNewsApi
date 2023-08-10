import 'package:flutter/material.dart';
import 'package:flutter_news_api/models/article.dart';
import 'package:flutter_news_api/services/news.dart';
import 'package:flutter_news_api/tiles/blog_tile.dart';

class CategoryNews extends StatefulWidget {
  final String categoryName;
  const CategoryNews({
    super.key,
    required this.categoryName,
  });

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  late Future<List<Article>> categoryNews;

  @override
  void initState() {
    super.initState();
    categoryNews = getCategoriesNews(widget.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Flutter'),
              Text(
                'News',
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(
                width: 60,
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: categoryNews,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      final finalNews = snapshot.data;

                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: finalNews.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return BlogTile(
                              imageUrl: finalNews[index].urlToImage ??
                                  'https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png',
                              title: finalNews[index].title ?? '',
                              desc: finalNews[index].description ?? '',
                              url: finalNews[index].url ?? '',
                            );
                          });
                    }
                  }),
            )
          ],
        ));
  }
}
