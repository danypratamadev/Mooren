import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mooren/const/ccolor.dart';
import 'package:mooren/const/cfont.dart';
import 'package:mooren/provider/mainprovider.dart';
import 'package:mooren/widgets/appbarcollaps.dart';
import 'package:mooren/widgets/dialog.dart';
import 'package:mooren/widgets/empty.dart';
import 'package:mooren/widgets/flexiblebar.dart';
import 'package:mooren/widgets/loading.dart';
import 'package:provider/provider.dart';

class BobotParameterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    var mainProvider = Provider.of<MainProvider>(context, listen: false);

    var mediaApp = MediaQuery.of(context);
    var themeApp = Theme.of(context);

    mainProvider.getBobotParameter(context: context);

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
                title: 'Bobot Parameter',
              ),
              title: AppBarCollaps(
                child: Text(
                  'Bobot Parameter'
                )
              ),
              centerTitle: true,
            )
          ], 
          body: Consumer<MainProvider>(
            builder: (context, value, child) {
              int i = -1;
              return RefreshIndicator(
                onRefresh: () => mainProvider.onRefresh(context: context, action: 30),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.only(left: 24.0, right: 24.0),
                    child: Column(
                      children: [
                        if(value.listBobot.length > 0)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Container(
                            color: themeApp.backgroundColor,
                            child: Column(
                              children: value.listBobot.map((data) {
                                i++;
                                return Column(
                                  children: [
                                    Material(
                                      color: Colors.transparent,
                                      child: ListTile(
                                        onTap: (){
                                          DialogApp.showAlertDialog(
                                            context: context,
                                            dismissible: true,
                                            title: Text(
                                              'Bobot Parameter = ${data.bobot}',
                                              style: Theme.of(context).textTheme.headline6.copyWith(
                                                fontFamily: FontType.SFPRO_SEMIBOLD,
                                              )
                                            ),
                                            message: 'Bobot parameter digunakan sebagai bobot penilaian kriteria yang telah ditentukan.',
                                            action: [
                                              CupertinoButton(
                                                child: Text(
                                                  data.aktif ? 'Nonaktifkan' : 'Aktifkan',
                                                  style: Theme.of(context).textTheme.button.copyWith(
                                                    color: data.aktif ? ColorPalete.WARNING_RED : Colors.green,
                                                  )
                                                ), 
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  bool result = await mainProvider.updateBobotParameter(context: context, bobot: data);
                                                  if(result){
                                                    mainProvider.getBobotParameter(context: context);
                                                  }
                                                }
                                              ),
                                              CupertinoButton(
                                                child: Text(
                                                  'Batal',
                                                  style: Theme.of(context).textTheme.button.copyWith(
                                                    color: Theme.of(context).buttonColor
                                                  )
                                                ), 
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                }
                                              ),
                                            ]
                                          );
                                        },
                                        contentPadding: EdgeInsets.only(left: 16.0, right: 10.0),
                                        title: Row(
                                          children: [
                                            Text(
                                              'Bobot parameter = ${data.bobot}'
                                            ),
                                            SizedBox(width: 8.0,),
                                            data.loading ? CupertinoActivityIndicator() : SizedBox()
                                          ],
                                        ),
                                        trailing: Switch(
                                          value: data.aktif, 
                                          onChanged: (value) {  

                                          }
                                        ),
                                      ),
                                    ),
                                    if(i < value.listBobot.length - 1)
                                    Divider(
                                      height: 0.0,
                                      thickness: 0.5,
                                    )
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        )
                        else if(value.emptyBobotParameter)
                        EmptyWidget(
                          heightWidget: mediaApp.size.height * 0.7,
                          img: Icon(
                            Icons.assessment_rounded,
                            size: 100.0,
                            color: ColorPalete.SHADOW_COLOR,
                          ),
                          describe: 'Data Bobot Parameter tidak ditemukan.',
                        )
                        else
                        LoadingWidget(
                          heightLoading: mediaApp.size.height * 0.7,
                          captionLoading: 'LOADING',
                        ),
                        if(value.listBobot.length > 0)
                        SizedBox(height: 16.0,),
                        if(value.listBobot.length > 0)
                        Text(
                          'Klik pada bobot untuk mengaktifkan atau menonaktifkan',
                          style: themeApp.textTheme.bodyText1.copyWith(
                            color: themeApp.disabledColor
                          )
                        ),
                        SizedBox(height: mediaApp.size.height * 0.1,)
                      ],
                    ),
                  ),
                ),
              );
            }
          )
        )
      )
    );
  }

}