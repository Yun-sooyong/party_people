import 'package:flutter/material.dart';

class PartyLight extends StatefulWidget {
  const PartyLight({Key? key}) : super(key: key);

  @override
  State<PartyLight> createState() => _PartyLightState();
}

class _PartyLightState extends State<PartyLight> {
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Party light'),
      ),
    );
  }
}
