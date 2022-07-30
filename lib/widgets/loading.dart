import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {

  final String captionLoading;
  final double heightLoading;

  const LoadingWidget({Key key, this.heightLoading, this.captionLoading}) : super(key: key);

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
        height: heightLoading ?? mediaApp.size.height * 0.5,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoActivityIndicator(),
              SizedBox(height: 16.0,),
              Text(
                captionLoading ?? 'Loading...',
                style: themeApp.textTheme.caption.copyWith(
                  color: themeApp.disabledColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

}