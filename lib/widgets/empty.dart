import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {

  final double heightWidget;
  final Widget img;
  final String describe;

  const EmptyWidget({Key key, this.heightWidget, this.img, this.describe}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var mediaApp = MediaQuery.of(context);
    var themeApp = Theme.of(context);

    return MediaQuery(
      data: mediaApp.copyWith(
        textScaleFactor: 1.0,
      ),
      child: Container(
        width: double.infinity,
        height: heightWidget ?? mediaApp.size.height * 0.5,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(img != null)
              img,
              if(describe != null)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  describe,
                  style: themeApp.textTheme.bodyText1.copyWith(
                    color: themeApp.disabledColor
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}