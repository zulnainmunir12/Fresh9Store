import 'package:Product/colors.dart';
import 'package:Product/splash.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _editingController = TextEditingController();
  final TextEditingController _textEditingController = TextEditingController();
  var cities = ['Lahore', 'Faisalabad', 'Sahiwal'];
  var area = ['Behria', 'Johar Town', 'Faroz Pur Road'];
  var location = ['Abc', 'Def', 'Hij'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Image.asset(
                  'logo.png',
                  height: 90,
                )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                      onPressed: () {},
                      child: Container(
                        width: 160,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey.shade200,
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
                            Image.asset('google_logo.png', height: 25),
                            Text(
                              'Google',
                              style: TextStyle(
                                  fontSize: 23,
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
                        width: 160,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey.shade200,
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
                            Image.asset('fb_logo.png', height: 25),
                            Text(
                              'Facebook',
                              style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Or',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: new BorderSide(color: Colors.white),
                          ),
                          hintText: 'Full Name',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          prefixIcon: const Icon(
                            Icons.account_circle_outlined,
                            color: AppColors.IconColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.5),
                                  width: 1),
                              borderRadius: BorderRadius.circular(25)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey.shade300),
                          ),
                        ),
                        cursorColor: AppColors.CursorColor,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20.0),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: new BorderSide(color: Colors.white),
                          ),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: AppColors.IconColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.5),
                                  width: 1),
                              borderRadius: BorderRadius.circular(25)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey.shade300),
                          ),
                        ),
                        cursorColor: AppColors.CursorColor,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'Add Your Address',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: new BorderSide(color: Colors.white),
                          ),
                          hintText: 'Choose your City',
                          prefixIcon: Icon(
                            Icons.apartment,
                            color: AppColors.IconColor,
                          ),
                          suffixIcon: PopupMenuButton<String>(
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.IconColor,
                            ),
                            onSelected: (String value) {
                              _controller.text = value;
                            },
                            itemBuilder: (BuildContext context) {
                              return cities
                                  .map<PopupMenuItem<String>>((String value) {
                                return new PopupMenuItem(
                                    child: new Text(value), value: value);
                              }).toList();
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.5),
                                  width: 1),
                              borderRadius: BorderRadius.circular(25)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey.shade300),
                          ),
                        ),
                        cursorColor: AppColors.CursorColor,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _editingController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: new BorderSide(color: Colors.white),
                          ),
                          hintText: 'Choose your Area',
                          prefixIcon: Icon(
                            Icons.home_sharp,
                            color: AppColors.IconColor,
                          ),
                          suffixIcon: PopupMenuButton<String>(
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.IconColor,
                            ),
                            onSelected: (String value) {
                              _editingController.text = value;
                            },
                            itemBuilder: (BuildContext context) {
                              return area
                                  .map<PopupMenuItem<String>>((String value) {
                                return new PopupMenuItem(
                                    child: new Text(value), value: value);
                              }).toList();
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.5),
                                  width: 1),
                              borderRadius: BorderRadius.circular(25)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey.shade300),
                          ),
                        ),
                        cursorColor: AppColors.CursorColor,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: new BorderSide(color: Colors.white),
                          ),
                          hintText: 'Location',
                          prefixIcon: Icon(
                            Icons.location_on_outlined,
                            color: AppColors.IconColor,
                          ),
                          suffixIcon: PopupMenuButton<String>(
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.IconColor,
                            ),
                            onSelected: (String value) {
                              _textEditingController.text = value;
                            },
                            itemBuilder: (BuildContext context) {
                              return location
                                  .map<PopupMenuItem<String>>((String value) {
                                return new PopupMenuItem(
                                    child: new Text(value), value: value);
                              }).toList();
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.5),
                                  width: 1),
                              borderRadius: BorderRadius.circular(25)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey.shade300),
                          ),
                        ),
                        cursorColor: AppColors.CursorColor,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20.0),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: new BorderSide(color: Colors.white),
                          ),
                          hintText: 'House # 528 Block A st 2',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.withOpacity(0.5)),
                          prefixIcon: const Icon(
                            Icons.home,
                            color: AppColors.IconColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.5),
                                  width: 1),
                              borderRadius: BorderRadius.circular(25)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey.shade300),
                          ),
                        ),
                        cursorColor: AppColors.CursorColor,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20.0),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: new BorderSide(color: Colors.white),
                          ),
                          hintText: 'Address Instruction > Upper portion etc',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.withOpacity(0.5)),
                          prefixIcon: const Icon(
                            Icons.all_inbox_rounded,
                            color: AppColors.IconColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.5),
                                  width: 1),
                              borderRadius: BorderRadius.circular(25)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey.shade300),
                          ),
                        ),
                        cursorColor: AppColors.CursorColor,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton(
                        onPressed: () {},
                        child: Container(
                          width: 90,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: Colors.grey.shade200,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    // spreadRadius: 5,
                                    blurRadius: 3,
                                    offset: Offset(0, 4))
                              ]),
                          child: Center(
                            child: Text(
                              'Home',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: Container(
                          width: 90,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: Colors.grey.shade200,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    // spreadRadius: 5,
                                    blurRadius: 3,
                                    offset: Offset(0, 4))
                              ]),
                          child: Center(
                            child: Text(
                              'Work',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: Container(
                          width: 90,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: Colors.grey.shade200,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    // spreadRadius: 5,
                                    blurRadius: 3,
                                    offset: Offset(0, 4))
                              ]),
                          child: Center(
                            child: Text(
                              'Other',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: FlatButton(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColors.IconColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                // spreadRadius: 5,
                                blurRadius: 3,
                                offset: Offset(0, 3))
                          ]),
                      child: Center(
                        child: Text(
                          'SignUp',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// String selectCity ='';
