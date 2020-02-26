import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/routes/WebViews.dart';
import 'package:provider/provider.dart';
import 'package:bot_toast/bot_toast.dart';

import 'common/Global.dart';
import 'common/LocaleModel.dart';
import 'common/ThemeModel.dart';
import 'routes/Home.dart';
import 'routes/Login.dart';
import 'routes/Themes.dart';

void main() => {
      WidgetsFlutterBinding.ensureInitialized(),
      Global.init().then((e) => runApp(MyApp()))
    };

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => LocaleModel()),
      ],
      child: Consumer2<ThemeModel, LocaleModel>(
        builder: (BuildContext context, themeModel, localeModel, Widget child) {
          return BotToastInit(
            child: MaterialApp(
              locale: localeModel.getLocale(),
              localizationsDelegates: [
                // 本地化的代理类
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('en', 'US'), // 美国英语
                const Locale('zh', 'CN'), // 中文简体
                //其它Locales
              ],
              localeResolutionCallback:
                  (Locale _locale, Iterable<Locale> supportedLocales) {
                if (localeModel.getLocale() != null) {
                  //如果已经选定语言，则不跟随系统
                  return localeModel.getLocale();
                } else {
                  Locale locale;
                  //APP语言跟随系统语言，如果系统语言不是中文简体或美国英语，
                  //则默认使用美国英语
                  if (supportedLocales.contains(_locale)) {
                    locale = _locale;
                  } else {
                    locale = Locale('en', 'US');
                  }
                  return locale;
                }
              },
              debugShowCheckedModeBanner: false, //
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: themeModel.theme,
              ),
              home: Home(title: 'Flutter Demo Home Page'),
              navigatorObservers: [BotToastNavigatorObserver()],
              routes: <String, WidgetBuilder>{
                "login": (context) => Login(),
                "themes": (context) => Themes(),
                "webview": (context) => WebViews()
              }
            )
          );
        }
      ),
    );
  }
}
