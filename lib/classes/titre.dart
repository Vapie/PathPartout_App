import 'package:mvvm_flutter_app/main.dart';
import 'package:mvvm_flutter_app/network/api-connect.dart';

class Badge{
  String name = "Marcheur";
  String adj = "ordinaire";
  Badge(
      this.name,
      this.adj);
}
List<NameTitle> name = [
  NameTitle("Chèvre", false),
  NameTitle("Bourrin", false),
  NameTitle("Patron", false),
  NameTitle("Demi-dieu", false),
  NameTitle("Escargot", true),
  NameTitle("Hermite", false),
  NameTitle("Routard", true),
  NameTitle("Marcheur", true),
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
  AdjectiveTitle("des montagnes", true),
  AdjectiveTitle("des Alpes", false),
  AdjectiveTitle("sans pitié", false),
  AdjectiveTitle("au grand coeur", true),
  AdjectiveTitle("citadin", false),
  AdjectiveTitle("optimiste", false),
  AdjectiveTitle("ordinaire", true),
];

class AdjectiveTitle {
  String libAdjective;
  bool isUnlock;

  AdjectiveTitle(
    this.libAdjective,
    this.isUnlock
    );
}

