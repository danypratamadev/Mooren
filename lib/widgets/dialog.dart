import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mooren/const/cfont.dart';

class DialogApp {

  static void showAlertDialog({BuildContext context, Widget title, String message, List<Widget> action, bool dismissible}) {

    var mediaApp = MediaQuery.of(context);
    
    showCupertinoDialog(
      context: context,
      barrierDismissible: dismissible ?? true,
      builder: (_) => MediaQuery(
        data: mediaApp.copyWith(
          textScaleFactor: 1.0,
        ),
        child: CupertinoAlertDialog(
          title: title,
          content: message != null ? Text(
            message,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
              height: 1.4
            ),
          ) : SizedBox(),
          actions: [
            for(int i = 0; i < action.length; i++)
            action[i]
          ],
        ),
      )
    );
  }

  static void showBottomSheetDialog({BuildContext context, String title, String describe, List<Widget> widget, bool dismissible, bool centerTitle}) {

    var mediaApp = MediaQuery.of(context);

    showModalBottomSheet(
      context: context, 
      isDismissible: dismissible ?? true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        )
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) => MediaQuery(
        data: mediaApp.copyWith(
          textScaleFactor: 1.0,
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 16.0, bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  width: 50.0,
                  height: 5.0,
                  color: Theme.of(context).dividerColor,
                ),
              ),
              SizedBox(height: 20.0,),
              Align(
                alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? 'Title',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                        fontFamily: FontType.SFPRO_SEMIBOLD,
                      ),
                      textAlign: centerTitle ? TextAlign.center : TextAlign.left,
                    ),
                    if(describe != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(
                        describe ?? 'Describe',
                        textAlign: centerTitle ? TextAlign.center : TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0,),
              Column(
                children: widget.map((widgets) => widgets).toList(),
              ),
              SizedBox(height: 25.0,),
            ],
          ),
        ),
      ),
    );
  }

}