import 'dart:io';

import 'package:dms_new_project/Screens/splash/splash_screen.dart';
import 'package:dms_new_project/providers/categories_list_provider.dart';
import 'package:dms_new_project/providers/doc_list_provider.dart';
import 'package:dms_new_project/providers/doc_search_provider.dart';
import 'package:dms_new_project/providers/doc_view_provider.dart';
import 'package:dms_new_project/providers/folers_provider.dart';
import 'package:dms_new_project/providers/user_data_provider.dart';
import 'package:dms_new_project/services/doc_list_service.dart';
import 'package:dms_new_project/utils/app_localization.dart';
import 'package:dms_new_project/utils/local_storage_service/language_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  bool isEng = true;
  Locale? _locale = Locale('en', '');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getLang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserDataProvider()),
        ChangeNotifierProvider(create: (context) => CategoriesListProvider()),
        ChangeNotifierProvider(create: (context) => DocSearchProvider()),
        ChangeNotifierProvider(create: (context) => FoldersProvider()),
        ChangeNotifierProvider(create: (context) => DocListProvider()),
        ChangeNotifierProvider(create: (context)=> DocumentsListService()),
        ChangeNotifierProvider(create: (context) => DocViewProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        supportedLocales: const [
          Locale('en', ''),
          Locale('ar', ''),
          Locale('ur', ''),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: _locale,
        home: SplashScreen(),
      ),
    );
  }

  _getLang() async {
    isEng = await getLanguage();
    _locale = Locale(isEng ? 'en' : 'ar', '');

    setState(() {});
  }
}
