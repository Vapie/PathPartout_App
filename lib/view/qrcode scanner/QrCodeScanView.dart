import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mvvm_flutter_app/MainConfig.dart';
import 'package:mvvm_flutter_app/classes/achievementUnlocked.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/notification/rando-notif.dart';
import 'package:mvvm_flutter_app/view/splash/SplashViewModel.dart';
import 'package:mvvm_flutter_app/widget/podometer/Podometre.dart';
import 'package:stacked/stacked.dart';
import '../../main.dart';
import 'QrCodeScanViewModel.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

//pour générer les qr : https://www.the-qrcode-generator.com/
//Format PathPartoutLesBoss:Unlock:60b26b19ad64d61c84e77baf
class QRCodeScanView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRViewScanViewState();
}

class _QRViewScanViewState extends State<QRCodeScanView> {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {


    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        print(scanData.code);
        List<String> availableArchivements =["60b26b19ad64d61c84e77baf","60b26b19ad64d61c84e77bb0","60b26b19ad64d61c84e77bb1"];
        if (scanData.code.contains("PathPartoutLesBoss:Unlock:"  )){
          if (availableArchivements.contains(scanData.code.split(":")[2]))
            AchievementUnlocked.unlockAchivement(scanData.code.split(":")[2]);
          Navigator.pushNamed(context, core, arguments: { "selectedIndex": 1, "randosCollection": currentConfig.getCurrentRandoList()});
          dispose();
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

