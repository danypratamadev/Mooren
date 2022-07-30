import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mooren/const/ccolor.dart';
import 'package:mooren/provider/mainprovider.dart';
import 'package:provider/provider.dart';

class TambahPetugasPage extends StatelessWidget {

  final int action;

  TambahPetugasPage({Key key, @required this.action}) : super(key: key);

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final rtrwController = TextEditingController();
  final alamatController = TextEditingController();

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
                  Icons.arrow_back_rounded
                ), 
                onPressed: (){
                  Navigator.pop(context);
                }
              ),
              title: Text(
                action == 10 ? 'Tambah Petugas' : 'Edit Petugas'
              ),
              centerTitle: true,
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
                        padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 40.0),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                if(value.fotoPetugas != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(24.0),
                                  child: Material(
                                    color: themeApp.backgroundColor,
                                    child: InkWell(
                                      onTap: (){
                                        mainProvider.getImageGallery();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              blurRadius: 10.0,
                                              color: themeApp.dividerColor,
                                              offset: Offset(1.0, 1.0),
                                            )
                                          ]
                                        ),
                                        child: Image.file(
                                          value.fotoPetugas,
                                          width: 100.0,
                                          height: 100.0,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    )
                                  ),
                                )
                                else
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(24.0),
                                  child: Material(
                                    color: themeApp.backgroundColor,
                                    child: InkWell(
                                      onTap: (){
                                        mainProvider.getImageGallery();
                                      },
                                      child: Container(
                                        width: 100.0,
                                        height: 100.0,
                                        child: Icon(
                                          Icons.image,
                                          size: 72.0,
                                          color: themeApp.dividerColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.0,),
                                Text(
                                  value.fotoPetugas != null ? 'Klik untuk mengganti' : 'Klik untuk pilih foto'
                                )
                              ],
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
                                      controller: namaController,
                                      readOnly: value.readOnlyRegister,
                                      onChanged: (value){
                                        mainProvider.setInputValuePetugas(
                                          type: 10,
                                          value: value
                                        );
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Nama Lengkap',
                                        counter: Offstage(),
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.transparent,
                                      ),
                                      style: themeApp.textTheme.subtitle1,
                                      keyboardType: TextInputType.text,
                                      maxLength: 50,
                                      maxLines: null,
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
                                      controller: rtrwController,
                                      readOnly: value.readOnlyRegister,
                                      onChanged: (value){
                                        mainProvider.setInputValuePetugas(
                                          type: 20,
                                          value: value,
                                        );
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'RT/RW',
                                        counter: Offstage(),
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.transparent,
                                      ),
                                      style: themeApp.textTheme.subtitle1,
                                      keyboardType: TextInputType.text,
                                      maxLength: 10,
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
                                        mainProvider.setInputValuePetugas(
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
                            SizedBox(height: 30.0,),
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
                                        mainProvider.setInputValuePetugas(
                                          type: 40,
                                          value: value,
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
                                      maxLines: null,
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
                                      controller: phoneController,
                                      readOnly: value.readOnlyRegister,
                                      onChanged: (value){
                                        mainProvider.setInputValuePetugas(
                                          type: 50,
                                          value: value,
                                        );
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Nomor Telepon',
                                        counter: Offstage(),
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.transparent,
                                      ),
                                      style: themeApp.textTheme.subtitle1,
                                      keyboardType: TextInputType.number,
                                      maxLength: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: mediaApp.size.height * 0.2,)
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
                                  onPressed: !value.loadingPetugas && value.buttonActivePetugas ? () async {
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                    
                                  } : (){}, 
                                  child: value.loadingPetugas ? CupertinoActivityIndicator() : Text(
                                    action == 10 ? 'Simpan' : 'Perbarui Data',
                                  ),
                                  textColor: !value.loadingPetugas && value.buttonActivePetugas ? ColorPalete.WHITE_TEXT_COLOR : themeApp.disabledColor,
                                  color: !value.loadingPetugas && value.buttonActivePetugas ? themeApp.buttonColor : themeApp.dividerColor,
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
                ),
              ),
            )
          )
        ),
      )
    );

  }

}