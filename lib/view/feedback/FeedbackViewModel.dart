
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
      int level = currentUserData[0];
      int duration = currentUserData[1];
      List<String> currentTags =currentUserData[2];
      if  (data[question2] == answer2_2)
        level = (currentConfig.currentRando.difficulty+1);
      else if  (data[question2] == answer3_2)
        level = (currentConfig.currentRando.difficulty-1);

   if  (data[question3] == answer2_3)
            duration = currentConfig.currentRando.duration - 30;
      else if  (data[question3] == answer3_3)
     duration = currentConfig.currentRando.duration + 30;

      dynamic tags =  data[question1];

      for (String tag in tags){
        if (!currentTags.contains(tag)) {
            currentTags.add(tag);
        }
      }
      currentUserData = [level,duration,tags];

    }
    await User.modifyCurrentUserData(currentUserData.toString());
    currentConfig.currentUser.userData = currentUserData;
  }
}

