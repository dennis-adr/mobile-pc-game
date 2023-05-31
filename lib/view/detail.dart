import 'package:flutter/material.dart';
import 'package:tpmproject169/view/kesan_saran.dart';
import 'package:tpmproject169/view/profil.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login_page.dart';
import 'menu.dart';

class GameDetail extends StatelessWidget {
  int id;
  String title;
  String thumbnail;
  String short_description;
  String developer;
  String genre;
  String link;
  String publisher;

  GameDetail({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.short_description,
    required this.developer,
    required this.genre,
    required this.link,
    required this.publisher,
  });

  final Uri _url = Uri.parse('https://flutter.dev');
  //

  Future<void> goToWebPage(String urlString) async {
    final Uri _url = Uri.parse(urlString);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xfff0f1f5),
        appBar: AppBar(
            title: Text(title.toString()),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () async {
                    await goToWebPage(link.toString());
                  },
                  icon: Icon(Icons.search, color: Colors.white)),
            ],),
        body: Center(
            child: Container(
          padding: const EdgeInsets.all(18),
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: size.height * 0.2,
                child: Image.network(
                  width: 400,
                  thumbnail.toString(),
                  fit: BoxFit.fill,
                ),
              ),
              Card(
                child: Container(
                  height: 80,
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Judul Game : $title",
                              style: TextStyle(fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Genre: $genre",
                              style: TextStyle(fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Publisher: $publisher",
                              style: TextStyle(fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey.withOpacity(0.10),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 10),
                  )
                ]),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        short_description.toString(),
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16,
                          wordSpacing: 3,
                        ),
                        maxLines: 11,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Official Link: $link",
                        style: TextStyle(fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.lightBlueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Kesan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        onTap: (value) {
          if (value == 0) {
            Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => mainMenu()),
                  (Route<dynamic> route) => false,);
          }
          if (value == 1) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Profil()));
          }
          if (value == 2) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PesanKesan()));
          }
          if (value == 3) {
            Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false,);
          }
        },
      ),

    );
  }
}
