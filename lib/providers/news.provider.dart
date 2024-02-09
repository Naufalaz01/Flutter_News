import 'package:flutter/material.dart';
import 'package:flutter_application_4/helpers/api.dart';
import 'package:flutter_application_4/models/topNews.model.dart';
import 'package:flutter_application_4/utils/const.dart';

class NewsProviders with ChangeNotifier {
  bool isDataEmpty = true;
  bool isLoading = true;
  bool isLoadingSearch = true;
  TopNewsModel? resNews;
  TopNewsModel? resSearch;

  setLoading(data) {
    isLoading = data;
    notifyListeners();
  }

  getTopNews() async {
    final res = await api('${baseUrl}top-headlines?country=us&apiKey=$apiKey');

    if (res.statusCode == 200) {
      resNews = TopNewsModel.fromJson(res.data);
    } else {
      resNews = TopNewsModel();
    }
    isLoading = false;
    notifyListeners();
  }

  search(String search) async {
    isDataEmpty = false;
    isLoadingSearch = true;
    notifyListeners();

    final res = await api(
        '${baseUrl}everything?q=${search}&sortby=popularity&apiKey=$apiKey');

    if (res.statusCode == 200) {
      resSearch = TopNewsModel.fromJson(res.data);
    } else {
      resSearch = TopNewsModel();
    }
    isLoadingSearch = false;
    notifyListeners();
  }
}
