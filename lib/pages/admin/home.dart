import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mooren/const/ccolor.dart';
import 'package:mooren/const/cfont.dart';
import 'package:mooren/const/cvariable.dart';
import 'package:mooren/pages/admin/pengaturan.dart';
import 'package:mooren/provider/mainprovider.dart';
import 'package:mooren/widgets/appbarcollaps.dart';
import 'package:mooren/widgets/flexiblebar.dart';
import 'package:mooren/widgets/menu.dart';
import 'package:provider/provider.dart';

class HomeAdminPage extends StatelessWidget {
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
                title: 'Mooren',
                trailing: GestureDetector(
                  onTap: (){
                    mainProvider.pushRoute(context: context, child: PengaturanPage());
                  },
                  child: Container(
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
                ),
              ),
              title: AppBarCollaps(
                child: Text(
                  'Mooren'
                )
              ),
              centerTitle: true,
            )
          ], 
          body: Consumer<MainProvider>(
            builder: (context, value, child) => RefreshIndicator(
              onRefresh: () => mainProvider.onRefresh(context: context, action: 10),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Material(
                          color: themeApp.backgroundColor,
                          child: InkWell(
                            onTap: (){},
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Overview',
                                          style: themeApp.textTheme.subtitle1.copyWith(
                                            fontFamily: FontType.SFPRO_SEMIBOLD,
                                          ),
                                        ),
                                        SizedBox(height: 3.0,),
                                        Text(
                                          'Data BLT-DD Periode Oktober 2021'
                                        ),
                                        SizedBox(height: 16.0,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '124',
                                              style: themeApp.textTheme.headline4.copyWith(
                                                fontFamily: FontType.SFPRO_BOLD_ROUNDED,
                                              ),
                                            ),
                                            SizedBox(width: 8.0),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 5.0),
                                              child: Text(
                                                'Data'
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right_rounded,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0,),
                      Text(
                        'Menu',
                        style: themeApp.textTheme.subtitle1.copyWith(
                          fontFamily: FontType.SFPRO_SEMIBOLD,
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: value.listMenu.map((menu){
                          return MenuItem(menu: menu,);
                        }).toList(),
                      ),
                      SizedBox(height: 30.0,),
                      Text(
                        'Informasi',
                        style: themeApp.textTheme.subtitle1.copyWith(
                          fontFamily: FontType.SFPRO_SEMIBOLD,
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
          )
        ),
      )
    );
    
  }

}