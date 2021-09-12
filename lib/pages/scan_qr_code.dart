import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:clipboard/clipboard.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'package:another_flushbar/flushbar_helper.dart';
// import 'package:another_flushbar/flushbar_route.dart';

class ScanQRCode extends StatefulWidget {
  ScanQRCode({Key key}) : super(key: key);

  @override
  _ScanQRCodeState createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  String qrCode = 'Belum Ada Data';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Scan QR Code"),
          shadowColor: Colors.indigoAccent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.indigo, Colors.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          )),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                qrCode,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                  onTap: () {
                    FlutterClipboard.copy(qrCode);
                    Flushbar(
                      title: "Sukses",
                      message: "Berhasil Menyalin Teks",
                      margin: EdgeInsets.all(8),
                      borderRadius: BorderRadius.circular(8),
                      icon: Icon(
                        FontAwesomeIcons.copy,
                        color: Colors.greenAccent,
                      ),
                      backgroundGradient:
                          LinearGradient(colors: [Colors.indigo, Colors.red]),
                      backgroundColor: Colors.red,
                      boxShadows: [
                        BoxShadow(
                          color: Colors.indigo[800],
                          offset: Offset(0.0, 2.0),
                          blurRadius: 3.0,
                        )
                      ],
                      duration: Duration(
                        seconds: 2,
                      ),
                    )..show(context);
                  },
                  child: Icon(
                    FontAwesomeIcons.copy,
                    size: 40,
                    color: Color(0xFFc0392b),
                  )),
              SizedBox(
                height: 15,
              ),
              ElevatedButton.icon(
                icon: Icon(
                  FontAwesomeIcons.camera,
                  color: Colors.white,
                  size: 25.0,
                ),
                label: Text('Mulai Scan',
                    style: TextStyle(fontSize: 23),
                    textAlign: TextAlign.center),
                onPressed: () {
                  scanQrCode();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo,
                  onPrimary: Colors.white,
                  shadowColor: Colors.red,
                  padding: const EdgeInsets.all(10.0),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> scanQrCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
