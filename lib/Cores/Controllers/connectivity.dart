import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/connectivity_status.dart';
// import '../Models/request_status.dart';

class ConnectivityProvider extends GetxController {
  var conStatus = ''.obs as ConnectivityStatus;
  // RequestStatus reqStatus = RequestStatus.Stable;
  // changeRequestStatus(RequestStatus rqs) {
  //   reqStatus = rqs;
  //   notifyListeners();
  // }

  checkConnection() async{
    conStatus = _getStatus(await Connectivity().checkConnectivity());
    
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      conStatus = _getStatus(result);
      print(conStatus);
     
    });
  }

  bool conSt(ConnectivityStatus st) {
    print(st);
    if (st == ConnectivityStatus.Calcular || st == ConnectivityStatus.Wifi) {
      return true;
    } else {
      return false;
    }
  }

  ConnectivityStatus _getStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return ConnectivityStatus.Wifi;
        break;
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Calcular;
        break;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
        break;
      default:
        return ConnectivityStatus.Offline;
        break;
    }
  }
}
