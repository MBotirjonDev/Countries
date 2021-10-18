import 'dart:convert';

import 'package:countries/ui/firstpage/first_json.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ThirdInfoPage extends StatefulWidget {
  

  @override
  _ThirdInfoPageState createState() => _ThirdInfoPageState();
}

class _ThirdInfoPageState extends State<ThirdInfoPage> {
  var controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _getFromApi(),
          builder: (context, AsyncSnapshot<List<Countries>> snap) {
            var data = snap.data!;
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 250.0,
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        controller: controller,
                        children: [
                          Container(
                            height: 250.0,
                            //color: Colors.cyan,
                            decoration: BoxDecoration(
                              color: Colors.cyan,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://source.unsplash.com/random/1",
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 250.0,
                            decoration: BoxDecoration(
                              color: Colors.yellowAccent,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://source.unsplash.com/random/2",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        "${data[0].name!.official}, ${data[0].subregion}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        "${data[0].capital}",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(
                          mini: true,
                          backgroundColor: Colors.grey[200],
                          onPressed: () {},
                          child: Icon(
                            Icons.call,
                            color: Colors.grey[600],
                          ),
                        ),
                        FloatingActionButton(
                          mini: true,
                          onPressed: () {
                            launch(data[0].maps!.googleMaps.toString());
                          },
                          backgroundColor: Colors.grey[200],
                          child: Icon(
                            Icons.navigation_outlined,
                            color: Colors.grey[600],
                          ),
                        ),
                        FloatingActionButton(
                          mini: true,
                          onPressed: () {},
                          backgroundColor: Colors.grey[200],
                          child: Icon(
                            Icons.share_location,
                            color: Colors.grey[600],
                          ),
                        ),
                        FloatingActionButton(
                          mini: true,
                          onPressed: () {},
                          backgroundColor: Colors.grey[200],
                          child: Icon(
                            Icons.calendar_today,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(width: 20.0),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            fixedSize: Size(120.0, 50.0),
                            side: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Follow",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Divider(
                      thickness: 2.0,
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text(
                        "Infromation",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "${data[0].area}",
                        ),
                        Text(
                          "${data[0].population}",
                        ),
                        Text(
                          "${data[0].region}",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Area",
                        ),
                        Text(
                          "Population",
                        ),
                        Text(
                          "Region",
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Container(
                        height: 200.0,
                        child: Text(
                          """Countries in the World:
195
There are 195 countries in the world today. This total comprises 193 countries that are member states of the United Nations and 2 countries that are non-member observer states: the Holy See and the State of Palestine.Not in the list
Not included in this total count of 195 countries are:

Taiwan - the United Nations considers it represented by the People's Republic of China

""",
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        color: Colors.grey[200],
                        height: 40.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Show scorecard",
                            ),
                            SizedBox(width: 100.0),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Row(
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              fixedSize: Size(170.0, 50.0),
                              side: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Preview",
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                          ),
                          SizedBox(width: 19.0),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              fixedSize: Size(170.0, 50.0),
                              side: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Start round",
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 40.0,
                  left: 10.0,
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.grey[400],
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<List<Countries>> _getFromApi() async {
    try {
      var _res = await http.get(
        Uri.parse("https://restcountries.com/v3.1/all"),
      );
      if (_res.statusCode == 200) {
        return (json.decode(_res.body) as List)
            .map((e) => Countries.fromJson(e))
            .toList();
      } else {
        throw Exception("ERROR");
      }
    } catch (e) {
      throw Exception("Error");
    }
  }
}
