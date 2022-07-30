import 'package:flutter/material.dart';
import 'package:mooren/provider/mainprovider.dart';
import 'package:provider/provider.dart';
import 'package:mooren/const/ccolor.dart';
import 'package:mooren/models/mmenu.dart';

class MenuItem extends StatelessWidget {

  final MenuModel menu;

  const MenuItem({Key key, this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var mainProvider = Provider.of<MainProvider>(context, listen: false);

    var mediaApp = MediaQuery.of(context);
    var themeApp = Theme.of(context);
    
    return MediaQuery(
      data: mediaApp.copyWith(
        textScaleFactor: 1.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: mediaApp.size.width * 0.14,
            height: mediaApp.size.width * 0.14,
            child: Material(
              borderRadius: BorderRadius.circular(18.0),
              color: menu.color,
              child: InkWell(
                onTap: (){
                  mainProvider.onMenuActionClick(context: context, action: menu.action);
                },
                borderRadius: BorderRadius.circular(18.0),
                child: Icon(
                  menu.icon,
                  color: ColorPalete.WHITE_TEXT_COLOR,
                  size: 38.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            menu.title,
            style: themeApp.textTheme.bodyText1,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

}