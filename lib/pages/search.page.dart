import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_application_4/components/news.dart';
import 'package:flutter_application_4/providers/news.provider.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController serachController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProviders>(
        builder: (BuildContext context, news, Widget? child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('cari Berita...'),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: serachController,
                      decoration: const InputDecoration(
                        hintText: 'Cari Berita',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      news.search(serachController.text);
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              news.isDataEmpty
                  ? const SizedBox()
                  : news.isLoadingSearch
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            ...news.resSearch!.articles!.map(
                              (e) => News(
                                title: e.title ?? '',
                                image: e.urlToImage ?? '',
                              ),
                            )
                          ],
                        ),
              // const News(
              //   title: 'testing',
              //   image:
              //       'https://media.cnn.com/api/v1/images/stellar/prod/2010-11-18t120000z-1188946478-mt1imgcnpau43936829-rtrmadp-3-china-chinese-australian-writer-yang-hengjun.jpg?c=16x9&q=w_800,c_fill',
              // )
            ],
          ),
        )),
      );
    });
  }
}
