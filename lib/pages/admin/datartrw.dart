import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mooren/const/ccolor.dart';
import 'package:mooren/provider/mainprovider.dart';
import 'package:mooren/widgets/appbarcollaps.dart';
import 'package:mooren/widgets/dialog.dart';
import 'package:mooren/widgets/empty.dart';
import 'package:mooren/widgets/flexiblebar.dart';
import 'package:mooren/widgets/loading.dart';
import 'package:mooren/widgets/rtrwcard.dart';
import 'package:provider/provider.dart';

class DataRTRWPage extends StatelessWidget {

  final rtController = TextEditingController();
  final rwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    var mainProvider = Provider.of<MainProvider>(context, listen: false);

    var mediaApp = MediaQuery.of(context);
    var themeApp = Theme.of(context);

    mainProvider.getRTRW(context: context);

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
                title: 'Data RT/RW',
              ),
              title: AppBarCollaps(
                child: Text(
                  'Data RT/RW'
                )
              ),
              centerTitle: true,
            )
          ], 
          body: Consumer<MainProvider>(
            builder: (context, value, child) {
              int i = -1;
              return Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () => mainProvider.onRefresh(context: context, action: 30),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(value.listRTRW.length > 0)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Container(
                                color: themeApp.backgroundColor,
                                child: Column(
                                  children: value.listRTRW.map((data) {
                                    i++;
                                    return Column(
                                      children: [
                                        RTRWCard(
                                          data: data,
                                          rtController: rtController,
                                          rwController: rwController,
                                        ),
                                        if(i < value.listRTRW.length - 1)
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
                            else if(value.emptyRTRW)
                            EmptyWidget(
                              heightWidget: mediaApp.size.height * 0.7,
                              img: Icon(
                                Icons.home_work_rounded,
                                size: 100.0,
                                color: ColorPalete.SHADOW_COLOR,
                              ),
                              describe: 'Data RT/RW tidak ditemukan.',
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
                                  DialogApp.showBottomSheetDialog(
                                    context: context,
                                    title: 'Tambah RT/RW',
                                    describe: 'Silakan daftarkan RT/RW yang terdapat pada Desa',
                                    centerTitle: false,
                                    dismissible: true,
                                    widget: [
                                      Consumer<MainProvider>(
                                        builder: (context, value, child) => Column(
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: themeApp.backgroundColor,
                                                borderRadius: BorderRadius.circular(16.0),
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                    color: ColorPalete.SHADOW_COLOR2,
                                                    blurRadius: 16.0
                                                  )
                                                ]
                                              ),
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 8.0,),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                                    child: TextFormField(
                                                      controller: rtController,
                                                      readOnly: value.readOnlyRTRW,
                                                      onChanged: (value){
                                                        mainProvider.setInputValueRTRW(type: 10, value: value);
                                                      },
                                                      decoration: InputDecoration(
                                                        labelText: 'RT',
                                                        counter: Offstage(),
                                                        border: InputBorder.none,
                                                        filled: true,
                                                        fillColor: Colors.transparent,
                                                      ),
                                                      style: themeApp.textTheme.subtitle1,
                                                      keyboardType: TextInputType.number,
                                                      maxLength: 3,
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 0.5,
                                                    thickness: 0.5,
                                                  ),
                                                  SizedBox(height: 8.0,),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                                    child: TextFormField(
                                                      controller: rwController,
                                                      readOnly: value.readOnlyRTRW,
                                                      onChanged: (value){
                                                        mainProvider.setInputValueRTRW(type: 20, value: value);
                                                      },
                                                      decoration: InputDecoration(
                                                        labelText: 'RW',
                                                        counter: Offstage(),
                                                        border: InputBorder.none,
                                                        filled: true,
                                                        fillColor: Colors.transparent,
                                                      ),
                                                      style: themeApp.textTheme.subtitle1,
                                                      keyboardType: TextInputType.number,
                                                      maxLength: 3,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 30.0,),
                                            SizedBox(
                                              width: double.infinity,
                                              height: 58.0,
                                              child: FlatButton(
                                                onPressed: !value.loadingRTRW && value.buttonActiveRTRW ? () async {
                                                  FocusScope.of(context).requestFocus(new FocusNode());
                                                  bool result = await mainProvider.checkRTRW(context: context);
                                                  if(!result) {
                                                    var save = await mainProvider.saveRTRW(context: context);
                                                    if(save['status']){
                                                      rtController.clear();
                                                      rwController.clear();
                                                      Navigator.pop(context);
                                                      mainProvider.getRTRW(context: context);
                                                    }
                                                  } else {
                                                    rtController.clear();
                                                    rwController.clear();
                                                  }
                                                } : (){}, 
                                                child: value.loadingRTRW ? CupertinoActivityIndicator() : Text(
                                                  'Simpan',
                                                ),
                                                textColor: !value.loadingRTRW && value.buttonActiveRTRW ? ColorPalete.WHITE_TEXT_COLOR : themeApp.disabledColor,
                                                color: !value.loadingRTRW && value.buttonActiveRTRW ? themeApp.buttonColor : themeApp.dividerColor,
                                                splashColor: Colors.black12,
                                                highlightColor: Colors.black12,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(16.0)
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]
                                  );
                                }, 
                                icon: Icon(
                                  Icons.add_rounded,
                                ),
                                label: Text(
                                  'Tambah RT/RW',
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
              );
            }
          )
        )
      )
    );
  }

}