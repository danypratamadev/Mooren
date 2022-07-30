import 'package:flutter/material.dart';
import 'package:mooren/const/ccolor.dart';
import 'package:mooren/const/cfont.dart';
import 'package:mooren/pages/admin/tambahpegawai.dart';
import 'package:mooren/provider/mainprovider.dart';
import 'package:mooren/widgets/appbarcollaps.dart';
import 'package:mooren/widgets/empty.dart';
import 'package:mooren/widgets/flexiblebar.dart';
import 'package:mooren/widgets/loading.dart';
import 'package:mooren/widgets/petugascard.dart';
import 'package:provider/provider.dart';

class DataPetugasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    var mainProvider = Provider.of<MainProvider>(context, listen: false);

    var mediaApp = MediaQuery.of(context);
    var themeApp = Theme.of(context);

    mainProvider.getPetugas(context: context);

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
                title: 'Data Petugas',
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_rounded
                ), 
                onPressed: (){
                  Navigator.pop(context);
                }
              ),
              title: AppBarCollaps(
                child: Text(
                  'Data Petugas'
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
                            if(value.listPetugas.length > 0)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Container(
                                color: themeApp.backgroundColor,
                                child: Column(
                                  children: value.listPetugas.map((petugas) {
                                    i++;
                                    return Column(
                                      children: [
                                        PetugasCard(petugas: petugas),
                                        if(i < value.listPetugas.length - 1)
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
                            else if(value.emptyPetugas)
                            EmptyWidget(
                              heightWidget: mediaApp.size.height * 0.7,
                              img: Icon(
                                Icons.badge,
                                size: 100.0,
                                color: ColorPalete.SHADOW_COLOR,
                              ),
                              describe: 'Data petugas tidak ditemukan.',
                            )
                            else
                            LoadingWidget(
                              heightLoading: mediaApp.size.height * 0.7,
                              captionLoading: 'LOADING',
                            ),
                            SizedBox(height: mediaApp.size.height * 0.2,)
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
                                  mainProvider.pushRoute(
                                    context: context, 
                                    child: TambahPetugasPage(action: 10,),
                                  );
                                }, 
                                icon: Icon(
                                  Icons.add_rounded,
                                ),
                                label: Text(
                                  'Tambah Pegawai',
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