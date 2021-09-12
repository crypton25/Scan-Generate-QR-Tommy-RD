import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ProfileTommy extends StatefulWidget {
  @override
  _ProfileTommyState createState() => _ProfileTommyState();
}

class _ProfileTommyState extends State<ProfileTommy> {
  List skills = <String>[
    "Kelas TI 4A",
    "NIM 3201916005",
    "UAS",
    "Praktikum",
    "Pemrograman Mobile",
    "2021",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Profil Saya'),
        shadowColor: Colors.indigoAccent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.red],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildName(),
            buildAnimatedText(),
          ],
        )),
      ),
    ));
  }

  Widget buildName() => Text("Hai, Saya Tommy Ryan Dwiputra",
      style: TextStyle(fontSize: 28.00), textAlign: TextAlign.center);

  Widget buildAnimatedText() => AnimatedTextKit(
        animatedTexts: [
          for (var i = 0; i < skills.length; i++) buildText(i),
        ],
        repeatForever: true,
        pause: const Duration(milliseconds: 80),
        displayFullTextOnTap: true,
        stopPauseOnTap: true,
      );

  buildText(int index) {
    return TypewriterAnimatedText(
      skills[index],
      textStyle: const TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.indigo,
      ),
      speed: const Duration(milliseconds: 100),
    );
  }
}
