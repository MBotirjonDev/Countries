import 'dart:convert';

import 'package:countries/ui/firstpage/first_json.dart';
import 'package:countries/ui/secondpage/second_page.weather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FirstPageAll extends StatefulWidget {
  @override
  _FirstPageAllState createState() => _FirstPageAllState();
}

class _FirstPageAllState extends State<FirstPageAll> {
  int id = -2;
  TextEditingController _controller = TextEditingController();
  String? text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: _getFromApi(),
            builder: (context, AsyncSnapshot<List<Countries>> snap) {
              var data = snap.data;
              return data != null
                  ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: SafeArea(
                              bottom: false,
                              child: Text(
                                "Countries",
                                style: TextStyle(
                                  fontSize: 60.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Akronim",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              "Information about countries",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16.0),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Form(
                            child: TextFormField(
                              controller: _controller,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                prefixIcon: IconButton(
                                  color: Colors.black,
                                  onPressed: () {
                                    setState(() {});
                                    text = _controller.text;
                                    text = capitalize(text.toString());
                                    for (var i = 0; i < data!.length; i++) {
                                      if (data![i].name!.official.toString() ==
                                              text ||
                                          data![i].name!.common.toString() ==
                                              text) {
                                        id = i;
                                        break;
                                      }
                                    }
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.search),
                                ),
                                hintText: "Type to search...",
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 12.0),
                                    child: Text(
                                      "Countries",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 12.0),
                                    child: Text(
                                      "Near from countries",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 170.0),
                              Text(
                                "View All",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            //color: Colors.cyan,
                            height: 250.0,
                            child: FutureBuilder(
                              future: _getFromApi(),
                              builder: (context,
                                  AsyncSnapshot<List<Countries>> snap) {
                                data = snap.data!;
                                if (snap.hasData) {
                                  if (snap.connectionState ==
                                      ConnectionState.done) {
                                    return ListView.builder(
                                      itemCount: 4,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          height: 250.0,
                                          width: 180.0,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                "https://source.unsplash.com/random/$index",
                                              ),
                                            ),
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 170.0),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  data![index]
                                                      .name!
                                                      .official
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 19.0,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(width: 8.0),
                                                  Text(
                                                    data![index]
                                                        .flag
                                                        .toString(),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.0),
                                                    child: Text(
                                                      data![index]
                                                          .capital
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  } else if (snap.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CupertinoActivityIndicator(),
                                    );
                                  } else {
                                    return Center(
                                      child: Text('Error'),
                                    );
                                  }
                                } else if (snap.hasError) {
                                  return Center(
                                    child: CupertinoActivityIndicator(),
                                  );
                                } else {
                                  return Center(
                                    child: CupertinoActivityIndicator(),
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child: Text(
                                  "Countries found",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              SizedBox(width: 170.0),
                              Text(
                                "View All",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          foundCountry(id, data!),
                        ],
                      ),
                    )
                  : Container();
            }),
      ),
    );
  }

  Container foundCountry(int i, List<Countries> data) {
    
    return id > 0
        ? Container(
            height: 250.0,
            width: 400.0,
            child: FutureBuilder(
              future: _getFromApi(),
              builder: (context, AsyncSnapshot<List<Countries>> snap) {
                var data = snap.data!;
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        height: 250.0,
                        width: 400.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://source.unsplash.com/random/",
                            ),
                          ),
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 200),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                data[i].name!.official.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19.0,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(width: 8.0),
                                Text(
                                  data[i].flag.toString(),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    data[i].name!.common.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SecondHomeWeather(id, data),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          )
        : Container();
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
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
