import 'package:flutter/cupertino.dart';
import 'package:mvvm_flutter_app/classes/user.dart';
import 'package:stacked/stacked.dart';

class SurveyViewModel extends BaseViewModel {

  String header = 'Bienvenue sur Path Partout, votre nouveau guide personnalisé !';
  String heading = 'Afin de vous proposer les randonnées qui vous correspondent le mieux, nous vous proposons un petit quizz.';

  int status = 0;

  String question1 = 'Je suis...';

  String answer1_1 = 'un(e) grand(e) randonneur(euse)';
  String answer2_1 = 'randonneur(euse) occasionnel(le)';
  String answer3_1 = 'randonneur(euse) débutant';

  String question2 = "D'une durée...";
  String answer1_2 = 'entre 1h et 3h';
  String answer2_2 = 'entre 3h et 5h';
  String answer3_2 = 'plus de 5h';

  String question3 = 'Je préfère...';
  String answer1_3 = 'bord du lac';
  String answer2_3 = 'dénivelé';
  String answer3_3 = 'jolie vue';

  String question;
  String answer1;
  String answer2;
  String answer3;

  String btnSkip = 'Passer cette étape';

  init() {
    this.question = this.question1;
    this.answer1 = this.answer1_1;
    this.answer2 = this.answer2_1;
    this.answer3 = this.answer3_1;
  }

  changeQuestions() {
    this.status++;
    print(this.status);

    switch (this.status) {
      case 1:
        {
          this.question = this.question2;
          this.answer1 = this.answer1_2;
          this.answer2 = this.answer2_2;
          this.answer3 = this.answer3_2;
        }
        break;
      case 2:
        {
          this.question = this.question3;
          this.answer1 = this.answer1_3;
          this.answer2 = this.answer2_3;
          this.answer3 = this.answer3_3;
        }
        break;
    }
  }

  storeAnswers(answers) {
    print('store Answers');
    print(answers);


  }

  debug() {
    // User.debuguserfetch();
  }
}
