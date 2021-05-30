import 'package:flutter/cupertino.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/classes/user.dart';
import 'package:mvvm_flutter_app/main.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:stacked/stacked.dart';

class SurveyViewModel extends BaseViewModel {

  String header = 'Bienvenue sur Path Partout, votre nouveau guide personnalisé !';
  String heading = 'Afin de vous proposer les randonnées qui vous correspondent le mieux, nous vous proposons un petit quizz.';

  int status = 0;

  String question0 = 'Tags';
  String question1 = 'Je suis...';
  String answer1_1 = 'un(e) grand(e) randonneur(euse)';
  String answer2_1 = 'randonneur(euse) occasionnel(le)';
  String answer3_1 = 'randonneur(euse) débutant';

  String question2 = "D'une durée...";
  String answer1_2 = 'entre 1h et 3h';
  String answer2_2 = 'entre 3h et 5h';
  String answer3_2 = 'plus de 5h';



  String question;
  String answer1;
  String answer2;
  String answer3;

  String btnSkip = 'Passer cette étape';

  init() {
    this.question = this.question1;
  }

  changeQuestions() {
    this.status++;
    print(this.status);

    switch (this.status) {
      case 1:
        {
          this.question = this.question1;
        this.answer1 = this.answer1_1;
        this.answer2 = this.answer2_1;
        this.answer3 = this.answer3_1;

        }
        break;
      case 2:
        {
          this.question = this.question2;
          this.answer1 = this.answer1_2;
          this.answer2 = this.answer2_2;
          this.answer3 = this.answer3_2;
        }
        break;
    }
  }

  saveProfile(data) async {
    //level: from 0 to 6 0 = débutant , 6 = master of montagne
    //preferedTime en minute
    //tags , un tagbleau de tags

    List<dynamic> mapOfUserData = [3,180,["dénivlé","vue"]];


    if (data != null) {
      int level = 3;
      int duration = 120;
      if  (data[question1] == answer1_1)
        level = 5;
      else if  (data[question1] == answer2_1)
        level = 3;
      else if  (data[question1] == answer3_1)
        level = 0;

      if  (data[question2] == answer1_2)
        duration = 120;
      else if  (data[question2] == answer2_2)
        duration = 240;
      else if  (data[question2] == answer3_2)
        duration = 300;

      dynamic tags =  data[question0];

      mapOfUserData = [level,duration,tags];

    }
    await User.modifyCurrentUserData(mapOfUserData.toString());
    currentConfig.currentUser.userData = mapOfUserData;
  }

  navigate(context) async {
    print("gotocore");
    Navigator.pushNamed(context, core, arguments: { "selectedIndex": 0,"randosCollection": await currentConfig.getCurrentRandoList()});
  }
}
