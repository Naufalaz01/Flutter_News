import 'package:flutter/material.dart';
import 'package:flutter_application_4/pages/home.page.dart';
import 'package:flutter_application_4/providers/news.provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NewsProviders())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TEMPO',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
