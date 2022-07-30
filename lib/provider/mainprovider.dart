import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mooren/const/cfont.dart';
import 'package:mooren/const/crout.dart';
import 'package:mooren/controllers/firestorecontroller.dart';
import 'package:mooren/models/mbobotparam.dart';
import 'package:mooren/models/minfo.dart';
import 'package:mooren/models/mmenu.dart';
import 'package:mooren/models/mperiode.dart';
import 'package:mooren/models/mpetugas.dart';
import 'package:mooren/models/mrtrw.dart';
import 'package:mooren/pages/admin/datablt.dart';
import 'package:mooren/pages/admin/datainfo.dart';
import 'package:mooren/pages/admin/datakriteria.dart';
import 'package:mooren/pages/admin/datapetugas.dart';
import 'package:mooren/pages/admin/pengaturan.dart';
import 'package:mooren/widgets/dialog.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;

class MainProvider extends ChangeNotifier {
  
  //! ALL VARIABLE ============================================================>
  //? Variable Golobal
  final firestoreContoller = FirestoreContoller();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  storage.Reference fs = storage.FirebaseStorage.instance.ref();

  String appName;
  String appVersion;
  String appBuildNumber;
  String idUser;
  String fotoUser;
  String namaUser;
  String kodeUser;
  String emailUser;
  String phoneUser;
  String alamatUser;
  bool showBuildNumber = false;
  bool loadingLogout = false;

  //? Variable Login
  String emailUserLogin;
  String passUserLogin;
  bool readOnlyLogin = false;
  bool buttonActiveLogin = false;
  bool obscureTextLogin = true;
  bool loadingLogin = false;

  //? Variable Register
  String namaDesaRegister;
  String kodewilayahRegister;
  String alamatRegister;
  String emailUserRegister;
  String passUserRegister;
  String confirmUserRegister;
  bool readOnlyRegister = false;
  bool buttonActiveRegister = false;
  bool obscureTextRegister = true;
  bool loadingRegister = false;

  //? variable Home Admin
  MenuModel menu1 = new MenuModel(action: 10, title: 'Data BLT-DD', icon: Icons.contacts_rounded, color: Colors.teal);
  MenuModel menu2 = new MenuModel(action: 20, title: 'Data Petugas', icon: Icons.badge, color: Colors.indigo);
  MenuModel menu3 = new MenuModel(action: 30, title: 'Data Kriteria', icon: Icons.fact_check_rounded, color: Colors.orange);
  MenuModel menu4 = new MenuModel(action: 40, title: 'Data Info', icon: Icons.campaign_rounded, color: Colors.pink);
  MenuModel menu5 = new MenuModel(action: 50, title: 'Pengaturan', icon: Icons.settings_rounded, color: Colors.blueGrey);
  List<MenuModel> listMenu = new List<MenuModel>();

  //? Variable Data Petugas
  List<PetugasModel> listPetugas = new List<PetugasModel>();
  bool emptyPetugas = false;

  //? Variable Tambah Petugas
  File fotoPetugas;
  String namaPetugas;
  String emailPetugas;
  String phonePetugas;
  String rtrwPetugas;
  String alamatPetugas;
  bool readOnlyPetugas = false;
  bool buttonActivePetugas = false;
  bool loadingPetugas = false;

  //? Variable Data Informasi
  List<InfoModel> listInfo = new List<InfoModel>();
  bool emptyInformasi = false;

  //? Variable Periode
  List<PeriodeModel> listPeriode = new List<PeriodeModel>();
  String namaPeriode;
  bool emptyPeriode = false;
  bool readOnlyPeriode = false;
  bool loadingPeriode = false;
  bool buttonActivePeriode = false;

  //? Variable RT/RW
  List<RTRWModel> listRTRW = new List<RTRWModel>();
  String namaRT;
  String namaRW;
  bool emptyRTRW = false;
  bool readOnlyRTRW = false;
  bool loadingRTRW = false;
  bool buttonActiveRTRW = false;

  //? Variable Bobot Parameter
  List<BobotParameterModel> listBobot = new List<BobotParameterModel>();
  bool emptyBobotParameter = false;

