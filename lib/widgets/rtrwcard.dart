import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mooren/const/ccolor.dart';
import 'package:mooren/const/cfont.dart';
import 'package:mooren/models/mrtrw.dart';
import 'package:mooren/provider/mainprovider.dart';
import 'package:mooren/widgets/dialog.dart';
import 'package:provider/provider.dart';

class RTRWCard extends StatelessWidget {

  final RTRWModel data;
  final TextEditingController rtController;
  final TextEditingController rwController;

  const RTRWCard({Key key, @required this.data, @required this.rtController, @required this.rwController}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var mainProvider = Provider.of<MainProvider>(context, listen: false);
    
    var themeApp = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: (){
          DialogApp.showAlertDialog(
            context: context,
            dismissible: true,
            title: Text(
              'RT ${data.rt} / RW ${data.rw}',
              style: Theme.of(context).textTheme.headline6.copyWith(
                fontFamily: FontType.SFPRO_SEMIBOLD,
              )
            ),
            action: [
              CupertinoButton(
                child: Text(
                  'Hapus',
                  style: Theme.of(context).textTheme.button.copyWith(
                    color: ColorPalete.WARNING_RED,
                  )
                ), 
                onPressed: (){
                  Navigator.pop(context);
                  DialogApp.showAlertDialog(
                    context: context,
                    dismissible: true,
                    title: Text(
                      'Hapus RT ${data.rt} / RW ${data.rw}',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                        fontFamily: FontType.SFPRO_SEMIBOLD,
                      )
                    ),
                    message: 'Apakah anda yakin ingin menghapus RT ${data.rt} / RW ${data.rw}?',
                    action: [
                      CupertinoButton(
                        child: Text(
                          'Hapus',
                          style: Theme.of(context).textTheme.button.copyWith(
                            color: ColorPalete.WARNING_RED,
                          )
                        ), 
                        onPressed: () async {
                          Navigator.pop(context);
                          var result = await mainProvider.deleteRTRW(context: context, rtrw: data);
                          if(result){
                            mainProvider.getRTRW(context: context);
                          } else {
                            Navigator.pop(context);
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
                }
              ),
              CupertinoButton(
                child: Text(
                  'Edit',
                  style: Theme.of(context).textTheme.button.copyWith(
                    color: Theme.of(context).buttonColor
                  )
                ), 
                onPressed: (){
                  Navigator.pop(context);
                  DialogApp.showBottomSheetDialog(
                    context: context,
                    title: 'Edit RT ${data.rt} / RW ${data.rw}',
                    describe: 'Perbarui data RT/RW yang terdapat pada Desa',
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
                                        hintText: data.rt,
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
                                        hintText: data.rw,
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
                                    bool update = await mainProvider.updateRTRW(context: context, id: data.id);
                                    if(update){
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
                                  'Perbarui',
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
                }
              ),
            ]
          );
        },
        title: Text(
          'RT ${data.rt} / RW ${data.rw}',
        ),
        trailing: data.loading ? CupertinoActivityIndicator() : Icon(
          Icons.chevron_right_rounded
        ),
      ),
    );
  }

}