import 'dart:io';
import 'dart:typed_data';
// import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateQRCode extends StatefulWidget {
  CreateQRCode({Key key}) : super(key: key);

  @override
  _CreateQRCodeState createState() => _CreateQRCodeState();
}

class _CreateQRCodeState extends State<CreateQRCode> {
  final controller = TextEditingController();

  File _imageFile;

  //Untuk ss
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Membuat QR Code'),
          shadowColor: Colors.indigoAccent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.indigo, Colors.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Screenshot(
                      controller: screenshotController,
                      child: BarcodeWidget(
                        barcode: Barcode.qrCode(),
                        backgroundColor: Theme.of(context).primaryColor,
                        color: Colors.white,
                        data: controller.text ?? 'Hello',
                        width: 200,
                        height: 200,
                      )),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(child: buildTextField(context)),
                      const SizedBox(width: 12),
                      FloatingActionButton(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(Icons.done, size: 30),
                        onPressed: () => setState(() {
                          Flushbar(
                            title: "Sukses",
                            message: "Berhasil Generate Barcode",
                            margin: EdgeInsets.all(8),
                            borderRadius: BorderRadius.circular(8),
                            flushbarPosition: FlushbarPosition.TOP,
                            icon: Icon(
                              FontAwesomeIcons.check,
                              color: Colors.greenAccent,
                            ),
                            backgroundGradient: LinearGradient(
                                colors: [Colors.indigo, Colors.red]),
                            backgroundColor: Colors.cyan,
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
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: Icon(
                      FontAwesomeIcons.solidShareSquare,
                      color: Colors.white,
                      size: 25.0,
                    ),
                    label: Text('Share Screenshot',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center),
                    onPressed: () {
                      _takeScreenshotandShare();
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
        ),
      ),
    );
  }

  Widget buildTextField(BuildContext context) => TextField(
        controller: controller,
        style: TextStyle(
          color: Colors.blueGrey[900],
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          hintText: 'Masukkan Data',
          hintStyle: TextStyle(color: Colors.blueGrey[900]),
          contentPadding: EdgeInsets.all(15.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.blueGrey[900]),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      );

  _takeScreenshotandShare() async {
    _imageFile = null;
    screenshotController
        .capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0)
        .then((File image) async {
      setState(() {
        _imageFile = image;
      });
      final directory = (await getApplicationDocumentsDirectory()).path;
      Uint8List pngBytes = _imageFile.readAsBytesSync();
      File imgFile = new File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
      print("Sukses Simpan File");
      await Share.shareFiles(['$directory/screenshot.png'],
          text: 'Barcode : Tommy Ryan Dwiputra');
    }).catchError((onError) {
      print(onError);
    });
  }
}
