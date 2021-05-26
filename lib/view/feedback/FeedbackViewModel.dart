
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/classes/sorties.dart';
import 'package:mvvm_flutter_app/classes/user.dart';
import 'package:stacked/stacked.dart';

import '../../main.dart';

class FeedbackViewModel extends BaseViewModel {
  String header = "Bravo ! Vous avez terminé votre randonnée.";
  String heading = "N’hésitez pas à nous dire ce que vous avez aimé dans cette randonnée pour affiner votre profil.";
  int status = 0;

  String question1 = "Quels mots caractérisent le mieux cette randonnée ?";

  String question2 = "Avez-vous trouvé la randonnée...";

  String answer1_2 = "facile, adaptée à mon niveau";
  String answer2_2 = "trop facile, j'aimerais un peut plus de challenge";
  String answer3_2 = "difficile, ce n'était pas à mon niveau";

  String question3 = "Au niveau de la durée...";

  String answer1_3 = "agréable et comme il faut";
  String answer2_3 = "trop court...";
  String answer3_3 = "trop long";

  String question;
  String answer1;
  String answer2;
  String answer3;

  init(){
    this.question = this.question1;
    this.answer1 = "";
    this.answer2 = "";
    this.answer3 = "";
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

  storeAnswers(data) async {
    print(data);
    //level: from 0 to 6 0 = débutant , 6 = master of montagne
    //preferedTime en minute
    //tags , un tagbleau de tags
    //{Quels mots caractérisent le mieux cette randonnée ?: [dénivelé, calme], Avez-vous trouvé la randonnée...: facile, adaptée à mon niveau, Au niveau de la durée...: trop court...}
    List<dynamic> currentUserData = currentConfig.currentUser.userData;

    if (data != null) {

      //ici on personalise le profil de l'utilisateur en fonction de son retour

      //on récupère les infos du profil.

      double level = double.parse(currentUserData[0].toString());

      double duration =double.parse(currentUserData[1].toString());
      print("currentTags   " + currentUserData[2].toString());
      List<String> currentTags=[];
      if (currentUserData[2].toString().length>3){
          currentTags = currentUserData[2].toString().replaceAll("[", "").replaceAll("]", "").replaceAll(" ","").split(",");
        }
      print("currentTags" + currentTags.toString());
      List<Sortie> sorties =  await Sortie.getUserSorties();

      double weight = 0.2 + 0.8/(sorties.length+1);
      // si on à trouvé ça trop facile
      if  (data[question2] == answer2_2)
        level = level + abs(level - (double.parse(currentConfig.currentRando.difficulty.toString())))*weight;
      //si c'était trop dur
      else if  (data[question2] == answer3_2)
        level = level  - abs(level - double.parse(currentConfig.currentRando.difficulty.toString()))*weight;


      //si c'était trop long'
   if  (data[question3] == answer2_3)
            duration = duration - abs(duration - double.parse(currentConfig.currentRando.duration.toString()))*weight;
      //si c'était trop court
   else if  (data[question3] == answer3_3)
            duration = duration + abs(duration - double.parse(currentConfig.currentRando.duration.toString()))*weight;


   List<String> tags =  data[question1].substring(1, data[question1].toString().length - 1).split(",");

   for (String tag in tags){
     print("le tag "+tag + "  wat  "+ currentTags.toString());
     if (!currentTags.contains(tag.replaceAll(" ", ""))) {

          currentTags.add(tag);
      }
   }
      currentUserData = [level,duration,currentTags];
      //currentUserData = [level,duration,[]];

    }
    print("current user data before update base  " + currentUserData.toString());
    await User.modifyCurrentUserData(currentUserData.toString());
    currentConfig.currentUser.userData = currentUserData;
  }
}
double abs(double myDouble) {
  if (myDouble < 0)
      return  - myDouble;
  return myDouble;
}
