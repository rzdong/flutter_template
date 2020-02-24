
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bot_toast/bot_toast.dart';

import 'common/Global.dart';
import 'common/ThemeModel.dart';
import 'routes/Home.dart';
import 'routes/Login.dart';
import 'routes/Themes.dart';



void main() => {
  WidgetsFlutterBinding.ensureInitialized(),
  Global.init().then((e) =>
    runApp(MyApp())
  )
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeModel()),
      ],
      child: Consumer<ThemeModel>(
        builder: (BuildContext context, themeModel, Widget child) {
          return BotToastInit(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,  //
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: themeModel.theme,
              ),
              home: Home(title: 'Flutter Demo Home Page'),
              navigatorObservers: [BotToastNavigatorObserver()],
              routes: <String, WidgetBuilder>{
                "login": (context) => Login(),
                "themes": (context) => Themes()
              }
            )
          ); 
        }
      ),
    );
  }
}
