import 'package:Product/colors.dart';
import 'package:Product/suggest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  _SignIn createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 60,),
            Center(
              child: Column(
                children: [
                  Image.asset('logo.png',height: 140,),
                  SizedBox(height: 40,),
                  Text('Sign up with',style: TextStyle(color: Colors.grey,fontSize: 16),)
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(padding: EdgeInsets.all(35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(
                  onPressed: () {},
                  child: Container(
                    width: 145,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColors.ButtonColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              // spreadRadius: 5,
                              blurRadius: 3,
                              offset: Offset(0, 4))
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('google_logo.png', height: 23,),
                        Text(
                          'Google',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Container(
                    width: 145,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColors.ButtonColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              // spreadRadius: 5,
                              blurRadius: 3,
                              offset: Offset(0, 4))
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('fb_logo.png', height: 23),
                        Text(
                          'Facebook',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),),
            Center(child: Text('or',style: TextStyle(color: Colors.grey,fontSize: 23),),),
            Padding(
              padding: EdgeInsets.all(35),
              child: FlatButton(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  decoration: BoxDecoration(
                      color: AppColors.ButtonColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            // spreadRadius: 5,
                            blurRadius: 1,
                            offset: Offset(0, 5,),
                        )
                      ]),
                  child: Center(
                    child: Text(
                      'SignIn/SignUp',
                      style: TextStyle(color: AppColors.IconColor, fontSize: 22),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                },
              ),
            ),
            SizedBox(height: 20,),
            FlatButton(onPressed:  (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Suggest()));
            },
            child: Container(
              width: 140,
              height: 45,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1),
                blurRadius: 0.7,
                offset: Offset(0,0),spreadRadius: 1.7)
              ],
              color: Colors.white),
              child: Center(child: Text('Skip',style: TextStyle(color: AppColors.IconColor,
              fontSize: 18),)),
            ),),
            SizedBox(height: 15,),
            Center(child: Image.asset('store.png',height: 160,),)
          ],
        ),
      ),
    );
  }
}
