import 'package:app1/Home/Edit/Page.dart';
import 'package:app1/Home/Page.dart';
import 'package:app1/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import 'dart:io' show Directory;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp( //for navigation dont forget to use GetMaterialApp
      title: 'getXpro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        bottomAppBarColor: Colors.grey[200],
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.black87, elevation: 1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
        ),
      ),
      locale:const Locale('vi', 'VN'),
      supportedLocales: const [
        Locale('vi', 'VN'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/Home/Edit': (context) => const HomeEditPage(),
      },
    );
  }
}
