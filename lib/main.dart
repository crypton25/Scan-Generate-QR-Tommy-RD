import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scan_and_generate_qr_code/pages/create_qr_code.dart';
import 'package:scan_and_generate_qr_code/pages/profile.dart';
import 'package:scan_and_generate_qr_code/pages/scan_qr_code.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scan & Create QR Code',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.indigo[50],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Scan & Generate QR Code'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Scan & Generate QR Code'),
            content: Text('Apakah kamu yakin akan keluar dari aplikasi?'),
            actions: <Widget>[
              TextButton(
                  child: Text('Tidak'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  }),
              TextButton(
                  child: Text('Ya'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          title: Text(widget.title),
          shadowColor: Colors.indigoAccent,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.indigo, Colors.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.userGraduate,
              size: 30,
              color: Color(0xFFf5f6fa),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ProfileTommy()));
            },
          ),
        ),
        body: WillPopScope(
          onWillPop: _onBackPressed,
          child: Container(
            margin: EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildImage(),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => ScanQRCode()));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        onPrimary: Colors.white,
                        shadowColor: Colors.red,
                        elevation: 5,
                        padding: const EdgeInsets.all(0.0),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF311B92),
                              Color(0xFF5E35B1),
                              Color(0xFFD32F2F),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: const Text(' Scan QR Code ',
                            style: TextStyle(fontSize: 20)),
                      )),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => CreateQRCode()));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        onPrimary: Colors.white,
                        shadowColor: Colors.red,
                        padding: const EdgeInsets.all(0.0),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF311B92),
                              Color(0xFF5E35B1),
                              Color(0xFFD32F2F),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: const Text('Membuat QR Code',
                            style: TextStyle(fontSize: 20)),
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}

Widget buildImage() => CircleAvatar(
      backgroundImage: AssetImage(
        "images/new.png",
      ),
      foregroundColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      radius: 150,
    );
