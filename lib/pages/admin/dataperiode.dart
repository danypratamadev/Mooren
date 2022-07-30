import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mooren/const/ccolor.dart';
import 'package:mooren/provider/mainprovider.dart';
import 'package:mooren/widgets/appbarcollaps.dart';
import 'package:mooren/widgets/dialog.dart';
import 'package:mooren/widgets/empty.dart';
import 'package:mooren/widgets/flexiblebar.dart';
import 'package:mooren/widgets/loading.dart';
import 'package:provider/provider.dart';

class DataPeriodePage extends StatelessWidget {

  final namaController = TextEditingController();
  final startController = TextEditingController();
  final endController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    var mainProvider = Provider.of<MainProvider>(context, listen: false);

    var mediaApp = MediaQuery.of(context);
    var themeApp = Theme.of(context);

    // mainProvider.getRTRW(context: context);

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
                title: 'Data Periode',
              ),
              title: AppBarCollaps(
                child: Text(
                  'Data Periode'
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
                            if(value.listPeriode.length > 0)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Container(
                                color: themeApp.backgroundColor,
                                child: Column(
                                  children: value.listPeriode.map((data) {
                                    i++;
                                    return Column(
                                      children: [
                                        
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
                            else if(value.emptyPeriode)
                            EmptyWidget(
                              heightWidget: mediaApp.size.height * 0.7,
                              img: Icon(
                                Icons.timelapse_rounded,
                                size: 100.0,
                                color: ColorPalete.SHADOW_COLOR,
                              ),
                              describe: 'Data Periode tidak ditemukan.',
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
                                    title: 'Tambah Periode',
                                    describe: 'Buat Periode baru untuk mengelola BLT-DD menjadi lebih mudah.',
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
                                                      controller: namaController,
                                                      readOnly: value.readOnlyPeriode,
                                                      onChanged: (value){
                                                        // mainProvider.setInputValueRTRW(type: 10, value: value);
                                                      },
                                                      decoration: InputDecoration(
                                                        labelText: 'Nama Periode',
                                                        counter: Offstage(),
                                                        border: InputBorder.none,
                                                        filled: true,
                                                        fillColor: Colors.transparent,
                                                      ),
                                                      style: themeApp.textTheme.subtitle1,
                                                      keyboardType: TextInputType.text,
                                                      maxLength: 50,
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
                                                      controller: startController,
                                                      readOnly: value.readOnlyRegister,
                                                      onChanged: (value){
                                                        mainProvider.setInputValueRTRW(type: 20, value: value);
                                                      },
                                                      decoration: InputDecoration(
                                                        labelText: 'Tanggal Mulai',
                                                        counter: Offstage(),
                                                        border: InputBorder.none,
                                                        filled: true,
                                                        fillColor: Colors.transparent,
                                                        suffixIcon: Material(
                                                          color: Colors.transparent,
                                                          child: InkWell(
                                                            borderRadius: BorderRadius.circular(30.0),
                                                            child: Icon(
                                                              Icons.calendar_today_rounded,
                                                              color: ColorPalete.TRITARY_BUTTON_COLOR,
                                                            ), 
                                                            onTap: (){
                                                              
                                                            }
                                                          ),
                                                        )
                                                      ),
                                                      style: themeApp.textTheme.subtitle1,
                                                      keyboardType: TextInputType.datetime,
                                                      maxLength: 20,
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
                                                      controller: endController,
                                                      readOnly: value.readOnlyRegister,
                                                      onChanged: (value){
                                                        mainProvider.setInputValueRTRW(type: 20, value: value);
                                                      },
                                                      decoration: InputDecoration(
                                                        labelText: 'Tanggal Selesai',
                                                        counter: Offstage(),
                                                        border: InputBorder.none,
                                                        filled: true,
                                                        fillColor: Colors.transparent,
                                                        suffixIcon: Material(
                                                          color: Colors.transparent,
                                                          child: InkWell(
                                                            borderRadius: BorderRadius.circular(30.0),
                                                            child: Icon(
                                                              Icons.calendar_today_rounded,
                                                              color: ColorPalete.TRITARY_BUTTON_COLOR,
                                                            ), 
                                                            onTap: (){
                                                              
                                                            }
                                                          ),
                                                        )
                                                      ),
                                                      style: themeApp.textTheme.subtitle1,
                                                      keyboardType: TextInputType.datetime,
                                                      maxLength: 20,
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
                                                onPressed: !value.loadingPeriode && value.buttonActivePeriode ? () async {
                                                  FocusScope.of(context).requestFocus(new FocusNode());
                                                  
                                                } : (){}, 
                                                child: value.loadingPeriode ? CupertinoActivityIndicator() : Text(
                                                  'Simpan',
                                                ),
                                                textColor: !value.loadingPeriode && value.buttonActivePeriode ? ColorPalete.WHITE_TEXT_COLOR : themeApp.disabledColor,
                                                color: !value.loadingPeriode && value.buttonActivePeriode ? themeApp.buttonColor : themeApp.dividerColor,
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
                                  'Tambah Periode Baru',
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