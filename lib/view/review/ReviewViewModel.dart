import 'package:mvvm_flutter_app/classes/review.dart';
import 'package:stacked/stacked.dart';
import 'package:mvvm_flutter_app/main.dart';

class ReviewViewModel extends BaseViewModel {
  String header = "Qu'avez-vous pensé de cette randonnée ?";
  String heading = "N’hésitez pas à laisser un avis afin de décrire votre expérience.";

  store(review){
    String avis = review['avis'];
    double note = review['note'];
    int randonneeId = currentConfig.currentRando.id;
    String userId = currentConfig.currentUser.id;
    String imageUrl = review['imageUrl'];

    Review.createReview(avis, randonneeId, userId, note, imageUrl: imageUrl);
  }
}