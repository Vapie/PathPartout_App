import 'package:mvvm_flutter_app/storage/secured-storage.dart';

class Token{
  var token = "D5rJacI7prvxSLmW4dfuCY8g1czx9YoK";
  var maptoken = 'pk.eyJ1IjoidmFwaWUiLCJhIjoiY2tpb3BqOWcyMWY2YjJ4cWpvZTd0d3I0cyJ9.MXKDNscpbGFVy1xy1Q6CFg';
  String getToken() {
    return this.token;
  }

  String getMapToken() {
    return this.maptoken;
  }

  safeStore() {
    var mystorage = new SecuredStorage();
    mystorage.storage.write(key: "apiToken", value: "D5rJacI7prvxSLmW4dfuCY8g1czx9YoK");
    mystorage.storage.write(key: "mapToken", value: "pk.eyJ1IjoidmFwaWUiLCJhIjoiY2tpb3BqOWcyMWY2YjJ4cWpvZTd0d3I0cyJ9.MXKDNscpbGFVy1xy1Q6CFg");


  }
}
