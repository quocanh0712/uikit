import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 120,
              decoration: const BoxDecoration(
                color: Colors.black87,
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.white),
                ),
              ),
              padding: const EdgeInsets.only(top: 60, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                Navigator.pop(context); 
              },
                    child: const SizedBox(
                      width: 50, // Kích thước chiều ngang
                      height: 50, // Kích thước chiều cao
                      child: Icon(
                        Icons.dangerous_rounded,
                        color: Colors.white,
                        size: 35, // Màu sắc biểu tượng
                      ),
                    ),
                  ),
      
                  const Text(
                    'Create welcome form',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  //Expanded(child: Container()),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 50, // Kích thước chiều ngang
                    height: 50, // Kích thước chiều cao
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 35, // Màu sắc biểu tượng
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  color: Colors.black87,
                  height: 380,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25, left: 15),
                  height: 300,
                  width: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black45,
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: const Text(
                      'Write code(HTML,CSS and JS) for a simple welcome page and form with 3 input fields anda dropdown with 2 buttons , cancel and send, then run test with my Codepen project',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 9,
                  left: 8,
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Just now',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          )),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Edit',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          )),
                    ],
                  ),
                )
              ],
            ),
            Stack(
              children: [
                Container(
                  height: 352,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black87,
                ),
                Positioned(
                  bottom: 35,
                  left: 16,
                  child: Container(
                    height: 70,
                    width: 360,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black87,
                        border:
                            Border.all(width: 0.5, color: Colors.grey.shade400)),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add_circle_rounded,
                              color: Colors.white,
                              size: 30,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 1, left: 5),
                          child: SizedBox(
                            height: 50,
                            width: 250,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Ask anything',
                                hintStyle: const TextStyle(
                                  color: Colors.grey, // Màu sắc của hintText
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.voice_chat,
                              color: Colors.white,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
