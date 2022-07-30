import 'package:flutter/material.dart';
import 'package:mooren/const/cfont.dart';

class FlexibleAppbar extends StatelessWidget {

  final String title;
  final Widget trailing;

  const FlexibleAppbar({Key key, @required this.title, this.trailing}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var mediaApp = MediaQuery.of(context);
    var themeApp = Theme.of(context);

    return MediaQuery(
      data: mediaApp.copyWith(
        textScaleFactor: 1.0,
      ),
      child: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Stack(
          children: [
            Positioned(
              bottom: 16.0,
              left: 25.0,
              right: 25.0,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: themeApp.textTheme.headline4.copyWith(
                        fontFamily: FontType.SFPRO_BOLD,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 16.0,),
                  trailing ?? SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}