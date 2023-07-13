// ignore_for_file: depend_on_referenced_packages, annotate_overrides, avoid_print, unnecessary_null_comparison

import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:uikit/minor_screen/card_screen.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/*List<PostModel> postList = [];

  Future<List<PostModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://auth.gosucorp.vn/api/list-news'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  } */

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Color backgroundButton = HexColor('#FF1B59');
  Color buttonColor = HexColor('#ed9534');
  Color background = HexColor('#040609');
  Color appBarColor = HexColor('#292C35');
  Color appBarBackgroundColor = HexColor('#17181D');
  Color checkInColor = HexColor('#28272D');
  Color labelCheckinColor = HexColor('#37D362');
  Color labelCheckOutColor = HexColor('#0CCDCC');
  Color lbColor = HexColor('#292C35');
  final List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  final List<String> labels = [
    'HTML welcome from',
    'Chat with the smartest AI',
    'Python Machine learning',
    'SASS style',
    'Basic Javascript',
  ];

  final List<String> title = [
    'Education feedback',
    'Code generation',
    'Photo retouch',
    'Mark report',
    'Attendance report',
  ];

  final List<String> layout = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
  ];
  List<String> image = [
    'images/Uiimage/image0.jpeg',
    'images/Uiimage/image1.jpeg',
    'images/Uiimage/image2.jpeg',
    'images/Uiimage/image3.jpeg',
  ];
  String checkInTime = '';

  String checkOutTime = '';
  String lbCheckIn = 'Check-In';
  String lbCheckInTime = '??:??';
  String lbCheckOutTime = '??:??';

  bool isCheckedIn = false;

  var postList = [];

  void initState() {
    super.initState();
    getData();
    getAttendance();
    getFeatures();
  }

  void getData() async {
    try {
      var response = await Dio().get('https://auth.gosucorp.vn/api/list-news');
      if (response.statusCode == 200) {
        setState(() {
          postList = response.data["data"] as List;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void getAttendance() async {
    String? accessToken = await getAccessToken();

    try {
      final response = await http.get(
        Uri.parse('https://auth.gosucorp.vn/api/user'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['data']);
        var checkInDateTime = DateTime.parse(data['check_in']);
        var formattedTime = DateFormat('HH:mm').format(checkInDateTime);
        if (formattedTime != null) {
          setState(() {
            lbCheckInTime = formattedTime;
            lbCheckIn = 'Check-out';
          });
        } else {
          sendCheckIn();
        }

        // print('alo $checkInTime');
        // lbCheckInTime = checkInTime;
        print('Check-in thành công!');
      } else {
        print(response.statusCode.toString());
        print('Check-in thất bại!');
        print('fail');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<String?> getCheckIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String inTime = prefs.getString('check_in').toString();
    setState(() {
      lbCheckInTime = inTime;
    });
    return null;
  }

  Future<String?> getUserInfor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userInfor');
  }

  Future<String> getCheckInTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userInforString = prefs.getString('userInfor');
    if (userInforString != null) {
      Map<String, dynamic> userInfor = jsonDecode(userInforString);
      String? checkIn = userInfor['check_in'];
      if (checkIn != null) {
        DateTime checkInDateTime = DateTime.parse(checkIn);
        String checkInTime = DateFormat('HH:mm').format(checkInDateTime);

        lbCheckInTime = checkInTime;
        lbCheckIn = 'Check-Out';

        return lbCheckInTime;
      }
    }
    return '';
  }

  Future<String> getCheckOutTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userInforString = prefs.getString('userInfor');
    if (userInforString != null) {
      Map<String, dynamic> userInfor = jsonDecode(userInforString);
      String? checkOut = userInfor['check_out'];
      if (checkOut != null) {
        DateTime checkOutDateTime = DateTime.parse(checkOut);
        String checkOutTime = DateFormat('HH:mm').format(checkOutDateTime);
        lbCheckOutTime = checkOutTime;

        setState(() {
          checkInTime = checkOutTime;
        });
      }
    }
    return '';
  }

  void sendCheckIn() async {
    String? accessToken = await getAccessToken();

    try {
      final response = await http.get(
        Uri.parse('https://auth.gosucorp.vn/api/checkin'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['data']);
        var checkInDateTime = DateTime.parse(data['data']['check_in']);
        var formattedTime = DateFormat('HH:mm').format(checkInDateTime);
        if (formattedTime != null) {
          setState(() {
            lbCheckInTime = formattedTime;
            lbCheckIn = 'Check-out';
          });
        } else {
          lbCheckInTime;
        }

        var checkOutDateTime = DateTime.parse(data['data']['check_out']);
        var formattedTime2 = DateFormat('HH:mm').format(checkOutDateTime);
        if (formattedTime2 != null) {
          setState(() {
            lbCheckOutTime = formattedTime2;
          });
        } else {
          lbCheckOutTime;
        }

        // print('alo $checkInTime');
        // lbCheckInTime = checkInTime;
        print('Check-in thành công!');
      } else {
        print(response.statusCode.toString());
        print('Check-in thất bại!');
        print('fail');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void sendCheckOut() async {
    String? accessToken = await getAccessToken();

    try {
      final response = await http.get(
        Uri.parse('https://auth.gosucorp.vn/api/checkin'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['data']);
        var checkOutDateTime = DateTime.parse(data['data']['check_out']);
        var formattedTime2 = DateFormat('HH:mm').format(checkOutDateTime);
        if (formattedTime2 != null) {
          setState(() {
            lbCheckOutTime = formattedTime2;
          });
        } else {
          lbCheckOutTime;
        }

        print('Check-out thành công!');
      } else {
        print(response.statusCode.toString());
        print('Check-out thất bại!');
        print('fail');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  bool showWidget = false;
  void getFeatures() async {
    try {
      final response = await http
          .get(Uri.parse('https://auth.gosucorp.vn/api/list-features'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<dynamic> features = data['data'];

        // Assuming you want to check the status of a specific feature
        String featureName = 'news';
        var feature = features.firstWhere((f) => f['name'] == featureName,
            orElse: () => null);

        if (feature != null) {
          int status = feature['status'];
          setState(() {
            showWidget = status == 1;
            // Update the state of the widget based on the status
          });
        }
      } else {
        print('Lấy dữ liệu thất bại. Mã phản hồi: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this);

    return FutureBuilder(builder: (context, snapshot) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 130,
                ),
                showWidget
                    ? WelcomeLabel(background: background)
                    : Container(
                        height: 245,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: appBarColor,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 22, top: 10),
                              child: Container(
                                height: 210,
                                width: 384,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30)),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: appBarBackgroundColor,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 12,
                                          right: 12,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width:
                                                  60, // Kích thước chiều ngang
                                              height:
                                                  60, // Kích thước chiều cao
                                              decoration: const BoxDecoration(
                                                shape: BoxShape
                                                    .circle, // Hình dạng hình tròn
                                                color:
                                                    Colors.black45, // Màu sắc
                                              ),
                                              child: const Icon(
                                                Icons.add_alarm_sharp,
                                                color: Colors
                                                    .white, // Màu sắc biểu tượng
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  minimumSize: const Size(
                                                      120, 36),
                                                  backgroundColor: Colors.white,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          50)))),
                                              onPressed: () {
                                                setState(() {
                                                  isCheckedIn = !isCheckedIn;
                                                  if (isCheckedIn) {
                                                    sendCheckIn();

                                                    //lbCheckInTime = checkInTime;
                                                  } else {
                                                    sendCheckOut();
                                                  }
                                                });
                                              },
                                              child: Text(
                                                lbCheckIn,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 130,
                                      decoration: BoxDecoration(
                                          color: appBarBackgroundColor,
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(30),
                                          )),
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12, right: 12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: 90,
                                                  width: 172,
                                                  decoration: BoxDecoration(
                                                    color: buttonColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'GIỜ VÀO',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      Text(
                                                        lbCheckInTime,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 40,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 90,
                                                  width: 172,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text('GIỜ RA',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                      Text(
                                                        lbCheckOutTime,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 40,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Text(
                                              DateFormat('dd-MM-yyyy')
                                                  .format(DateTime.now()),
                                              style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                TabBar(
                  labelStyle: GoogleFonts.roboto(
                      fontSize: 15, fontWeight: FontWeight.bold),
                  controller: tabController,
                  isScrollable: true,
                  labelColor: Colors.white,
                  indicatorColor: Colors.transparent,
                  unselectedLabelColor: Colors.grey,
                  padding: const EdgeInsets.only(left: 0),
                  tabs: [
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: const Tab(
                        text: 'All types',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: const Tab(
                        text: 'Images',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: const Tab(
                        text: 'Videos',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: const Tab(
                        text: 'Content',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 300,
                  child: TabBarView(controller: tabController, children: [
                    ListView.builder(
                      itemCount: postList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CardScreen(
                                  linkUrl:
                                      postList[index]['link_news'].toString(),
                                ), // NewPage là trang mới cần chuyển đến
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 5),
                            child: Container(
                              margin: const EdgeInsets.only(right: 5, top: 10),
                              width: 230,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      width: 230,
                                      height: 120,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20)),
                                          border: Border.all(
                                            color: lbColor,
                                            width: 2.0,
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                              offset: Offset(0, 5),
                                              color: Colors.orange,
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                            ),
                                          ]),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        child: Image.network(
                                          postList[index]['image'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 120,
                                    right: 0,
                                    child: Container(
                                      width: 230,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20)),
                                          color: lbColor,
                                          boxShadow: const [
                                            BoxShadow(
                                              offset: Offset(0, 5),
                                              color: Colors.orange,
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                            ),
                                          ]),
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 55),
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 5),
                                        child: Text(
                                          postList[index]['title'].toString(),
                                          maxLines: 4,
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 89,
                                    left: 20,
                                    child: Stack(
                                      children: [
                                        ClipPath(
                                          clipper: HexagonClipper(),
                                          child: Container(
                                            width: 74,
                                            height: 74,
                                            decoration: BoxDecoration(
                                              color: lbColor,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 5,
                                          left: 4.5,
                                          child: ClipPath(
                                            clipper: HexagonClipper(),
                                            child: SizedBox(
                                              width:
                                                  65, // Chiều rộng của hình lục giác
                                              height:
                                                  65, // Chiều cao của hình lục giác

                                              child: Image.network(
                                                postList[index]['image'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const Text('1'),
                    const Text('1'),
                    const Text('1'),
                  ]),
                ),
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 15, right: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Favorites',
                              style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                'See all',
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: buttonColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,

                        // shrinkWrap: false,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10, left: 10, right: 10),
                            child: Container(
                              height: 90,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: lbColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        left: 15,
                                        bottom: 10,
                                      ),
                                      width: 55,
                                      height: 55,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'images/Uiimage/image$index.jpeg'),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 18),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 300,
                                          child: Row(
                                            //    mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(title[index],
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Description',
                                          style: GoogleFonts.roboto(
                                              color: Colors.grey),
                                        )
                                        //
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                          /*Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 30, left: 10),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 5, bottom: 15),
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'images/Uiimage/image$index.jpeg'),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 40, left: 10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15,
                                          bottom: 50,
                                        ),
                                        child: SizedBox(
                                          width: 300,
                                          child: Row(
                                            //    mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(title[index],
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),

                                      //
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );  */
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: appBarColor,
              height: 130,
              padding: const EdgeInsets.only(top: 60, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50, // Kích thước chiều ngang
                    height: 50, // Kích thước chiều cao
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Hình dạng hình tròn
                      color: buttonColor, // Màu sắc
                    ),
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white, // Màu sắc biểu tượng
                    ),
                  ),
                  //Expanded(child: Container()),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 50, // Kích thước chiều ngang
                    height: 50, // Kích thước chiều cao
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle, // Hình dạng hình tròn
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage('images/Uiimage/image0.jpeg'),
                          fit: BoxFit.fill), // Màu sắc
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      );
    }); //
  }
}

class WelcomeLabel extends StatelessWidget {
  const WelcomeLabel({
    Key? key,
    required this.background,
  }) : super(key: key);

  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      color: background,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            Text(
              'Hello \nDerek Doyle',
              style: GoogleFonts.roboto(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Expanded(child: Container()),
            const Padding(
              padding: EdgeInsets.only(top: 63),
              child: Icon(
                Icons.menu_open,
                size: 35,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

/* 
 SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      // shrinkWrap: false,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          isThreeLine: true,
                          // minVerticalPadding: 5,
                          leading: Container(
                            //margin: const EdgeInsets.only(right: 0),
                            width: 60,
                            height: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              image: DecorationImage(
                                  image: AssetImage(
                                      'images/Uiimage/image$index.jpeg'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Quocanh',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 15, left: 10),
                            child: const Text(
                              '123',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: const Text(
                              'Quocanh',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ) */

/* Row(
                                                children: [
                                                  Container(
                                                    width:
                                                        20, // Kích thước chiều ngang
                                                    height:
                                                        20, // Kích thước chiều cao
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape
                                                          .circle, // Hình dạng hình tròn

                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'images/Uiimage/image0.jpeg'),
                                                          fit: BoxFit
                                                              .fill), // Màu sắc
                                                    ),
                                                  ),
                                                ],
                                              ); */
class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    final double sideLength = size.width / 2;
    final double height = sqrt(3) * sideLength;

    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, height / 4);

    path.lineTo(size.width, 3 * height / 4);
    path.lineTo(size.width / 2, height);
    path.lineTo(0, 3 * height / 4);
    path.lineTo(0, height / 4);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class HexagonClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width * 0.25, 0);
    path.lineTo(size.width * 0.75, 0);
    path.lineTo(size.width, size.height * sqrt(3) / 4);
    path.lineTo(size.width * 0.75, size.height * sqrt(3) / 2);
    path.lineTo(size.width * 0.25, size.height * sqrt(3) / 2);
    path.lineTo(0, size.height * sqrt(3) / 4);
    path.lineTo(size.width * 0.25, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(HexagonClipper2 oldClipper) => false;
}

/* SizedBox(
                height: 300,
                child: FutureBuilder<PostModel>(builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: postList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CardScreen(
                                linkUrl:
                                    postList[index]['link_news'].toString(),
                              ), // NewPage là trang mới cần chuyển đến
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 5),
                          child: Container(
                            margin: const EdgeInsets.only(right: 5, top: 10),
                            width: 230,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    width: 230,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      child: Image.network(
                                        postList[index]['image'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 120,
                                  right: 0,
                                  child: Container(
                                    width: 230,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      color: lbColor,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 60),
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 5),
                                      child: Text(
                                        postList[index]['title'].toString(),
                                        maxLines: 4,
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 89,
                                  left: 20,
                                  child: Stack(
                                    children: [
                                      ClipPath(
                                        clipper: HexagonClipper(),
                                        child: Container(
                                          width: 74,
                                          height: 74,
                                          decoration: BoxDecoration(
                                            color: lbColor,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 5,
                                        left: 4.5,
                                        child: ClipPath(
                                          clipper: HexagonClipper(),
                                          child: Container(
                                            width:
                                                65, // Chiều rộng của hình lục giác
                                            height:
                                                65, // Chiều cao của hình lục giác

                                            child: Image.network(
                                              postList[index]['image'],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ), */
