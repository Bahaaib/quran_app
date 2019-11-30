import 'package:flutter/material.dart';
import 'package:quran_app/resources/themes.dart';
import 'package:load/load.dart';
import 'package:quran_app/ui/home_page.dart';
import 'package:quran_app/ui/search_page.dart';
import 'package:quran_app/ui/sora_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        //SplashScreen.route: (BuildContext context) => SplashScreen(),
        '/': (BuildContext context) => HomePage(),
        '/search': (BuildContext context) => SearchPage(),
        '/quran': (BuildContext context) => SoraPage(),
      },
      theme: AppThemes.appTheme,
      builder: (BuildContext context, Widget child) {
        return GestureDetector(
            onTap: ()=>FocusScope.of(context).requestFocus(FocusNode()),
            child: LoadingProvider(
              child: Directionality(textDirection:TextDirection.ltr, child: child),
            ));
      },
    );
  }
}
