import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mooren/const/ccolor.dart';
import 'package:mooren/const/cfont.dart';
import 'package:mooren/const/cvariable.dart';
import 'package:mooren/pages/admin/home.dart';
import 'package:mooren/provider/mainprovider.dart';
import 'package:mooren/widgets/dialog.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {

  final namadesaController = TextEditingController();
  final kodewilayahController = TextEditingController();
  final alamatController = TextEditingController();

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmController = TextEditingController();

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
              title: Text(
                'Mooren'
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.help_outline_rounded,
                    color: ColorPalete.SECONDARY_BUTTON_COLOR,
                  ), 
                  onPressed: (){
                    
                  }
                ),
              ],
            )
          ], 
          body: Consumer<MainProvider>(
            builder: (context, value, child) => GestureDetector(
              onTap: (){
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Container(
                width: double.infinity,
                height: mediaApp.size.height,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16.0,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: mediaApp.size.width * 0.2,
                                  height: mediaApp.size.width * 0.2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(mediaApp.size.width * 0.06),
                                    color: ColorPalete.WARNING_RED,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        VariabelApp.IMG_AVATAR1,
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
                                SizedBox(width: 8.0,),
                                Container(
                                  width: mediaApp.size.width * 0.18,
                                  height: mediaApp.size.width * 0.18,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(mediaApp.size.width * 0.05),
                                    color: themeApp.accentColor,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        VariabelApp.IMG_AVATAR2,
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
                                SizedBox(width: 8.0,),
                                Container(
                                  width: mediaApp.size.width * 0.16,
                                  height: mediaApp.size.width * 0.16,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(mediaApp.size.width * 0.045),
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
                              ],
                            ),
                            SizedBox(height: 24.0,),
                            Text(
                              'Daftar Akun',
                              style: themeApp.textTheme.headline5.copyWith(
                                fontFamily: FontType.SFPRO_BOLD,
                              )
                            ),
                            Text(
                              'Silakan mendaftar menggunakan Email dan melengkapi Data Desa yang dibutuhkan.',
                              style: themeApp.textTheme.subtitle1.copyWith(
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: 40.0,),
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
                                      controller: namadesaController,
                                      readOnly: value.readOnlyRegister,
                                      onChanged: (value){
                                        mainProvider.setInputValueRegister(
                                          type: 10,
                                          value: value
                                        );
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Nama Desa',
                                        counter: Offstage(),
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.transparent,
                                      ),
                                      style: themeApp.textTheme.subtitle1,
                                      keyboardType: TextInputType.emailAddress,
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
                                      controller: kodewilayahController,
                                      readOnly: value.readOnlyRegister,
                                      onChanged: (value){
                                        mainProvider.setInputValueRegister(
                                          type: 20,
                                          value: value,
                                        );
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Kode Wilayah',
                                        counter: Offstage(),
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.transparent,
                                      ),
                                      style: themeApp.textTheme.subtitle1,
                                      keyboardType: TextInputType.text,
                                      maxLength: 30,
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
                                      controller: alamatController,
                                      readOnly: value.readOnlyRegister,
                                      onChanged: (value){
                                        mainProvider.setInputValueRegister(
                                          type: 30,
                                          value: value,
                                        );
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Alamat',
                                        counter: Offstage(),
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.transparent,
                                      ),
                                      style: themeApp.textTheme.subtitle1,
                                      keyboardType: TextInputType.text,
                                      maxLength: 100,
                                      maxLines: null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40.0,),
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
                                      controller: emailController,
                                      readOnly: value.readOnlyRegister,
                                      onChanged: (value){
                                        mainProvider.setInputValueRegister(
                                          type: 40,
                                          value: value
                                        );
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        counter: Offstage(),
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.transparent,
                                      ),
                                      style: themeApp.textTheme.subtitle1,
                                      keyboardType: TextInputType.emailAddress,
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
                                      controller: passController,
                                      obscureText: value.obscureTextRegister,
                                      readOnly: value.readOnlyRegister,
                                      onChanged: (value){
                                        mainProvider.setInputValueRegister(
                                          type: 50,
                                          value: value
                                        );
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        counter: Offstage(),
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.transparent,
                                      ),
                                      style: themeApp.textTheme.subtitle1,
                                      keyboardType: TextInputType.text,
                                      maxLength: 30,
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
                                      controller: confirmController,
                                      obscureText: value.obscureTextRegister,
                                      readOnly: value.readOnlyRegister,
                                      onChanged: (value){
                                        mainProvider.setInputValueRegister(
                                          type: 60,
                                          value: value
                                        );
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Konfirmasi Password',
                                        counter: Offstage(),
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.transparent,
                                      ),
                                      style: themeApp.textTheme.subtitle1,
                                      keyboardType: TextInputType.text,
                                      maxLength: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            SizedBox(
                              height: 58.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: CupertinoButton(
                                  onPressed: (){
                                    mainProvider.changeObscureTextRegister();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        value.obscureTextRegister ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                                        color: !value.obscureTextRegister ? themeApp.buttonColor : themeApp.textTheme.caption.color,
                                      ),
                                      SizedBox(width: 12.0,),
                                      Text(
                                        value.obscureTextRegister ? 'Tampilkan kata sandi' : 'Sembunyikan kata sandi',
                                        style: themeApp.textTheme.button.copyWith(
                                          fontFamily: FontType.SFPRO_SEMIBOLD,
                                          color: !value.obscureTextRegister ? themeApp.buttonColor : themeApp.textTheme.button.color,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: mediaApp.size.height * 0.2),
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
                                child: FlatButton(
                                  onPressed: !value.loadingRegister && value.buttonActiveRegister ? () async {
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                    var result = await mainProvider.checkUsersRegister(context: context);
                                    if(!result['result']){
                                      var register = await mainProvider.registerAuthNewUser(context: context);
                                      if(register){
                                        mainProvider.pushRemoveUntilRoute(context: context, child: HomeAdminPage());
                                      }
                                    }
                                  } : (){}, 
                                  child: value.loadingRegister ? CupertinoActivityIndicator() : Text(
                                    'Daftar Sekarang',
                                  ),
                                  textColor: !value.loadingRegister && value.buttonActiveRegister ? ColorPalete.WHITE_TEXT_COLOR : themeApp.disabledColor,
                                  color: !value.loadingRegister && value.buttonActiveRegister ? themeApp.buttonColor : themeApp.dividerColor,
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
                  ]
                )
              )
            )
          )
        ),
      ),
    );
  }

}