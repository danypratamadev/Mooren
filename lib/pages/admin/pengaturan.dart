import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mooren/const/ccolor.dart';
import 'package:mooren/const/cfont.dart';
import 'package:mooren/const/cvariable.dart';
import 'package:mooren/pages/admin/databobotparam.dart';
import 'package:mooren/pages/admin/dataperiode.dart';
import 'package:mooren/pages/admin/datartrw.dart';
import 'package:mooren/pages/start/login.dart';
import 'package:mooren/provider/mainprovider.dart';
import 'package:mooren/widgets/appbarcollaps.dart';
import 'package:mooren/widgets/dialog.dart';
import 'package:mooren/widgets/flexiblebar.dart';
import 'package:provider/provider.dart';

class PengaturanPage extends StatelessWidget {
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
                title: 'Pengaturan',
              ),
              title: AppBarCollaps(
                child: Text(
                  'Pengaturan'
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
                    Material(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(16.0),
                      child: InkWell(
                        onTap: (){
                          
                        },
                        borderRadius: BorderRadius.circular(16.0),
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0, bottom: 10.0),
                          child: Row(
                            children: [
                              if(value.fotoUser != '-')
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: themeApp.backgroundColor,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: ColorPalete.SHADOW_COLOR2,
                                      blurRadius: 16.0
                                    )
                                  ]
                                ),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: value.fotoUser,
                                    width: 52.0,
                                    height: 52.0,
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder: (context, url, downloadProgress){ 
                                      return Center(
                                        child: CupertinoActivityIndicator()
                                      );
                                    },
                                    errorWidget: (context, url, error){
                                      return Image.asset(
                                        VariabelApp.IMG_AVATAR1
                                      );
                                    }
                                  ),
                                ),
                              )
                              else
                              Container(
                                width: 52.0,
                                height: 52.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorPalete.SHADOW_COLOR2,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      VariabelApp.IMG_AVATAR1,
                                    ),
                                  ),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: ColorPalete.SHADOW_COLOR2,
                                      blurRadius: 16.0
                                    )
                                  ]
                                ),
                              ),
                              SizedBox(width: 16.0,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      value.namaUser,
                                      style: themeApp.textTheme.subtitle1.copyWith(
                                        fontFamily: FontType.SFPRO_BOLD,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 3.0,),
                                    Text(
                                      value.emailUser,
                                      style: themeApp.textTheme.bodyText1,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded
                              )
                            ],
                          ),
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 30.0, bottom: 8.0),
                      child: Text(
                        'MOOREN KONFIGURASI',
                        style: themeApp.textTheme.caption,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        width: double.infinity,
                        color: themeApp.backgroundColor,
                        child: Column(
                          children: [
                            Material(
                              color: themeApp.backgroundColor,
                              child: ListTile(
                                onTap: (){
                                  mainProvider.pushRoute(context: context, child: DataPeriodePage());
                                },
                                leading: Icon(
                                  Icons.timelapse_rounded,
                                  color: Colors.orange,
                                  size: 26.0,
                                ),
                                title: Text(
                                  'Periode',
                                  style: themeApp.textTheme.subtitle1.copyWith(
                                    fontFamily: FontType.SFPRO_MEDIUM,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.chevron_right_rounded,
                                  color: ColorPalete.SECONDARY_ICON_COLOR,
                                ),
                              ),
                            ),
                            Divider(
                              height: 0.0,
                              thickness: 0.5,
                            ),
                            Material(
                              color: themeApp.backgroundColor,
                              child: ListTile(
                                onTap: (){
                                  mainProvider.pushRoute(context: context, child: DataRTRWPage());
                                },
                                leading: Icon(
                                  Icons.home_work_rounded,
                                  color: Colors.blue,
                                  size: 26.0,
                                ),
                                title: Text(
                                  'RT/RW',
                                  style: themeApp.textTheme.subtitle1.copyWith(
                                    fontFamily: FontType.SFPRO_MEDIUM,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.chevron_right_rounded,
                                  color: ColorPalete.SECONDARY_ICON_COLOR,
                                ),
                              ),
                            ),
                            Divider(
                              height: 0.0,
                              thickness: 0.5,
                            ),
                            Material(
                              color: themeApp.backgroundColor,
                              child: ListTile(
                                onTap: (){
                                  mainProvider.pushRoute(context: context, child: BobotParameterPage());
                                },
                                leading: Icon(
                                  Icons.assessment_rounded,
                                  color: Colors.teal,
                                  size: 26.0,
                                ),
                                title: Text(
                                  'Bobot Parameter',
                                  style: themeApp.textTheme.subtitle1.copyWith(
                                    fontFamily: FontType.SFPRO_MEDIUM,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.chevron_right_rounded,
                                  color: ColorPalete.SECONDARY_ICON_COLOR,
                                ),
                              ),
                            ),
                          ]
                        )
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 30.0, bottom: 8.0),
                      child: Text(
                        'TENTANG APLIKASI',
                        style: TextStyle(
                          letterSpacing: 0.3,
                          fontSize: themeApp.textTheme.caption.fontSize,
                          color: themeApp.textTheme.caption.color,
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        width: double.infinity,
                        color: themeApp.backgroundColor,
                        child: Column(
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: ListTile(
                                onTap: (){
                                  mainProvider.showInfoBuildNumber();
                                },
                                leading: Icon(
                                  Icons.android_rounded,
                                  color: themeApp.accentColor,
                                  size: 26.0,
                                ),
                                title: Text(
                                  value.appName,
                                  style: themeApp.textTheme.subtitle1.copyWith(
                                    fontFamily: FontType.SFPRO_MEDIUM,
                                  ),
                                ),
                                trailing: Text(
                                  !value.showBuildNumber ? value.appVersion : value.appBuildNumber,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: themeApp.backgroundColor,
                        child: Material(
                          color: Colors.transparent,
                          child: ListTile(
                            onTap: (){
                              DialogApp.showAlertDialog(
                                context: context,
                                dismissible: true,
                                title: Text(
                                  'Keluar dari Akun',
                                  style: themeApp.textTheme.headline6.copyWith(
                                      fontFamily: FontType.SFPRO_SEMIBOLD,
                                    )
                                ),
                                message: 'Apakah anda yakin ingin keluar dari Mooren?',
                                action: [
                                  CupertinoButton(
                                    child: Text(
                                      'YA',
                                      style: themeApp.textTheme.button.copyWith(
                                        color: ColorPalete.WARNING_RED,
                                        fontFamily: FontType.SFPRO_REGULER,
                                      )
                                    ), 
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      bool result = await mainProvider.logoutAccount();
                                      if(result){
                                        Timer(Duration(milliseconds: 1500), () async {
                                          bool result2 = await mainProvider.setDefaultValue();
                                          if(result2){
                                            mainProvider.pushRemoveUntilRoute(
                                              child: LoginPage(),
                                              context: context,
                                            );
                                          }
                                        });
                                      }
                                    }
                                  ),
                                  CupertinoButton(
                                    child: Text(
                                      'TIDAK',
                                      style: themeApp.textTheme.button.copyWith(
                                        color: themeApp.buttonColor
                                      )
                                    ), 
                                    onPressed: (){
                                      Navigator.pop(context);
                                    }
                                  ),
                                ]
                              );
                            },
                            leading: Icon(
                              Icons.logout,
                              color: Colors.red,
                              size: 26.0,
                            ),
                            title: Text(
                              'Keluar Akun',
                              style: themeApp.textTheme.subtitle1.copyWith(
                                fontFamily: FontType.SFPRO_MEDIUM,
                              ),
                            ),
                            trailing: value.loadingLogout ? CupertinoActivityIndicator() : Icon(
                              Icons.chevron_right_rounded,
                              color: ColorPalete.SECONDARY_ICON_COLOR,
                              size: 24.0,
                            )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaApp.size.height * 0.1,
                    ),
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