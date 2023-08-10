import 'package:flutter/material.dart';
import 'package:flutter_news_api/models/article.dart';
import 'package:flutter_news_api/services/news.dart';
import 'package:flutter_news_api/tiles/blog_tile.dart';
import 'package:flutter_news_api/tiles/category_tile.dart';
import 'package:flutter_news_api/services/data.dart';
import 'package:flutter_news_api/models/category.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category> categories = [];
  late Future<List<Article>> news;
  late TextEditingController _searchBarController;
  //bool _loading = true;

  @override
  void initState() {
    super.initState();
    categories = myCategories;
    _searchBarController = TextEditingController(text: '');
    news = getTopHeadlinesNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('World'),
              Text(
                'News',
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
        ),
        actions: [
          //TODO: Change the News Country DROPBOX
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container();
                  });
            },
            icon: Icon(
              Icons.language,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Categories
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            margin: EdgeInsets.only(top: 8),
            height: 70,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryTile(
                    imageUrl: categories[index].imageUrl,
                    categoryName: categories[index].categoryName,
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey[200],
              ),
              child: TextField(
                onSubmitted: (value) {
                  setState(() {
                    news = getNews(value.toLowerCase());
                  });
                },
                onChanged: (value) {
                  if (value == '') {
                    setState(() {
                      news = getTopHeadlinesNews();
                    });
                  }
                },
                controller: _searchBarController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 10),
                  isDense: true,
                  prefixIcon: Icon(
                    Icons.search,
                    size: 25,
                  ),
                  hintText: 'Search',
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: news,
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
      ),
    );
  }
}
