import 'package:flutter/material.dart';
import 'package:mooren/const/ccolor.dart';
import 'package:mooren/const/cfont.dart';
import 'package:mooren/const/cvariable.dart';
import 'package:mooren/models/mpetugas.dart';
import 'package:mooren/pages/admin/tambahpegawai.dart';
import 'package:mooren/provider/mainprovider.dart';
import 'package:provider/provider.dart';

class PetugasCard extends StatelessWidget {

  final PetugasModel petugas;

  const PetugasCard({Key key, @required this.petugas}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var mainProvider = Provider.of<MainProvider>(context, listen: false);
    
    var mediaApp = MediaQuery.of(context);
    var themeApp = Theme.of(context);

    return MediaQuery(
      data: mediaApp.copyWith(
        textScaleFactor: 1.0,
      ),
      child: Material(
        child: InkWell(
          onTap: (){
            mainProvider.pushRoute(
              context: context, 
              child: TambahPetugasPage(action: 20,),
            );
          },
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorPalete.SECONDARY_COLOR,
                    image: DecorationImage(
                      image: AssetImage(
                        VariabelApp.IMG_AVATAR3,
                      )
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: ColorPalete.SHADOW_COLOR2,
                        blurRadius: 16.0
                      )
                    ]
                  ),
                ),
                SizedBox(width: 20.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        petugas.nama,
                        style: themeApp.textTheme.subtitle1.copyWith(
                          fontFamily: FontType.SFPRO_SEMIBOLD,
                        ),
                      ),
                    ],
                  )
                ),
                SizedBox(width: 16.0,),
                Icon(
                  Icons.chevron_right_rounded
                )
              ],
            ),
          ),
        ),
      ),
    );

  }

}