import 'package:mvvm_flutter_app/main.dart';
import 'package:mvvm_flutter_app/network/api-connect.dart';

class Badge{
  String name = "Marcheur";
  String adj = "ordinaire";

  Badge(this.name,this.adj);

  String getTitre() {
    String title = this.name +" " + this.adj;
    return title;
  }
}
List<NameTitle> name = [
  NameTitle("Chèvre", false),
  NameTitle("Bourrin", false),
  NameTitle("Patron", false),
  NameTitle("Escargot", true),
  NameTitle("Hermite", false),
  NameTitle("Routard", true),
  NameTitle("Marcheur", true),
  NameTitle("Guerrier", true),
  NameTitle("Loup", true),
  NameTitle("Chamois", true),
  NameTitle("Samouraï", true),
  NameTitle("Moine", true),
  NameTitle("Guide", true),
  NameTitle("Légende", true),
  NameTitle("Druide", true)
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
  AdjectiveTitle("montagnard", true),
  AdjectiveTitle("des Alpes", true),
  AdjectiveTitle("sans pitié", false),
  AdjectiveTitle("au grand coeur", true),
  AdjectiveTitle("citadin", true),
  AdjectiveTitle("optimiste", false),
  AdjectiveTitle("ordinaire", true),
  AdjectiveTitle("solitaire", true),
  AdjectiveTitle("amical", true),
  AdjectiveTitle("herboriste", true),
  AdjectiveTitle("morfale", true),
  AdjectiveTitle("collectionneur", false),
  AdjectiveTitle("scientifique", true),
  AdjectiveTitle("voyageur", true),
  AdjectiveTitle("maître", false)
];

class AdjectiveTitle {
  String libAdjective;
  bool isUnlock;

  AdjectiveTitle(
    this.libAdjective,
    this.isUnlock
    );
}

