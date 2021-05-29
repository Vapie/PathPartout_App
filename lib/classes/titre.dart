import 'package:mvvm_flutter_app/main.dart';
import 'package:mvvm_flutter_app/network/api-connect.dart';

List<NameTitle> name = [
  NameTitle("Chèvre", false),
  NameTitle("Bourrin", false),
  NameTitle("Patron", false),
  NameTitle("Demi-dieu", false),
  NameTitle("Escargot", false),
  NameTitle("Hermite", false),
  NameTitle("Marcheur", false),
];

class NameTitle {
  String libName;
  bool isUnlock;

  NameTitle(
    this.libName,
    this.isUnlock
    );
}

List<AdjectiveTitle> adjective = [
  AdjectiveTitle("des montagnes", false),
  AdjectiveTitle("des Alpes", false),
  AdjectiveTitle("sans pitié", false),
  AdjectiveTitle("au grand coeur", false),
  AdjectiveTitle("citadin", false),
  AdjectiveTitle("optimiste", false),
  AdjectiveTitle("ordinaire", false),
];

class AdjectiveTitle {
  String libAdjective;
  bool isUnlock;

  AdjectiveTitle(
    this.libAdjective,
    this.isUnlock
    );
}

