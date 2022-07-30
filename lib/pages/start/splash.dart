import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mooren/const/ccolor.dart';
import 'package:mooren/const/cfont.dart';
import 'package:mooren/const/cvariable.dart';
import 'package:mooren/pages/admin/home.dart';
import 'package:mooren/pages/start/login.dart';
import 'package:mooren/provider/mainprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var mainProvider = Provider.of<MainProvider>(context, listen: false);

    var mediaApp = MediaQuery.of(context);
    var themeApp = Theme.of(context);

    mainProvider.getAppInfo();

    Timer(Duration(milliseconds: 1500), () async {
      var auth = await mainProvider.getCurrentUser();
      if(auth){
        mainProvider.pushReplaceRoute(
          context: context,
          child: HomeAdminPage(),
        );
      } else {
        mainProvider.pushReplaceRoute(
          context: context,
          child: LoginPage(),
        );
      }
    });

    return MediaQuery(
      data: mediaApp.copyWith(
        textScaleFactor: 1.0,
      ),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: mediaApp.size.height,
          child: Stack(
            children: [
              Center(
                child: Stack(
                  children: [
                    Image.asset(
                      VariabelApp.IMG_LOGO,
                      width: mediaApp.size.width * 0.35,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.transparent,
                      highlightColor: Colors.white10,
                      direction: ShimmerDirection.rtl,
                      child: Image.asset(
                        VariabelApp.IMG_LOGO,
                        width: mediaApp.size.width * 0.35,
                      ),
                    ),
                  ],
                ),
              ),
              Consumer<MainProvider>(
                builder: (context, value, child) => Positioned(
                  bottom: 30.0,
                  left: 25.0,
                  right: 25.0,
                  child: Center(
                    child: Wrap(
                      children: [
                        Text(
                          'Versi',
                          style: themeApp.textTheme.bodyText1.copyWith(
                            color: themeApp.textTheme.caption.color,
                            fontFamily: FontType.SFPRO_REGULER_ROUNDED
                          ),
                        ),
                        SizedBox(width: 3.0,),
                        Text(
                          value.appVersion ?? '',
                          style: themeApp.textTheme.bodyText1.copyWith(
                            color: themeApp.textTheme.caption.color,
                            fontFamily: FontType.SFPRO_REGULER_ROUNDED
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}