import 'package:flutter/material.dart';
import 'package:mooren/const/ccolor.dart';
import 'package:mooren/const/cfont.dart';
import 'package:mooren/provider/mainprovider.dart';
import 'package:mooren/widgets/appbarcollaps.dart';
import 'package:mooren/widgets/empty.dart';
import 'package:mooren/widgets/flexiblebar.dart';
import 'package:mooren/widgets/loading.dart';
import 'package:provider/provider.dart';

class DataInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    var mainProvider = Provider.of<MainProvider>(context, listen: false);

    var mediaApp = MediaQuery.of(context);
    var themeApp = Theme.of(context);

    mainProvider.getInfo(context: context);

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
                title: 'Data Informasi',
              ),
              title: AppBarCollaps(
                child: Text(
                  'Data Informasi'
                )
              ),
              centerTitle: true,
            )
          ], 
          body: Consumer<MainProvider>(
            builder: (context, value, child) => Stack(
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(value.listInfo.length > 0)
                        Column(
                          children: value.listInfo.map((info) => Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Material(
                                color: themeApp.backgroundColor,
                                child: Column(
                                  children: [
                                    Text(
                                      info.judul,
                                      style: themeApp.textTheme.subtitle1.copyWith(
                                        fontFamily: FontType.SFPRO_SEMIBOLD,
                                      ),
                                    ),
                                    SizedBox(height: 3.0,),
                                    Text(
                                      info.judul,
                                      style: themeApp.textTheme.bodyText1.copyWith(
                                        height: 1.4,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )).toList(),
                        )
                        else if(value.emptyInformasi)
                        EmptyWidget(
                          heightWidget: mediaApp.size.height * 0.7,
                          img: Icon(
                            Icons.campaign_rounded,
                            size: 100.0,
                            color: ColorPalete.SHADOW_COLOR,
                          ),
                          describe: 'Data Informasi tidak ditemukan.',
                        )
                        else
                        LoadingWidget(
                          heightLoading: mediaApp.size.height * 0.7,
                          captionLoading: 'LOADING',
                        ),
                        SizedBox(height: mediaApp.size.height * 0.1,)
                      ]
                    )
                  )
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    color: themeApp.backgroundColor,
                    child: Column(
                      children: [
                        Divider(
                          height: 0.0,
                          thickness: 0.7,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 16.0, bottom: 24.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 58.0,
                            child: FlatButton.icon(
                              onPressed: (){
                                
                              }, 
                              icon: Icon(
                                Icons.add_rounded,
                              ),
                              label: Text(
                                'Buat Info Baru',
                              ),
                              textColor: ColorPalete.WHITE_TEXT_COLOR,
                              color: themeApp.buttonColor,
                              splashColor: Colors.black12,
                              highlightColor: Colors.black12,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                )
              ],
            )
          )
        )
      )
    );
  }

}