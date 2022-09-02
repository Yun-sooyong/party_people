import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_people/dice.dart';
import 'package:party_people/party_light.dart';

import 'package:party_people/text_box.dart';
import 'package:party_people/wheel.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.black38,
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
            Text(
              'Party People',
              style: GoogleFonts.comfortaa(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.grey.shade300,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Box(
                      icon: Icons.light,
                      text: 'Light',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PartyLight(),
                          ),
                        );
                      },
                    ),
                    Box(
                      icon: Icons.square,
                      text: 'dice',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Dice(),
                          ),
                        );
                      },
                    ),
                    Box(
                      icon: Icons.circle,
                      text: 'roulette',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Wheel(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
