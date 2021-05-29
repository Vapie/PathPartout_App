import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mvvm_flutter_app/main.dart';


class MqttBaliseMessage{
  double Lat;
  double Lng;
  String baliseName;

  MqttBaliseMessage(this.Lat,this.Lng,this.baliseName);



  static MqttBaliseMessage fromString(String str) {
    List<String> paramsarray  =  str.replaceAll(",", ":").split(":");
    return MqttBaliseMessage(
        double.parse(paramsarray[1]),double.parse(paramsarray[3]),paramsarray.last
    );

  }
}

class MqttConsumer {

  mqttSubscribe() async{
  final client = MqttServerClient('test.mosquitto.org', '');
  client.logging(on: true);
  client.keepAlivePeriod = 20;
  client.onDisconnected = onDisconnected;
  client.onSubscribed = onSubscribed;
  final connMess = MqttConnectMessage()
      .withClientIdentifier('PathPartout_Consumer')
      .startClean() // Non persistent session for testing
      .withWillQos(MqttQos.atLeastOnce);
  client.connectionMessage = connMess;

  try {
  await client.connect();

  } on Exception catch (e) {
  print('EXAMPLE::client exception - $e');
  client.disconnect();
  exit(-1);
  }

  /// Check we are connected
  if (client.connectionStatus.state == MqttConnectionState.connected) {
  } else {
  client.disconnect();
  exit(-1);
  }


  const topic1 = 'Pathpartout';
  client.subscribe(topic1, MqttQos.atLeastOnce);
  
  MqttBaliseMessage baliseToRemove;
  // ignore: avoid_annotating_with_dynamic
  client.updates.listen((dynamic c) {
    final MqttPublishMessage recMess = c[0].payload;
    final pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    MqttBaliseMessage  myBalise=  MqttBaliseMessage.fromString(pt);
    for (MqttBaliseMessage balise in currentConfig.currentBaliseList){
     if (myBalise.baliseName == balise.baliseName) {
       baliseToRemove =  balise;
     }
    }
    if (baliseToRemove!=null)
      currentConfig.currentBaliseList.remove(baliseToRemove);
    currentConfig.currentBaliseList.add(myBalise);
    print(currentConfig.currentBaliseList);
    });
  }
  /// The subscribed callback
  void onSubscribed(String topic) {
  print('EXAMPLE::Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print("restarted Mqtt");
    //new Future.delayed(const Duration(milliseconds: 2000), mqttSubscribe());
  }
}