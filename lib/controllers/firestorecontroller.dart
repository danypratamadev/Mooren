import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirestoreContoller {

  static const int TIME_OUT_DURATION = 20;

  Future<dynamic> getDocument({@required BuildContext context, @required CollectionReference reference, String whereField, dynamic whereValue, String orderBy, bool desc,}) async {
    
    var result;

    if(whereField != null){
      result = await reference.where(whereField, isEqualTo: whereValue).get().timeout(Duration(seconds: TIME_OUT_DURATION));
    } else if(orderBy != null){
      result = await reference.orderBy(orderBy, descending: desc ?? false).get().timeout(Duration(seconds: TIME_OUT_DURATION));
    } else {
      result = await reference.get().timeout(Duration(seconds: TIME_OUT_DURATION));
    }

    if(result == null) return false;
    
    return result;

  }

  Future<dynamic> saveDocument({@required BuildContext context, @required CollectionReference reference, Map<String, dynamic> data}) async {
    
    String id;
    bool status = false; 
    
    await reference.add(data).then((value){
      if(value.id != null){
        id = value.id;
        status = true;
      }
    }).timeout(Duration(seconds: TIME_OUT_DURATION));

    var result = {
      'status': status ?? false,
      'id': id ?? '-',
    };
    
    return result;

  }

  Future<bool> updateDocument({@required BuildContext context, @required DocumentReference document, Map<String, dynamic> data}) async {
    
    bool status = false; 
    
    await document.update(data).then((value){
      status = true;
    }).timeout(Duration(seconds: TIME_OUT_DURATION));
    
    return status;

  }

  Future<bool> deleteDocument({@required BuildContext context, @required DocumentReference documnet}) async {
    
    bool status = false; 
    
    await documnet.delete().then((value){
      status = true;
    }).timeout(Duration(seconds: TIME_OUT_DURATION));
    
    return status;

  }

}