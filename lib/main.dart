import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:score/Bloc/DaysModel.dart';
import 'package:score/Bloc/addFavoriteModel.dart';
import 'package:score/Bloc/addOrRemoveFavouritePublicClub.dart';
import 'package:score/customer/Home.dart';
import 'package:score/customer/Languages.dart';
import 'package:score/publaic/AboutApp.dart';
import 'package:score/publaic/ContactUs.dart';
import 'package:score/publaic/Terms.dart';

import 'Bloc/FavouriteModel.dart';
import 'Bloc/addLeagueFav.dart';
import 'customer/AllCompetations.dart';
import 'customer/League.dart';
import 'customer/MatchDetails.dart';
import 'customer/Search.dart';
import 'publaic/Splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: [Locale('ar', 'EG'), Locale('en', 'US')],
    path: 'assets/langs',
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // TODO: implement createState
    return _myAppState();
  }
}

class _myAppState extends State<MyApp> {
  static final navigatorKey = new GlobalKey<NavigatorState>();

  var _local = Locale('ar', 'EG');

  _setChangeLanguage(local) {
    _local = local;
    EasyLocalization.of(context).locale = _local;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DaysModel()),
        ChangeNotifierProvider(create: (_) => FavouriteModel()),
        ChangeNotifierProvider(create: (_) => AddFavouriteModel()),
        ChangeNotifierProvider(create: (_) => AddOrRemoveFavouritePublicClub()),
        ChangeNotifierProvider(create: (_) => FavLeague()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: '567Score',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          primarySwatch: Colors.green,
          cursorColor: Color(0xffffc107),
          focusColor: Color(0xffffc107),
          accentColor: Color(0xffffc107),
          primaryColor: Color(0xffffc107),
          platform: TargetPlatform.android,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
          }),
        ),
        home: Splash(navigatorKey),
        routes: {
          "/splash": (BuildContext con) => Splash(navigatorKey),
          "/home": (BuildContext con) => Home(
                fun: _setChangeLanguage,
              ),
          "/languages": (BuildContext con) => Languages(_setChangeLanguage),
          "/matchDetails": (BuildContext con) => MatchDetails(),
          "/contactUs": (BuildContext con) => ContactUs(),
          "/terms": (BuildContext con) => Terms(),
          "/aboutApp": (BuildContext con) => AboutApp(),
          "/league": (BuildContext con) => League(),
          "/search": (BuildContext con) => Search(),
          "/allCompetations": (BuildContext con) => AllCompetations(),
        },
      ),
    );
  }
}
