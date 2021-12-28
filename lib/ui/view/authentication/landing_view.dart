import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:fresh9_rider/ui/widget/button.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LandingView extends StatefulWidget {
  _LandingViewState createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  final NavigationService _navigationService = locator<NavigationService>();

  bool isLoading = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<Null> handleGoogleSignIn() async {
    this.setState(() {
      isLoading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      User firebaseUser =
          (await firebaseAuth.signInWithCredential(credential)).user;

      if (firebaseUser != null) {
        _navigationService.navigateToAndBack(NavigationRouter.enterNumberScreen,
            arguments: {
              "name": firebaseUser.displayName,
              "email": firebaseUser.email
            });

        // Check is already sign up
//        final QuerySnapshot result = await FirebaseFirestore.instance
//            .collection('users')
//            .where('id', isEqualTo: firebaseUser.uid)
//            .get();
//        final List<DocumentSnapshot> documents = result.docs;
//        if (documents.length == 0) {
//          // Update data to server if new user
//          FirebaseFirestore.instance
//              .collection('users')
//              .doc(firebaseUser.uid)
//              .set({
//            'nickname': firebaseUser.displayName,
//            'photoUrl': firebaseUser.photoURL,
//            'id': firebaseUser.uid,
//            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
//            'chattingWith': null
//          });
//
//          // Write data to local
//          currentUser = firebaseUser;
//          await prefs?.setString('id', currentUser.uid);
//          await prefs?.setString('nickname', currentUser.displayName ?? "");
//          await prefs?.setString('photoUrl', currentUser.photoURL ?? "");
//        } else {
//          DocumentSnapshot documentSnapshot = documents[0];
//          UserChat userChat = UserChat.fromDocument(documentSnapshot);
//          // Write data to local
//          await prefs?.setString('id', userChat.id);
//          await prefs?.setString('nickname', userChat.nickname);
//          await prefs?.setString('photoUrl', userChat.photoUrl);
//          await prefs?.setString('aboutMe', userChat.aboutMe);
//        }
//        Fluttertoast.showToast(msg: "Sign in success");
//        this.setState(() {
//          isLoading = false;
//        });
//
//        Navigator.push(
//            context,
//            MaterialPageRoute(
//                builder: (context) =>
//                    HomeScreen(currentUserId: firebaseUser.uid)));
      } else {
        Fluttertoast.showToast(msg: "Sign in fail");
        this.setState(() {
          isLoading = false;
        });
      }
    } else {
      Fluttertoast.showToast(msg: "Can not init google sign in");
      this.setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            VerticalSpacing(
              height: 0.09,
            ),
            _logo(),
            VerticalSpacing(
              height: 0.03,
            ),
            Text(
              'Sign up with',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            VerticalSpacing(
              height: 0.03,
            ),
            _socialMediaButtons(),
            VerticalSpacing(
              height: 0.02,
            ),
            Center(
              child: Text(
                'or',
                style: TextStyle(color: Colors.grey, fontSize: FontSize.xxl),
              ),
            ),
            VerticalSpacing(
              height: 0.02,
            ),
            _signUp(),
            VerticalSpacing(
              height: 0.07,
            ),
            _skipButton(),
            VerticalSpacing(
              height: 0.02,
            ),
            _image()
          ],
        ),
      ),
    );
  }

  _image() {
    return Center(
      child: Image.asset(
        'assets/image/store.png',
        height: 200,
      ),
    );
  }

  _logo() {
    return Image.asset(
      'assets/image/logo.png',
      height: 100,
    );
  }

  _signUp() {
    return MyButton(
      text: 'SIGNIN / SIGNUP',

      width: MediaQuery.of(context).size.width * 0.85,
      onPressed: () => _navigationService
          .navigateToAndBack(NavigationRouter.enterNumberScreen),
//      onPressed: () =>_navigationService.navigateTo(NavigationRouter.enterNumberScreen),
    );
  }

  _skipButton() {
//    return ButtonTheme(
//        minWidth: MediaQuery.of(context).size.shortestSide * 0.33,
//        child: OutlinedButton(
//style: ButtonStyle(
//    borderRadius: BorderRadius.only(
//        topLeft: Radius.circular(15),
//        topRight: Radius.circular(15),
//        bottomLeft: Radius.circular(10),
//        bottomRight: Radius.circular(10)
//    ),
//    : [
//
//      BoxShadow(
//        color: Colors.grey[300].withOpacity(0.5),
//        spreadRadius: 1,
//        blurRadius: 3,
//        offset: Offset(0, -2), // changes position of shadow
//      ),
//    ]
//),
////          shape: new RoundedRectangleBorder(
////              borderRadius: new BorderRadius.circular(30.0)),
//          onPressed: ()=>_navigationService.navigateTo(NavigationRouter.signUpScreen),
//          child: Text(
//            'Skip',
//            style: TextStyle(
//                color: AppColor.primaryColor,
//                fontSize: FontSize.xl,
//                fontWeight: FontWeight.w400),
//          ),
//        ));

    return MyButton(
      text: 'SKIP',
      height: 30,
      width: MediaQuery.of(context).size.width * 0.3,

      onPressed: () =>
          _navigationService.navigateTo(NavigationRouter.appServices),
//      onPressed: () =>_navigationService.navigateTo(NavigationRouter.enterNumberScreen),
    );
  }

  _socialMediaButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialMediaButton(
          onPressed: () {
            handleGoogleSignIn();
          },
          text: "Google",
          image: 'assets/image/google_logo.png',
          width: MediaQuery.of(context).size.shortestSide * 0.4,
        ),
        SizedBox(
          width: 20,
        ),
        SocialMediaButton(
          onPressed: () => _navigationService
              .navigateToAndBack(NavigationRouter.enterNumberScreen),
          text: "Facebook",
          image: 'assets/image/fb_logo.png',
          width: MediaQuery.of(context).size.shortestSide * 0.4,
        ),
      ],
    );
  }
}
