// ignore_for_file: depend_on_referenced_packages, avoid_print, unused_import

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uikit/main_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var obscureText = true;
  TextEditingController userName = TextEditingController();
  TextEditingController userPass = TextEditingController();

  void saveDataToLocal(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', data['access_token']);
  }

  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

/*void saveUserInfor(String data1) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userInfor', data1);
} */

  void saveUserInfor(Map<String, dynamic> data1) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data1String = jsonEncode(data1);
    prefs.setString('userInfor', data1String);
  }

  void getUserInfor() async {
    String? accessToken = await getAccessToken();
    try {
      var responseCheckin = await get(
        Uri.parse('https://auth.gosucorp.vn/api/user'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (responseCheckin.statusCode == 200) {
        var data1 = jsonDecode(responseCheckin.body.toString());
        print(data1);

        saveUserInfor(data1);
        var checkInDateTime = DateTime.parse(data1['check_in']);
        var formattedTime = DateFormat('HH:mm').format(checkInDateTime);
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString('check_in', formattedTime != null ? formattedTime : '??:??');
      }
    } catch (e) {
      print(e);
    }
  }

  void login(String email, password) async {
    try {
      var response = await post(
        Uri.parse('https://auth.gosucorp.vn/api/app-login'),
        body: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print('account login successfully');

        saveDataToLocal(data);
        getUserInfor();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        showAlert();
        print('fail');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Color loginBackgroundColor = HexColor('#171D29');
    Color textFieldColor = HexColor('#2C313C');
    Color loginButtonColor = HexColor('#5570F2');
    return Scaffold(
      backgroundColor: loginBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Text(
              'Welcome Back!',
              style: GoogleFonts.roboto(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Please sign in to your account',
              style:
                  GoogleFonts.roboto(fontSize: 16, color: Colors.grey.shade500),
            ),
            const SizedBox(
              height: 100,
            ),
            Container(
              //email
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: textFieldColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 330,
                    child: TextField(
                      controller: userName,
                      style: const TextStyle(color: Colors.white),
                      textAlignVertical: TextAlignVertical.center,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10),
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle: GoogleFonts.roboto(color: Colors.grey),
                        suffixIcon: const Icon(
                          Icons.supervised_user_circle_sharp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              //password
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: textFieldColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 330,
                    child: TextField(
                      controller: userPass,
                      style: const TextStyle(color: Colors.white),
                      textAlignVertical: TextAlignVertical.center,
                      obscureText: obscureText,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10),
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: GoogleFonts.roboto(color: Colors.grey),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            child: obscureText
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Colors.black,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.black,
                                  )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 190,
            ),
            GestureDetector(
              onTap: () {
                login(userName.text.toString(), userPass.text.toString());
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: loginButtonColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign In',
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  showAlert() {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(8),
          height: 60,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.dangerous,
                color: Colors.white,
                size: 40,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Tài khoản hoặc mật khẩu không chính xác',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
              const Spacer()
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
