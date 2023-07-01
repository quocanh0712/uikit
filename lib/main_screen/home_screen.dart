import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import 'package:uikit/minor_screen/card_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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
  String lbChecInTime = '??:??';
  String lbChecOutTime = '??:??';

  bool isCheckedIn = false;
  @override
  Widget build(BuildContext context) {
    Color hexColor = HexColor('#151718');

    TabController tabController = TabController(length: 4, vsync: this);

    return Scaffold(
      backgroundColor: hexColor,
      body: Stack(children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                height: 245,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 22, top: 10),
                      child: Container(
                        height: 210,
                        width: 384,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(163, 0, 0, 0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        child: Column(
                          children: [
                            Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(163, 0, 0, 0),
                                  borderRadius: BorderRadius.only(
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
                                      width: 60, // Kích thước chiều ngang
                                      height: 60, // Kích thước chiều cao
                                      decoration: BoxDecoration(
                                        shape: BoxShape
                                            .circle, // Hình dạng hình tròn
                                        color: Colors.grey.shade800, // Màu sắc
                                      ),
                                      child: const Icon(
                                        Icons.menu,
                                        color:
                                            Colors.white, // Màu sắc biểu tượng
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size(120, 36),
                                          backgroundColor: Colors.red,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)))),
                                      onPressed: () {
                                        setState(() {
                                          isCheckedIn = !isCheckedIn;
                                          if (isCheckedIn) {
                                            checkInTime = DateFormat('HH:mm')
                                                .format(DateTime.now());
                                            lbChecInTime = checkInTime;
                                            lbCheckIn = 'Check-Out';
                                          } else {
                                            checkOutTime = DateFormat('HH:mm')
                                                .format(DateTime.now());
                                            lbChecOutTime = checkOutTime;
                                          }
                                        });
                                      },
                                      child: Text(lbCheckIn),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 130,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(163, 0, 0, 0),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  )),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 90,
                                          width: 172,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('GIỜ VÀO'),
                                              Text(
                                                lbChecInTime,
                                                style: GoogleFonts.roboto(
                                                  color: Colors.white,
                                                  fontSize: 40,
                                                ),
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
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('GIỜ RA'),
                                              Text(
                                                lbChecOutTime,
                                                style: GoogleFonts.roboto(
                                                  color: Colors.white,
                                                  fontSize: 40,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      DateFormat('dd-MM-yyyy')
                                          .format(DateTime.now()),
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: 20,
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
              TabBar(
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
                height: 200,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    ListView.builder(
                      itemCount: layout.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CardScreen(), // NewPage là trang mới cần chuyển đến
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 5, top: 10),
                            width: 170,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                /*  BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 40,
                                  offset: Offset(0,
                                      1), // Điều chỉnh tọa độ của bóng (độ dài và chiều cao)
                                ), */
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    width: 160,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'images/Uiimage/image$index.jpeg'),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 80,
                                  right: 0,
                                  child: Container(
                                    width: 160,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      color: Colors.grey.shade900,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 38),
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        labels[index],
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 53,
                                  left: 20,
                                  child: Stack(
                                    children: [
                                      ClipPath(
                                        clipper: HexagonClipper(),
                                        child: Container(
                                          width: 65,
                                          height: 65,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade900,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 5,
                                        left: 5,
                                        child: ClipPath(
                                          clipper: HexagonClipper(),
                                          child: Container(
                                            width:
                                                55, // Chiều rộng của hình lục giác
                                            height:
                                                55, // Chiều cao của hình lục giác

                                            child: Image(
                                              image: AssetImage(
                                                  'images/Uiimage/image$index.jpeg'),
                                              fit: BoxFit.cover,
                                            ), // Màu nền của hình lục giác
                                          ),
                                        ),
                                      ),

                                      /* Positioned(
                                        top: 4,
                                        left: 5,
                                        child: Transform(
                                          alignment: Alignment.center,
                                          transform:
                                              Matrix4.rotationZ(0 * 0.0174533),
                                          child: ClipPath(
                                            clipper: HexagonClipper(),
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              color: Colors.blue,
                                              child: Image(
                                                image: AssetImage(
                                                    'images/Uiimage/image$index.jpeg'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ), */
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const Text('1'),
                    const Text('1'),
                    const Text('1'),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 5, right: 7),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Favorites',
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'See all',
                              style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Colors.blue,
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
                        return Column(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 5, bottom: 10),
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'images/Uiimage/image$index.jpeg'),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15,
                                          bottom: 0,
                                        ),
                                        child: SizedBox(
                                          width: 340,
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
                                              Expanded(child: Container()),
                                              Text(
                                                '1m ago',
                                                style: GoogleFonts.roboto(
                                                    color: Colors.grey),
                                              ),
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
                            )
                          ],
                        );
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
            color: Colors.grey.shade800,
            height: 100,
            padding: const EdgeInsets.only(top: 40, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50, // Kích thước chiều ngang
                  height: 50, // Kích thước chiều cao
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // Hình dạng hình tròn
                    color: Colors.grey.shade800, // Màu sắc
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
