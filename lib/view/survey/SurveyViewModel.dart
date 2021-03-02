import 'package:mvvm_flutter_app/classes/user.dart';
import 'package:stacked/stacked.dart';

class SurveyViewModel extends BaseViewModel {
  String header = 'Bienvenue sur Path Partout, votre nouveau guide personnalisé !';
  String heading = "pour l'instant cette fonctionalité n'est pas active, merci de cliquer sur passer cette étape";
  // String heading = 'Afin de vous proposer les randonneées qui vous correspondent le mieux, nous vous proposons un petit quizz.';
  String surveyStart = 'Je suis...';
  String survey1 = 'un(e) grand(e) randonneur(euse)';
  String survey2 = 'randonneur(euse) occasionnel(le)';
  String survey3 = 'randonneur(euse) débutant';
  String btnSkip = 'Passer cette étape';

  debug() {
    User.debuguserfetch();
  }
}
