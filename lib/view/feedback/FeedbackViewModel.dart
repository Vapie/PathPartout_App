
import 'package:stacked/stacked.dart';

class FeedbackViewModel extends BaseViewModel {
  String header = "Bravo ! Vous avez terminé votre randonnée.";
  String heading = "N’hésitez pas à nous dire ce que vous avez aimé dans cette randonnée pour affiner votre profil.";
  int status = 0;

  String question1 = "Quels mots caractérisent le mieux cette randonnée ?";

  String question2 = "Avez-vous trouvé la randonnée...";

  String answer1_2 = "facile, adaptée à mon niveau";
  String answer2_2 = "compliquée, je suis très fatigué";
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

  storeAnswers(answers){

  }
}

