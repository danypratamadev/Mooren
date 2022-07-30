import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mooren/const/ccolor.dart';
import 'package:mooren/const/cfont.dart';
import 'package:mooren/const/cvariable.dart';
import 'package:mooren/pages/admin/home.dart';
import 'package:mooren/pages/start/register.dart';
import 'package:mooren/provider/mainprovider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {

  final emailController = TextEditingController();
  final passController = TextEditingController();

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
              leading: IconButton(
                icon: Icon(
                  Icons.close_rounded,
                  color: ColorPalete.WARNING_RED,
                ), 
                onPressed: (){
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                }
              ),
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
                            Container(
                              width: mediaApp.size.width * 0.22,
                              height: mediaApp.size.width * 0.22,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(mediaApp.size.width * 0.06),
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
                            SizedBox(height: 24.0,),
                            Text(
                              'Akun Saya',
                              style: themeApp.textTheme.headline5.copyWith(
                                fontFamily: FontType.SFPRO_BOLD,
                              )
                            ),
                            Text(
                              'Silakan masuk menggunakan Email yang telah terdaftar.',
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
                                      controller: emailController,
                                      readOnly: value.readOnlyLogin,
                                      onChanged: (value){
                                        mainProvider.setInputValueLogin(
                                          type: 10,
                                          value: value,
                                        );
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Email',
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
                                      obscureText: value.obscureTextLogin,
                                      readOnly: value.readOnlyLogin,
                                      onChanged: (value){
                                        mainProvider.setInputValueLogin(
                                          type: 20,
                                          value: value,
                                        );
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        counter: Offstage(),
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        suffixIcon: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(30.0),
                                            child: Icon(
                                              value.obscureTextLogin ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                                              color: ColorPalete.TRITARY_BUTTON_COLOR,
                                            ), 
                                            onTap: (){
                                              mainProvider.changeObscureTextLogin();
                                            }
                                          ),
                                        )
                                      ),
                                      style: themeApp.textTheme.subtitle1,
                                      keyboardType: TextInputType.text,
                                      maxLength: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 50.0,),
                            SizedBox(
                              width: double.infinity,
                              height: 58.0,
                              child: FlatButton(
                                onPressed: !value.loadingLogin && value.buttonActiveLogin ? () async {
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                  var result = await mainProvider.checkUsersLogin(context: context);
                                  if(result['status']){
                                    var login = await mainProvider.loginAkun(context: context, data: result);
                                    if(login){
                                      mainProvider.pushReplaceRoute(context: context, child: HomeAdminPage());
                                    }
                                  }
                                } : () async {}, 
                                child: value.loadingLogin ? CupertinoActivityIndicator() : Text(
                                  'Masuk',
                                ),
                                textColor: !value.loadingLogin && value.buttonActiveLogin ? ColorPalete.WHITE_TEXT_COLOR : themeApp.disabledColor,
                                color: !value.loadingLogin && value.buttonActiveLogin ? themeApp.buttonColor : themeApp.dividerColor,
                                splashColor: Colors.black12,
                                highlightColor: Colors.black12,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0)
                                ),
                              ),
                            ),
                            SizedBox(height: 32.0,),
                            Align(
                              alignment: Alignment.center,
                              child: Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                                    child: Text(
                                      'Lupa kata sandi?',
                                      style: themeApp.textTheme.button.copyWith(
                                        fontFamily: FontType.SFPRO_REGULER
                                      )
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 24.0, bottom: 24.0,),
                                      child: Text(
                                        'Bantuan',
                                        style: themeApp.textTheme.button.copyWith(
                                          color: themeApp.buttonColor
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: mediaApp.size.height * 0.15),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        color: themeApp.backgroundColor,
                        child: Center(
                          child: Wrap(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                                child: Text(
                                  'Belum memiliki Akun?',
                                  style: themeApp.textTheme.button.copyWith(
                                    fontFamily: FontType.SFPRO_REGULER
                                  )
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  mainProvider.pushRoute(
                                    context: context, 
                                    child: RegisterPage(),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 24.0, bottom: 24.0,),
                                  child: Text(
                                    'Daftar Akun',
                                    style: themeApp.textTheme.button.copyWith(
                                      color: themeApp.buttonColor
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    )
                  ],
                ),
              ),
            ),
          )
        ),
      ),
    );
  }

}