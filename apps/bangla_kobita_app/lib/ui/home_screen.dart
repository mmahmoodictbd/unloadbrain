import 'dart:convert';
import 'dart:math';

import 'package:bangla_kobita_app/ui/dto/kobita_fragment.dart';
import 'package:bangla_kobita_app/ui/nav_drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({Key key, this.title}) : super(key: key);

  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  NavDrawer navDrawer = NavDrawer();
  Future<List<KobitaFragment>> futureKobitaFragmentList;
  List<KobitaFragment> kobitaList = new List<KobitaFragment>();
  KobitaFragment randomKobita;

  final _random = new Random();
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    futureKobitaFragmentList = fetchKobitaFragments(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(),
      drawer: navDrawer.getNavDrawer(context),
      body: Container(
        decoration: BoxDecoration(color: Colors.blueAccent),
        child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Center(
              child: buildFutureBuilder(),
            )),
      ),
    );
  }

  AppBar buildAppBar() {
    return new AppBar(
      title: new Text(""),
      backgroundColor: Colors.indigo,
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  randomKobita =
                      kobitaList[_random.nextInt(kobitaList.length)];
                });
              },
              child: Icon(
                Icons.autorenew_sharp,
                size: 26.0,
              ),
            )),
      ],
    );
  }

  FutureBuilder<List<KobitaFragment>> buildFutureBuilder() {
    return FutureBuilder<List<KobitaFragment>>(
        future: futureKobitaFragmentList,
        builder: (context, AsyncSnapshot<List<KobitaFragment>> snapshot) {
          if (snapshot.hasData) {
            return buildDataView();
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  SingleChildScrollView buildDataView() {
    return SingleChildScrollView(
        child: Text(randomKobita.body,
            style: TextStyle(
                fontSize: 22.0,
                height: 1.10,
                color: Color.fromRGBO(255, 255, 255, 1),
                fontWeight: FontWeight.bold)));
  }

  Future<List<KobitaFragment>> fetchKobitaFragments(http.Client client) async {
    final response = await client.get(
        'https://kobita.unloadbrain.com/assets/generated/kobita-fragments.json');

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      kobitaList = List<KobitaFragment>.from(
          l.map((model) => KobitaFragment.fromJson(model)));
      randomKobita = kobitaList[_random.nextInt(kobitaList.length)];
      return kobitaList;
    } else {
      throw Exception('Failed to load kobita');
    }
  }
}