  //! ALL FUNCTION ============================================================>

  //? getCurrentUser => Mengambil data user yang saat ini sedang aktif
  Future<bool> getCurrentUser() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();

    var user = firebaseAuth.currentUser;

    if(user != null){
      idUser = preferences.getString('iduser') ?? '-';
      fotoUser = preferences.getString('fotouser') ?? '-';
      namaUser = preferences.getString('namauser') ?? '-';
      kodeUser = preferences.getString('kodeuser') ?? '-';
      emailUser = preferences.getString('emailuser') ?? '-';
      phoneUser = preferences.getString('phoneuser') ?? '-';
      alamatUser = preferences.getString('alamatuser') ?? '-';
      listMenu.add(menu1);
      listMenu.add(menu2);
      listMenu.add(menu3);
      listMenu.add(menu4);
      listMenu.add(menu5);
      notifyListeners();
    }

    return user != null ? true : false;

  }

  //? checkUsersLogin => Melakukan pengecekan apakah user dengan email yang diinputkan
  //? sudah terdaftar pada firestore, jika belum maka tampilkan dialog peringatan,
  //? jika sudah sudah terdaftar maka lakukan pengecekan apakah passwordnya sudah benar
  //? atau belum, jika password salah maka tampilkan dialog peringatan, jika password
  //? sudah benar maka lanjutkan ke proses login authtentication.
  Future<dynamic> checkUsersLogin({@required BuildContext context}) async {

    bool checkResult = false;
    String id, nama, kode, alamat;

    loadingLogin = true;
    readOnlyLogin = true;
    notifyListeners();

    var collection = firestore.collection('users');

    QuerySnapshot result = await firestoreContoller.getDocument(
      context: context, 
      reference: collection, 
      whereField: 'email', 
      whereValue: emailUserLogin,
    );

    if(result.docs.isNotEmpty){
      result.docs.forEach((f) {
        if(generateMD5(data: passUserLogin) == f.get('password')){
          id = f.id;
          nama = f.get('nama');
          kode = f.get('kode');
          alamat = f.get('alamat');
          checkResult = true;
        } else {
          DialogApp.showAlertDialog(
            context: context,
            dismissible: true,
            title: Text(
              'Terjadi Kesalahan',
              style: Theme.of(context).textTheme.headline6.copyWith(
                fontFamily: FontType.SFPRO_SEMIBOLD,
              )
            ),
            message: 'Password yang Anda masukkan salah! Silakan periksa Password Anda dan coba kembali.',
            action: [
              CupertinoButton(
                child: Text(
                  'OK',
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

          loadingLogin = false;
          readOnlyLogin = false;
          notifyListeners();
        }
      });
    } else {
      DialogApp.showAlertDialog(
        context: context,
        dismissible: true,
        title: Text(
          'Terjadi Kesalahan',
          style: Theme.of(context).textTheme.headline6.copyWith(
            fontFamily: FontType.SFPRO_SEMIBOLD,
          )
        ),
        message: 'Email tidak terdaftar! Silakan periksa alamat Email Anda dan coba kembali.',
        action: [
          CupertinoButton(
            child: Text(
              'OK',
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

      loadingLogin = false;
      readOnlyLogin = false;
      notifyListeners();
    }

    var finalResult = {
      'status': checkResult,
      'id': id ?? '-',
      'nama': nama ?? '-',
      'kode': kode ?? '-',
      'alamat': alamat ?? '-',
    };

    return finalResult;

  }

  //? loginAkun => Proses login akun authentication user
  Future<bool> loginAkun({@required BuildContext context, @required Map<String, dynamic> data}) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool loginStatus = false;

    try {

      await firebaseAuth.signInWithEmailAndPassword(
        email: emailUserLogin, 
        password: passUserLogin
      ).then((value) async {
        if(firebaseAuth.currentUser.uid == value.user.uid){
          preferences.setString('iduser', data['id']);
          preferences.setString('namauser', data['nama']);
          preferences.setString('kodeuser', data['kode']);
          preferences.setString('emailuser', emailUserLogin);
          preferences.setString('alamatuser', data['alamat']);
          idUser = data['id'];
          fotoUser = data['foto'] ?? '-';
          namaUser = data['nama'];
          kodeUser = data['kode'];
          emailUser = emailUserLogin;
          phoneUser = data['telepon'] ?? '-';
          alamatUser = data['alamat'];
          listMenu.add(menu1);
          listMenu.add(menu2);
          listMenu.add(menu3);
          listMenu.add(menu4);
          listMenu.add(menu5);
          loginStatus = true;
          loadingLogin = false;
          readOnlyLogin = false;
          notifyListeners();
        }
      });

    } catch (error) {
      loadingLogin = false;
      readOnlyLogin = false;
      notifyListeners();
      DialogApp.showAlertDialog(
        context: context,
        dismissible: true,
        title: Text(
          'Terjadi Kesalahan',
          style: Theme.of(context).textTheme.headline6.copyWith(
            fontFamily: FontType.SFPRO_SEMIBOLD,
          )
        ),
        message: '$error',
        action: [
          CupertinoButton(
            child: Text(
              'OK',
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

    return loginStatus;

  }

  //? checkUsersRegister => Melakukan pengecekan user ke forestore, apakah kode
  //? wilayah atau alamat email sudah terdaftar apa belum, jika sudah terdaftar
  //? maka proses pendaftaran dihentikan dan menampilkan dialog peringatan, jika
  //? belum terdaftar maka dilanjutkan ke proses pendaftaran authentication dan
  //? datanya disimpan ke firestore pada collection users.
  Future<dynamic> checkUsersRegister({@required BuildContext context}) async {

    loadingRegister = true;
    readOnlyRegister = true;
    notifyListeners();

    bool registerStatus = false, kodeWilayahStatus = false, emailStatus = false;
    var collection = firestore.collection('users'); 

    for(int i = 0; i < 2; i++){

      QuerySnapshot result = await firestoreContoller.getDocument(
        context: context, 
        reference: collection, 
        whereField: i == 0 ? 'kode' : 'email', 
        whereValue: i == 0 ? kodewilayahRegister : emailUserRegister,
      );

      if(result.docs.isNotEmpty){
        if(i == 0){
          kodeWilayahStatus = true;
        } else {
          emailStatus = true;
        }
      }

    }

    if(kodeWilayahStatus || emailStatus){

      String message;

      if(kodeWilayahStatus && !emailStatus){
        message = 'Kode Wilayah telah terdaftar sebelumnya! Silakan periksa Kode Wilayah Desa Anda dan coba kembali.';
      } else if(!kodeWilayahStatus && emailStatus){
        message = 'Email telah terdaftar sebelumnya! Silakan gunakan alamat Email yang berbeda dan coba kembali.';
      } else {
        message = 'Kode Wilayah dan alamat Email telah terdaftar sebelumnya! Silakan periksa Kode Wilayah dan alamat Email Anda kemudian coba kembali.';
      }

      DialogApp.showAlertDialog(
        context: context,
        dismissible: true,
        title: Text(
          'Terjadi Kesalahan',
          style: Theme.of(context).textTheme.headline6.copyWith(
            fontFamily: FontType.SFPRO_SEMIBOLD,
          )
        ),
        message: message,
        action: [
          CupertinoButton(
            child: Text(
              'OK',
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

      registerStatus = true;
      loadingRegister = false;
      readOnlyRegister = false;
      notifyListeners();
    }

    var result = {
      'result': registerStatus ?? false,
      'kode': kodeWilayahStatus ?? false,
      'email': emailStatus ?? false,
    };

    return result;

  }

  //? registerAuthNewUser => Proses mendaftarkan user baru menggunakan email
  //? dan kata sandi yang telah diinputkan pada inputan pendaftaran, jika pendaftaran
  //? berhasil maka user akan diarahkan ke halaman home admin, jika pendaftaran
  //? gagal maka proses pendaftaran di hentikan dan menampilkan dialog berisi
  //? pesan error dari gagalnya proses pendaftaran.
  Future<bool> registerAuthNewUser({@required BuildContext context}) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();

    bool register = false;

    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: emailUserRegister,
        password: passUserRegister,
      ).then((value) async {
        if(firebaseAuth.currentUser.uid == value.user.uid){
          var result = await saveNewUser(context: context);
          if(result['status']){
            preferences.setString('iduser', result['id']);
            preferences.setString('namauser', namaDesaRegister);
            preferences.setString('kodeuser', kodewilayahRegister);
            preferences.setString('emailuser', emailUserRegister);
            preferences.setString('alamatuser', alamatRegister);
            idUser = result['id'];
            fotoUser = '-';
            namaUser = namaDesaRegister;
            kodeUser = kodewilayahRegister;
            emailUser = emailUserLogin;
            phoneUser = '-';
            alamatUser = alamatRegister;
            listMenu.add(menu1);
            listMenu.add(menu2);
            listMenu.add(menu3);
            listMenu.add(menu4);
            listMenu.add(menu5);
            register = true;
            loadingRegister = false;
            readOnlyRegister = false;
            notifyListeners();
          }
        }
      });
    } catch (error) {
      loadingRegister = false;
      readOnlyRegister = false;
      notifyListeners();
      DialogApp.showAlertDialog(
        context: context,
        dismissible: true,
        title: Text(
          'Terjadi Kesalahan',
          style: Theme.of(context).textTheme.headline6.copyWith(
            fontFamily: FontType.SFPRO_SEMIBOLD,
          )
        ),
        message: '$error',
        action: [
          CupertinoButton(
            child: Text(
              'OK',
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

    return register;
  }

  //? saveNewUser => Proses menyimpan user baru ke firestore pada collection users
  Future<dynamic> saveNewUser({@required BuildContext context}) async {
    
    var collection = firestore.collection('users');

    var saveResult = await firestoreContoller.saveDocument(
      context: context, 
      reference: collection,
      data: {
        'nama': namaDesaRegister,
        'kode': kodewilayahRegister,
        'alamat': alamatRegister,
        'email': emailUserRegister,
        'password': generateMD5(data: passUserRegister),
        'dibuat': FieldValue.serverTimestamp(),
      }
    ).then((value) {
      if(value['status']){
        setBobotParameter(context: context, id: value['id']);
      }
    });

    return saveResult;

  }

  Future setBobotParameter({@required BuildContext context, @required String id}) async {

    List bobot = [[1, true],[3, true],[5, true],[7, false],[9, false]];
    var collection = firestore.collection('users/$id/bobotparameter');

    bobot.forEach((data) async {
      await firestoreContoller.saveDocument(
        context: context, 
        reference: collection,
        data: {
          'bobot': data[0],
          'aktif': data[1],
          'dibuat': FieldValue.serverTimestamp(),
        }
      );
    });

  }

  //? generateMD5 => Digunakan untuk mengkonversi string kata sandi menjadi format MD5
  String generateMD5({@required String data}) {

    var content = new Utf8Encoder().convert(data);
    var digest = crypto.md5.convert(content);

    return hex.encode(digest.bytes);
  }

  Future<bool> checkRTRW({@required BuildContext context}) async {

    bool checkResult = false;

    loadingRTRW = true;
    readOnlyRTRW = true;
    notifyListeners();

    var collection = firestore.collection('users/$idUser/rtrw');

    QuerySnapshot result = await firestoreContoller.getDocument(
      context: context, 
      reference: collection,
      whereField: 'nama',
      whereValue: '$namaRT/$namaRW',
    );

    if(result.docs.isNotEmpty){

      DialogApp.showAlertDialog(
        context: context,
        dismissible: true,
        title: Text(
          'Terjadi Kesalahan',
          style: Theme.of(context).textTheme.headline6.copyWith(
            fontFamily: FontType.SFPRO_SEMIBOLD,
          )
        ),
        message: 'RT/RW sudah terdaftar! Silakan periksa RT/RW yang Anda masukkan dan coba kembali.',
        action: [
          CupertinoButton(
            child: Text(
              'OK',
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

      checkResult = true;
      namaRT = null;
      namaRW = null;
      loadingRTRW = false;
      readOnlyRTRW = false;
      buttonActiveRTRW = false; 
      notifyListeners();

    }

    return checkResult;

  }

  Future<dynamic> saveRTRW({@required BuildContext context}) async {

    var collection = firestore.collection('users/$idUser/rtrw');

    var saveResult = await firestoreContoller.saveDocument(
      context: context, 
      reference: collection,
      data: {
        'nama': '$namaRT/$namaRW',
        'rt': namaRT,
        'rw': namaRW,
        'delete': false,
        'dibuat': FieldValue.serverTimestamp(),
      }
    );

    namaRT = null;
    namaRW = null;
    loadingRTRW = false;
    readOnlyRTRW = false;
    buttonActiveRTRW = false;
    notifyListeners();

    return saveResult;

  }

  Future<bool> updateRTRW({@required BuildContext context, @required String id}) async {
    
    loadingRTRW = true;
    readOnlyRTRW = true;
    notifyListeners();

    var document = firestore.doc('users/$idUser/rtrw/$id');

    bool updateStatus = await firestoreContoller.updateDocument(
      context: context, 
      document: document, 
      data: {
        'nama': '$namaRT/$namaRW',
        'rt': namaRT,
        'rw': namaRW,
        'diedit': FieldValue.serverTimestamp(),
      }
    );

    namaRT = null;
    namaRW = null;
    loadingRTRW = false;
    readOnlyRTRW = false;
    buttonActiveRTRW = false;
    notifyListeners();

    return updateStatus ?? false;

  }

  Future<bool> deleteRTRW({@required BuildContext context, @required RTRWModel rtrw}) async {
    
    rtrw.loading = true;
    notifyListeners();

    var document = firestore.doc('users/$idUser/rtrw/${rtrw.id}');

    bool deleteStatus = await firestoreContoller.updateDocument(
      context: context, 
      document: document, 
      data: {
        'delete': true,
        'dihapus': FieldValue.serverTimestamp(),
      }
    );

    return deleteStatus ?? false;
  }

  Future<bool> updateBobotParameter({@required BuildContext context, @required BobotParameterModel bobot}) async {

    bool updateStatus = false;
    int bobotAktif = 0;

    listBobot.forEach((data) {
      if(data.aktif){
        bobotAktif++;
      }
    });
    
    if(bobot.aktif){
      if(bobotAktif > 3) {
        bobot.loading = true;
        notifyListeners();

        var document = firestore.doc('users/$idUser/bobotparameter/${bobot.id}');

        updateStatus = await firestoreContoller.updateDocument(
          context: context, 
          document: document, 
          data: {
            'aktif': !bobot.aktif,
            'diedit': FieldValue.serverTimestamp(),
          }
        );

        bobot.loading = false;
        notifyListeners();
      } else {
        DialogApp.showAlertDialog(
          context: context,
          dismissible: true,
          title: Text(
            'Tidak Dapat Menonaktifkan',
            style: Theme.of(context).textTheme.headline6.copyWith(
              fontFamily: FontType.SFPRO_SEMIBOLD,
            )
          ),
          message: 'Harus terdapat minimal 3 bobot parameter yang aktif.',
          action: [
            CupertinoButton(
              child: Text(
                'OK',
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
    } else {
      bobot.loading = true;
      notifyListeners();

      var document = firestore.doc('users/$idUser/bobotparameter/${bobot.id}');

      updateStatus = await firestoreContoller.updateDocument(
        context: context, 
        document: document, 
        data: {
          'aktif': !bobot.aktif,
          'diedit': FieldValue.serverTimestamp(),
        }
      );

      bobot.loading = false;
      notifyListeners();
    }

    return updateStatus ?? false;

  }
  
  //? logoutAccount => Proses keluar dari akun authtentication milik user
  Future<bool> logoutAccount() async {

    loadingLogout = true;
    notifyListeners();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool result = false;

    await firebaseAuth.signOut().then((value){
      result = true;
      preferences.clear();
    });

    return result;

  }
  
  //! ALL METHOD ==============================================================>
  
  //? getAppInfo => Mengambil data tentang aplikasi
  getAppInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    appName = info.appName;
    appVersion = info.version;
    appBuildNumber = info.buildNumber;

    notifyListeners();
  }

  showInfoBuildNumber() {
    showBuildNumber = !showBuildNumber;
    notifyListeners();
  }
  
  //? setInputValueLogin => Menyimpan inputan email atau password ke variable 
  //? yang telah ditentukan
  setInputValueLogin({@required int type, @required dynamic value}) {
    if(type == 10){
      emailUserLogin = value;
    } else {
      passUserLogin = value;
    }
    enableButtonLogin();
  }

  //? enableButtonLogin => Mengaktifkan tombol masuk dengan memvalidasi inputan email
  //? dan password
  enableButtonLogin() {
    if(EmailValidator.validate(emailUserLogin) && passUserLogin.length > 5){
      buttonActiveLogin = true;
    } else {
      buttonActiveLogin = false;
    }
    notifyListeners();
  }

  //? changeObscureTextLogin => Mengubah password pada login menjadi visible atau tidak
  changeObscureTextLogin() {
    obscureTextLogin = !obscureTextLogin;
    notifyListeners();
  }

  //? setInputValueRegister => Menyimpan inputan data pendaftaran ke variable 
  //? yang telah ditentukan
  setInputValueRegister({@required int type, @required dynamic value}) {
    switch(type){
      case 10:
        namaDesaRegister = value;
      break;
      case 20:
        kodewilayahRegister = value;
      break;
      case 30:
        alamatRegister = value;
      break;
      case 40:
        emailUserRegister = value;
      break;
      case 50:
        passUserRegister = value;
      break;
      case 60:
        confirmUserRegister = value;
      break;
    }

    enableButtonRegister();
  }

  //? enableButtonRegister => Mengaktifkan tombol daftar dengan memvalidasi inputan data
  //? pendaftaran
  enableButtonRegister() {
    if(namaDesaRegister.length > 2 && kodewilayahRegister.length > 5 && 
      alamatRegister.length > 5 && EmailValidator.validate(emailUserRegister) && 
      passUserRegister.length > 5 && passUserRegister == confirmUserRegister){
      buttonActiveRegister = true;
    } else {
      buttonActiveRegister = false;
    }
    notifyListeners();
  }

  //? changeObscureTextRegister => Mengubah password pada register menjadi visible atau tidak
  changeObscureTextRegister() {
    obscureTextRegister = !obscureTextRegister;
    notifyListeners();
  }

  //? onMenuActionClick => Proses berpindah halaman baru sesuai dengan menu yang
  //? dipilih pada halaman Home Admin
  onMenuActionClick({@required BuildContext context, @required int action}) {
    
    switch(action){
      case 10: 
        pushRoute(
          context: context,
          child: DataBLTDDPage(),
        );
        break;
      case 20: 
        pushRoute(
          context: context,
          child: DataPetugasPage(),
        );
        break;
      case 30: 
        pushRoute(
          context: context,
          child: DataKriteriaPage(),
        );
        break;
      case 40: 
        pushRoute(
          context: context,
          child: DataInfoPage(),
        );
        break;
      case 50: 
        pushRoute(
          context: context,
          child: PengaturanPage(),
        );
        break;
    }

  }

  //? onRefresh => Permintaan untuk mengambil ulang data yang terdapat pada
  //? halaman ter
  onRefresh({@required BuildContext context, @required int action}) async {

    switch(action){
      case 10:
        
      break;
      case 20:
        
      break;
      case 30:
        await getPetugas(context: context);
      break;
      case 40:
        
      break;
      case 50:
        
      break;
      case 60:
        
      break;
      case 70:
        
      break;
    }

  }

  //? getPetugas => Proses mengambil data petugas dari database
  getPetugas({@required BuildContext context}) async {

    List<PetugasModel> listPetugasTemp = new List<PetugasModel>();
    var collection = firestore.collection('users');

    QuerySnapshot result = await firestoreContoller.getDocument(
      context: context, 
      reference: collection, 
      whereField: 'role', 
      whereValue: 10,
    );

    if(result.docs.isNotEmpty){

      result.docs.forEach((f) {
        PetugasModel petugas = new PetugasModel(
          id: f.id, 
          foto: f.get('foto'),
          nama: f.get('nama'), 
          alamat: f.get('alamat'), 
          email: f.get('email'),
        );
        listPetugasTemp.add(petugas);
      });

      listPetugas = listPetugasTemp;
      emptyPetugas = false;
      notifyListeners();

    } else {

      emptyPetugas = true;
      notifyListeners();

    }

  }

  //? getImageGallery => Proses mengakses galeri foto untuk dipilih menjadi foto
  //? dari petugas yang akan ditambahkan
  getImageGallery() async {

    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      fotoPetugas = image;
      compressImage();
    }

  }

  //? compressImage => Proses kompres ukuran file foto yang dipilih menjadi lebih
  //? kecil
  compressImage() async {

    final dir = await path_provider.getTemporaryDirectory();
    var name = path.basename(fotoPetugas.absolute.path);

    var result = await FlutterImageCompress.compressAndGetFile(
      fotoPetugas.absolute.path,
      dir.absolute.path + '/${DateTime.now()}_$name',
      quality: 60,
    );

    print('before : ' + fotoPetugas.lengthSync().toString());
    print('after : ' + result.lengthSync().toString());

    fotoPetugas = result;
    notifyListeners();

  }

  //? setInputValuePetugas => Menyimpan inputan data pendaftaran petugas baru ke 
  //? variable yang telah ditentukan
  setInputValuePetugas({@required int type, @required dynamic value}) {
    switch(type){
      case 10:
        namaPetugas = value;
      break;
      case 20:
        rtrwPetugas = value;
      break;
      case 30:
        alamatPetugas = value;
      break;
      case 40:
        emailPetugas = value;
      break;
      case 50:
        phonePetugas = value;
      break;
    }

    enableButtonPetugas();
  }

  //? enableButtonRegister => Mengaktifkan tombol daftar dengan memvalidasi inputan data
  //? pendaftaran
  enableButtonPetugas() {
    if(namaPetugas.length > 2 && rtrwPetugas.length > 1 && 
      alamatPetugas.length > 5 && EmailValidator.validate(emailPetugas) && 
      phonePetugas.length > 8) {
      buttonActivePetugas = true;
    } else {
      buttonActivePetugas = false;
    }
    notifyListeners();
  }

  uploadImageToFirebase() async {

    storage.Reference reference = fs.child('$namaUser/petugas/$namaPetugas');

    try {

      storage.UploadTask uploadTask = reference.putFile(fotoPetugas);

      uploadTask.snapshot;

      uploadTask.events.listen((persen) {
        double persentase = 100 * (persen.snapshot.bytesTransferred.toDouble() / persen.snapshot.totalByteCount.toDouble());
      });

      storage.TaskSnapshot taskSnapshot = uploadTask.snapshot;
      final String url = await taskSnapshot.ref.getDownloadURL();
      
    } catch (error) {
      print(error);
    }
  }

  //? getPetugas => Proses mengambil data petugas dari database
  getInfo({@required BuildContext context}) async {

    List<InfoModel> listinfoTemp = new List<InfoModel>();
    var collection = firestore.collection('info');

    QuerySnapshot result = await firestoreContoller.getDocument(
      context: context, 
      reference: collection, 
      whereField: 'iddesa', 
      whereValue: idUser,
    );

    if(result.docs.isNotEmpty){

      result.docs.forEach((f) {
        InfoModel info = new InfoModel(
          id: f.id, 
          judul: f.get('judul'),
          body: f.get('body'), 
        );
        listinfoTemp.add(info);
      });

      listInfo = listinfoTemp;
      emptyInformasi = false;
      notifyListeners();

    } else {

      emptyInformasi = true;
      notifyListeners();

    }

  }

  getRTRW({@required BuildContext context}) async {
    
    List<RTRWModel> listRTRWTemp = new List<RTRWModel>();
    var collection = firestore.collection('users/$idUser/rtrw');

    QuerySnapshot result = await firestoreContoller.getDocument(
      context: context, 
      reference: collection, 
      whereField: 'delete',
      whereValue: false,
    );

    if(result.docs.isNotEmpty){

      result.docs.forEach((f) {
        RTRWModel rtrw = new RTRWModel(
          id: f.id, 
          nama: f.get('nama'), 
          rt: f.get('rt'), 
          rw: f.get('rw'),
          loading: false,
        );
        listRTRWTemp.add(rtrw);
      });

      listRTRW = listRTRWTemp;
      emptyRTRW = false;
      notifyListeners();

    } else {

      listRTRW.clear();
      emptyRTRW = true;
      notifyListeners();

    }

  }

  setInputValueRTRW({@required int type, @required dynamic value}) {
    if(type == 10){
      namaRT = value;
    } else {
      namaRW = value;
    }
    enableButtonRTRW();
  }

  enableButtonRTRW() {
    if(namaRT.length > 0 && namaRW.length > 0){
      buttonActiveRTRW = true;
    } else {
      buttonActiveRTRW = false;
    }
    notifyListeners();
  }

  getBobotParameter({@required BuildContext context}) async {

    List<BobotParameterModel> listBobotTemp = new List<BobotParameterModel>();
    var collection = firestore.collection('users/$idUser/bobotparameter');

    QuerySnapshot result = await firestoreContoller.getDocument(
      context: context, 
      reference: collection, 
      orderBy: 'bobot'
    );

    if(result.docs.isNotEmpty){

      result.docs.forEach((f) {
        BobotParameterModel bobot = new BobotParameterModel(
          id: f.id, 
          bobot: f.get('bobot'), 
          aktif: f.get('aktif'),
          loading: false,
        );
        listBobotTemp.add(bobot);
      });

      listBobot = listBobotTemp;
      emptyBobotParameter = false;
      notifyListeners();

    } else {

      listBobot.clear();
      emptyBobotParameter = true;
      notifyListeners();

    }

  }

  setDefaultValue() {

    appName = null;
    appVersion = null;
    appBuildNumber = null;
    idUser = null;
    fotoUser = null;
    namaUser = null;
    kodeUser = null;
    emailUser = null;
    phoneUser = null;
    alamatUser = null;
    showBuildNumber = false;
    loadingLogout = false;

    //? Variable Login
    emailUserLogin = null;
    passUserLogin = null;
    readOnlyLogin = false;
    buttonActiveLogin = false;
    obscureTextLogin = true;
    loadingLogin = false;

    //? Variable Register
    namaDesaRegister = null;
    kodewilayahRegister = null;
    alamatRegister = null;
    emailUserRegister = null;
    passUserRegister = null;
    confirmUserRegister = null;
    readOnlyRegister = false;
    buttonActiveRegister = false;
    obscureTextRegister = true;
    loadingRegister = false;

    //? variable Home Admin
   listMenu = new List<MenuModel>();

    //? Variable Data Petugas
    listPetugas = new List<PetugasModel>();
    emptyPetugas = false;

    //? Variable Tambah Petugas
    fotoPetugas = null;
    namaPetugas = null;
    emailPetugas = null;
    phonePetugas = null;
    rtrwPetugas = null;
    alamatPetugas = null;
    readOnlyPetugas = false;
    buttonActivePetugas = false;
    loadingPetugas = false;

  }
  
  //! PUSH ROUT PAGE OPTIONAL =================================================>
  pushRoute({@required BuildContext context, @required Widget child}) {
    Navigator.of(context).push(
      MainRoute.sharedAxisRoute(
        destination: child,
        milliseconds: 400,
        type: SharedAxisTransitionType.scaled,
      )
    );
  }
  
  pushReplaceRoute({@required BuildContext context, @required Widget child}) {
    Navigator.of(context).pushReplacement(
      MainRoute.sharedAxisRoute(
        destination: child,
        milliseconds: 400,
        type: SharedAxisTransitionType.scaled,
      )
    );
  }

  pushRemoveUntilRoute({@required BuildContext context, @required Widget child}) {
    Navigator.of(context).pushAndRemoveUntil(
      MainRoute.sharedAxisRoute(
        destination: child,
        milliseconds: 400,
        type: SharedAxisTransitionType.scaled,
      ),
      (Route<dynamic> route) => false,
    );
  }

  //!
}