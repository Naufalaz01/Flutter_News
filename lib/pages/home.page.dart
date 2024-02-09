import 'package:flutter/material.dart';
import 'package:flutter_application_4/components/news.dart';
import 'package:flutter_application_4/pages/search.page.dart';
import 'package:flutter_application_4/providers/news.provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getNews() {
    Provider.of<NewsProviders>(context, listen: false).getTopNews();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProviders>(
        builder: (BuildContext context, news, Widget? child) {
      return RefreshIndicator(
        onRefresh: () async {
          news.setLoading(true);
          return await getNews();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('News Berita'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchPage()),
                      );
                    },
                    icon: const Icon(Icons.search)),
              )
            ],
            backgroundColor: Colors.orange,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  news.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            ...news.resNews!.articles!.map(
                              (e) => News(
                                title: e.title ?? '',
                                image: e.urlToImage ?? '',
                              ),
                            )
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
