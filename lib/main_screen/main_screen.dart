import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uikit/main_screen/favorite_screen.dart';
import 'package:uikit/main_screen/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var currentIndex = 0;
  final List<Widget> _tabs = [
    const HomeScreen(),
    const FavoriteScreen(),
    const Center(
      child: Text('Search'),
    ),
    const Center(
      child: Text('User'),
    ),
    const Center(
      child: Text('Add'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<String> icon = [
      'images/Uiimage/image0.jpeg',
      'images/Uiimage/image1.jpeg',
      'images/Uiimage/image2.jpeg',
      'images/Uiimage/image3.jpeg',
    ];
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: _tabs[currentIndex],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              //2
              color: Colors.black.withOpacity(0.7),
              height: 110,
              child: Container(
                margin: const EdgeInsets.all(20),
                height: screenWidth * .155,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.15),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(35),
                ),
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(
                      left: screenWidth * .050, bottom: screenWidth * .010),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                        HapticFeedback.lightImpact();
                      });
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Stack(
                      children: [
                        Positioned(
                          left: -10,
                          top: 10,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: SizedBox(
                              width: screenWidth * .1600,
                              child: Center(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  // curve: Curves.fastLinearToSlowEaseIn,
                                  clipBehavior: Clip.antiAlias,
                                  height: screenWidth * .11,
                                  width: screenWidth * .1100,
                                  decoration: BoxDecoration(
                                    color: index == currentIndex
                                        ? Colors.black
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(9),
                          margin: const EdgeInsets.only(right: 5),
                          width: screenWidth * .1600,
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            listOfIcons[index],
                            size: screenWidth * .065,
                            color: index == currentIndex
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ), //5
                ), //4
              ), //3
            ),
          )
        ],
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_sharp,
    Icons.file_copy,
    Icons.search,
    Icons.find_in_page_sharp,
    Icons.auto_awesome_mosaic_rounded,
  ];
}
