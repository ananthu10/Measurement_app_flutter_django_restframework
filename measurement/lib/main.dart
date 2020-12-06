import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:mime_type/mime_type.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:mime_type/mime_type.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  // Uri apiUrl = Uri.parse('http://127.0.0.1:8000/file/upload/');
  //
  // Future<Map<String, dynamic>> _uploadImage(File image) async {
  //
  //   //
  //   var mimeTypeData = mime(image.path);
  //   //mime(image.path, headerBytes: [0xFF, 0xD8]).split('/');
  //
  //   // Intilize the multipart request
  //   final imageUploadRequest = http.MultipartRequest('POST', apiUrl);
  //
  //   // Attach the file in the request
  //   final file = await http.MultipartFile.fromPath('file1', image.path,
  //       contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
  //
  //   imageUploadRequest.files.add(file);
  //   imageUploadRequest.fields['width'] = _width;
  //   // imageUploadRequest.fields['email'] = _email;
  //   // imageUploadRequest.fields['contact_no'] = _contact;
  //
  //   try {
  //     final streamedResponse = await imageUploadRequest.send();
  //     final response = await http.Response.fromStream(streamedResponse);
  //     if (response.statusCode != 200) {
  //       return null;
  //     }
  //     final Map<String, dynamic> responseData = json.decode(response.body);
  //     _resetState();
  //     return responseData;
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }
  //
  // void _resetState() {
  //   setState(() {
  //     _file1 = null;
  //     _width = null;
  //   });
  // }

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _width;
  Uri apiUrl = Uri.parse('http://127.0.0.1:8000/file/upload/');

  Future<Map<String, dynamic>> _uploadImage(File image) async {
    // Future uploadImage(File image) async {
    // setState(() {
    //   // pr.show();
    // });
    //
    var mimeTypeData = mime(image.path);

    final imageUploadRequest = http.MultipartRequest('POST', apiUrl);

    final file = await http.MultipartFile.fromPath('file1', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    imageUploadRequest.files.add(file);

    imageUploadRequest.fields['width'] = _width;

    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        return null;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      _resetState();
      return responseData;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void _resetState() {
    setState(() {
      _file1 = null;
      _width = null;
    });
  }

  File _file1;

  String img =
      'https://git.unilim.fr/assets/no_group_avatar-4a9d347a20d783caee8aaed4a37a65930cb8db965f61f3b72a2e954a0eaeb8ba.png';
  var width = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('measurement'),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
              right: 10,
              left: 10,
              top: 10,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    'measurement',
                    style: Theme.of(context).textTheme.title,
                  ),
                  //======================================================================================== Circle Avatar
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            InkWell(
                              onTap: _onAlertPress,
                              // onTap: () {
                              //   print("on al press executed ");
                              // },

                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40.0),
                                      color: Colors.black),
                                  margin: EdgeInsets.only(left: 70, top: 70),
                                  child: Icon(
                                    Icons.photo_camera,
                                    size: 25,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                        Text('Half Body',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
//=========================================================================================== Form
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 100),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: width,
                            onChanged: ((String width) {
                              setState(() {
                                _width = width;
                                print(_width);
                              });
                            }),
                            decoration: InputDecoration(
                              labelText: "WIDTH",
                              labelStyle: TextStyle(
                                color: Colors.black87,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a value';
                              }
                              return null;
                            },
                          ),
                          Center(
                            child: Container(
                              width: 300,
                              margin: EdgeInsets.only(top: 50),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.blue),
                              child: FlatButton(
                                  child: FittedBox(
                                      child: Text(
                                    'Save',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                    textAlign: TextAlign.center,
                                  )),
                                  onPressed: () async {
                                    // if (_formKey.currentState.validate()) {

                                    _uploadImage(_file1);
                                    //
                                    // print("on start upload ");
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
//============================================================================================================= Form Finished
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onAlertPress() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/gallery.png',
                      width: 50,
                    ),
                    Text('Gallery'),
                  ],
                ),
                onPressed: getGalleryImage,
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/take_picture.png',
                      width: 50,
                    ),
                    Text('Take Photo'),
                  ],
                ),
                onPressed: getCameraImage,
              ),
            ],
          );
        });
  }

  Future getCameraImage() async {
    final picker = ImagePicker();
    var image = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _file1 = File(image.path);
      Navigator.pop(context);
    });
  }

  Future getGalleryImage() async {
    final picker = ImagePicker();
    var image = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _file1 = File(image.path);
      Navigator.pop(context);
    });
  }

  messageAllert(String msg, String ttl) {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: Text(ttl),
            content: Text(msg),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Text('Okay'),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
