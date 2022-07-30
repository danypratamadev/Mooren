import 'package:flutter/material.dart';
import 'package:mooren/provider/mainprovider.dart';
import 'package:mooren/widgets/appbarcollaps.dart';
import 'package:mooren/widgets/flexiblebar.dart';
import 'package:provider/provider.dart';

class DataBLTDDPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    var mainProvider = Provider.of<MainProvider>(context, listen: false);

    var mediaApp = MediaQuery.of(context);
    var themeApp = Theme.of(context);

    return MediaQuery(
      data: mediaApp.copyWith(
        textScaleFactor: 1.0,
      ),
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
            SliverAppBar(
              primary: true,
              pinned: true,
              forceElevated: innerBoxIsScrolled,
              expandedHeight: 120.0,
              flexibleSpace: FlexibleAppbar(
                title: 'Data Terkini',
              ),
              title: AppBarCollaps(
                child: Text(
                  'Data Terkini'
                )
              ),
              centerTitle: true,
            )
          ], 
          body: Consumer<MainProvider>(
            builder: (context, value, child) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                  ]
                )
              )
            )
          )
        )
      )
    );
  }

}