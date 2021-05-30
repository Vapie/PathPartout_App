import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/view/dashboard/DashboardView.dart';
import 'package:mvvm_flutter_app/view/onboarding/OnBoardingViewModel.dart';
import 'package:mvvm_flutter_app/view/survey/SurveyView.dart';
import 'package:mvvm_flutter_app/widget/media/loadimage.dart';
import 'package:stacked/stacked.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Widget _buildFullscrenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/picture/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Color(0xFFFFFFFF),
      imagePadding: EdgeInsets.zero,
    );

    return ViewModelBuilder<OnBoardingViewModel>.reactive(
      viewModelBuilder: () => OnBoardingViewModel(),
      onModelReady: (model) => {},
      builder: (context, model, child) => Scaffold(
        body: IntroductionScreen(
          key: introKey,
          globalBackgroundColor: Colors.white,

          pages: [
            PageViewModel(
              title: "Bienvenue dans PathPartout !",
              body:
                  "Êtes-vous prêt à débuter une toute nouvelle aventure Annécienne ? Laissez nous vous parler du fonctionnement de l'application.",
              image: _buildImage('logo.png', 100),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Faites le choix choix qui vous correspond.",
              body:
                  "L'application vous propose un vaste choix de randonnées aux alentours d'Annecy. Prenez le temps de consulter leur difficulté et leur durée avant de débuter votre balade !",
              image: LoadImage(
                  "http://pathpartoutapi.herokuapp.com/images/mock1.png"),
              decoration: pageDecoration.copyWith(
                  contentMargin: const EdgeInsets.symmetric(horizontal: 10),
                  imagePadding: const EdgeInsets.only(bottom: 50),
                  bodyFlex: 5,
                  imageFlex: 6,
                  titlePadding: const EdgeInsets.only(top: 100, bottom: 20)),
              reverse: true,
            ),
            PageViewModel(
              title: "Des données pertinentes et basées sur la communautée.",
              body:
                  "Préparez votre randonnée un maximum à l'aide de données techniques et géographiques. Grâce aux avis des randonneurs précédant votre venue, restez averti et soyez assuré du bon déroulement de votre sortie.\n\nPrêts ? Appuyez sur le bouton \"Let's go\" pour commencer.",
              image: LoadImage(
                  "http://pathpartoutapi.herokuapp.com/images/mock2.jpg"),
              decoration: pageDecoration.copyWith(
                  contentMargin: const EdgeInsets.symmetric(horizontal: 10),
                  imagePadding: const EdgeInsets.only(top: 50),
                  bodyFlex: 5,
                  imageFlex: 6,
                  titlePadding: const EdgeInsets.only(top: 50, bottom: 20)),
              reverse: false,
            ),
            PageViewModel(
              title: "L'application s'adapte à vous.",
              body:
                  "Le point fort de Pathpartout réside en sa capacité à vous conseiller. Grâce aux données collectées suite à vos aventures, nous vous aiguillons vers du contenu qui vous correspond !\n Vous venez de terminer une randonnée trop difficile pour vous ? L'application vous proposera des balades plus faciles !",
              image: LoadImage(
                  "http://pathpartoutapi.herokuapp.com/images/mock3.png"),
              decoration: pageDecoration.copyWith(
                  contentMargin: const EdgeInsets.symmetric(horizontal: 10),
                  imagePadding: const EdgeInsets.only(bottom: 50),
                  bodyFlex: 5,
                  imageFlex: 6,
                  titlePadding: const EdgeInsets.only(top: 100, bottom: 20)),
              reverse: true,
            ),
          ],
          onDone: () => () {
            print("yo");
            Navigator.pushNamed(context, survey);
          },
          //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
          showSkipButton: true,
          skipFlex: 0,
          nextFlex: 0,
          //rtl: true, // Display as right-to-left
          skip: const Text('Passer'),
          next: const Icon(Icons.arrow_forward),
          done: FlatButton(
            onPressed: () {
              print("ade");
              Navigator.pushNamed(context, survey);
            },
            child: Text(
              'Terminer',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.all(16),
          controlsPadding: kIsWeb
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Color(0xFFBDBDBD),
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          dotsContainerDecorator: const ShapeDecoration(
            /*color: Colors.black87,*/
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
      ),

      //onModelReady: (model) => model.debug(),
    );
  }
}
