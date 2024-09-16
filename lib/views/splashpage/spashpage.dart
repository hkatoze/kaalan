import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/views/loginpage/loginpage.dart';
import 'package:page_transition/page_transition.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftJoined,
            duration: const Duration(milliseconds: 300),
            childCurrent: const Onboarding(),
            reverseDuration: const Duration(milliseconds: 300),
            child: Loginpage(),));
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/images/full.jpeg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double height = 200]) {
    return Image.asset('assets/images/$assetName', height: height);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0, fontFamily: "Nominee");

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28.0, fontWeight: FontWeight.w700, fontFamily: "Nominee"),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 7000,
      animationDuration: 1000,
      infiniteAutoScroll: true,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: _buildImage('k.png', 100),
          ),
        ),
      ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: ksecondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const Text(
            'Commencer maintenant!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Bienvenue sur Kaalan",
          body:
              "Plongez dans l'univers infini de la connaissance avec Kaalan. Notre application vous ouvre les portes d'une bibliothèque numérique riche et diversifiée, prête à élargir vos horizons.\n",
          image: _buildFullscreenImage(),
          decoration: PageDecoration(
              contentMargin: const EdgeInsets.symmetric(horizontal: 16),
              titleTextStyle:
                  TextStyle(fontFamily: "Nominee", fontWeight: FontWeight.bold),
              bodyTextStyle: TextStyle(fontFamily: "Nominee"),
              fullScreen: true,
              bodyFlex: 2,
              imageFlex: 3,
              safeArea: 100,
              pageColor: Colors.white.withOpacity(0.8)),
        ),
        PageViewModel(
          title: "Explorez des Mondes Inédits",
          body:
              "Découvrez des trésors littéraires du monde entier. De la fiction à la non-fiction.",
          image: _buildImage('im1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Vivez l'Expérience Immersive",
          body:
              "Plongez au cœur de chaque histoire avec notre mode de lecture immersif. Oubliez le monde extérieur et laissez-vous emporter par la magie des mots.",
          image: _buildImage('im4.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Suivez vos Passions",
          body:
              "Que vous soyez un passionné de science-fiction, un amateur d'histoire ou un mordu de romance, Kaalan suit vos passions.",
          image: _buildImage('im3.png'),
          decoration: pageDecoration.copyWith(
            bodyFlex: 6,
            imageFlex: 6,
            safeArea: 80,
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: Text('Passer',
          style:
              TextStyle(fontWeight: FontWeight.w600, color: ksecondaryColor)),
      next: Icon(
        Icons.arrow_forward,
        color: ksecondaryColor,
      ),
      done: Text('Terminer',
          style:
              TextStyle(fontWeight: FontWeight.w600, color: ksecondaryColor)),
      curve: Curves.easeInOut,
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
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
