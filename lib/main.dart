import 'package:mooren/const/ccolor.dart';
import 'package:mooren/const/cfont.dart';
import 'package:mooren/pages/start/splash.dart';
import 'package:mooren/provider/mainprovider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MainProvider>(
          create: (context) => MainProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Mooren',
        theme: ThemeData(
          fontFamily: FontType.SFPRO_REGULER,
          brightness: Brightness.light,
          scaffoldBackgroundColor: ColorPalete.SCAFFOLD_COLOR,
          backgroundColor: ColorPalete.BACKGROUND_COLOR,
          accentColor: ColorPalete.PRIMARY_COLOR,
          primaryColor: ColorPalete.PRIMARY_COLOR,
          buttonColor: ColorPalete.PRIMARY_BUTTON_COLOR,
          dialogBackgroundColor: ColorPalete.BACKGROUND_COLOR,
          textSelectionHandleColor: ColorPalete.PRIMARY_COLOR,
          cursorColor: ColorPalete.PRIMARY_COLOR,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            elevation: 5.0,
            shadowColor: ColorPalete.SHADOW_COLOR,
            color: ColorPalete.SCAFFOLD_COLOR,
            iconTheme: IconThemeData(
              color: ColorPalete.PRIMARY_ICON_COLOR,
            ),
            textTheme: TextTheme(
              title: TextStyle(
                color: ColorPalete.PRIMARY_TEXT_COLOR,
                fontSize: 18.0,
                fontFamily: FontType.SFPRO_SEMIBOLD,
              )
            )
          ),
          textTheme: TextTheme(
            headline1: TextStyle(
              color: ColorPalete.PRIMARY_TEXT_COLOR,
              letterSpacing: 0.3
            ),
            headline2: TextStyle(
              color: ColorPalete.PRIMARY_TEXT_COLOR,
              letterSpacing: 0.3
            ),
            headline3: TextStyle(
              color: ColorPalete.PRIMARY_TEXT_COLOR,
              letterSpacing: 0.3
            ),
            headline4: TextStyle(
              color: ColorPalete.PRIMARY_TEXT_COLOR,
              letterSpacing: 0.3
            ),
            headline5: TextStyle(
              color: ColorPalete.PRIMARY_TEXT_COLOR,
              letterSpacing: 0.3
            ),
            headline6: TextStyle(
              color: ColorPalete.PRIMARY_TEXT_COLOR,
              letterSpacing: 0.3
            ),
            subtitle1: TextStyle(
              color: ColorPalete.PRIMARY_TEXT_COLOR,
              letterSpacing: 0.3
            ),
            subtitle2: TextStyle(
              color: ColorPalete.PRIMARY_TEXT_COLOR,
              letterSpacing: 0.3
            ),
            bodyText1: TextStyle(
              color: ColorPalete.PRIMARY_TEXT_COLOR,
              letterSpacing: 0.3
            ),
            bodyText2: TextStyle(
              color: ColorPalete.PRIMARY_TEXT_COLOR,
              letterSpacing: 0.3
            ),
            caption: TextStyle(
              color: ColorPalete.SECONDARY_TEXT_COLOR,
              letterSpacing: 0.3
            ),
            overline: TextStyle(
              color: ColorPalete.TRITARY_TEXT_COLOR,
              letterSpacing: 0.3
            ),
            button: TextStyle(
              fontFamily: FontType.SFPRO_SEMIBOLD,
              fontSize: 15.0,
              letterSpacing: 0.3
            ),
          ),
          iconTheme: IconThemeData(
            color: ColorPalete.PRIMARY_ICON_COLOR,
          ),
        ),
        home: SplashPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
