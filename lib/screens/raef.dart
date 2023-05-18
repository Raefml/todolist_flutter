import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class Album {
  final int id;
  final String title;

  const Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}
class _HomeState extends State<Home> {

  XFile? image;


  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img ;
    });
  }

  Future<Album> createAlbum(String title) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/predic'),

      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Future<void> sendImage() async {
    // Définissez l'URL de l'API cible
    String url = 'http://127.0.0.1:5000/predic';
    print('Image iiiiiiiiiii');
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['hello'] = 'Bonjour monde';

    // Envoyez la requête et obtenez la réponse
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Image envoyée avec succès');
    } else {
      print('Erreur lors de l\'envoi de l\'image');
    }
  }



  Future<void> postImage(XFile image) async {
    print('mmmmmmmmmmmmmmmmmm');
    final url = 'http://127.0.0.1:5000/predic';

    // Read the file into memory


    // Make the POST request
    final response =await http.post(
        Uri.parse('http://127.0.0.1:5000/predic'), body: {'imageFile': image});

    // Check the response status code
    if (response.statusCode == 200) {
      print('Image posted successfully!');
      print('iiiii');
    } else {
      print('Failed to post image. Error: ${response.body}');
      print('oooo');
    }
  }





  //show popup dialog
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                myAlert();
              },
              child: Text('Upload Photo'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {

                createAlbum("raef");
              },
              child: Text('send Photo'),
            ),
            SizedBox(
              height: 10,
            ),
            //if image not null show the image
            //if image null show text
            image != null
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  //to show image, you type like this.
                  File(image!.path),

                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: 300,

                ),
              ),
            )
                : Text(
              "No Image",
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}