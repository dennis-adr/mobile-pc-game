import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tpmproject169/view/login_page.dart';
import 'package:tpmproject169/view/kesan_saran.dart';
import 'package:tpmproject169/view/profil.dart';

import 'detail.dart';
import 'menu.dart';

class GameList extends StatefulWidget {
  const GameList({super.key});

  @override
  _GameListState createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  List home = [];
  bool load = false;

  @override
  void initState() {
    super.initState();
    fetchHome();
  }

  fetchHome() async {
    setState(() {
      load = true;
    });
    var url = "https://www.freetogame.com/api/games?platform=pc";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List items = (json.decode(response.body) as List).toList();
      setState(() {
        home = items;
        load = false;
      });
    } else {
      setState(() {
        home = [];
        load = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PC Free Game"),
        centerTitle: true,
      ),
      body: getBody(),
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
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => mainMenu()),
              (Route<dynamic> route) => false,
            );
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
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
              (Route<dynamic> route) => false,
            );
          }
        },
      ),
    );
  }

  Widget getBody() {
    // ignore: prefer_is_empty
    if (home.contains(null) || home.length < 0 || load) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueGrey),
      ));
    }
    return ListView.builder(
        itemCount: home.length,
        itemBuilder: (context, index) {
          return getCard(home[index]);
        });
  }

  Widget getCard(item) {
    var id = item['id'];
    var title = item['title'];
    var thumbnail = item['thumbnail'];
    var shortDescription = item['short_description'];
    var link = item['game_url'];
    var developer = item['developer'];
    var genre = item['genre'];
    var publisher = item['publisher'];

    return Card(
        margin: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => GameDetail(
                  id: id,
                  title: title,
                  thumbnail: thumbnail,
                  short_description: shortDescription,
                  link: link,
                  developer: developer,
                  genre: genre,
                  publisher: publisher))),
          child: Container(
            /*color: Colors.white,*/
            height: MediaQuery.of(context).size.height / 10,
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
            child: ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    width: 100,
                    height: 200,
                    thumbnail.toString(),
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.shop,
                        size: 90,
                      );
                    },
                  )),
              title: Text(
                title.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),
          ),
        ));
  }
}
