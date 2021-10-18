import 'dart:convert';

import 'package:countries/ui/firstpage/first_json.dart';
import 'package:countries/ui/secondpage/second_json_weather.dart';
import 'package:countries/ui/thirdpage/third_page_info.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondHomeWeather extends StatefulWidget {
  int index;
  List<Countries> data;
  SecondHomeWeather(this.index, this.data);

  @override
  _SecondHomeWeatherState createState() => _SecondHomeWeatherState();
}

class _SecondHomeWeatherState extends State<SecondHomeWeather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getFromApiForSecondPage(data, index),
        builder: (context, AsyncSnapshot<Weather> snap) {
          var dataThis = snap.data;
          return Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "https://source.unsplash.com/random",
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 48.0,
                left: 20.0,
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
              Positioned(
                top: 580.0,
                left: 30.0,
                child: Container(
                  height: 100.0,
                  width: 300.0,
                  //color: Colors.grey,
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.wb_sunny,
                            color: Colors.yellow,
                            size: 28.0,
                          ),
                          //iconSize: 26.0,
                        ),
                        //color: Colors.cyan,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dataThis!.main!.temp.toString(),
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Wind: ${dataThis.wind!.speed.toString()}km/h NNE",
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 700.0,
                left: 30.0,
                child: Text(
                  "${data[index].name!.official}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                top: 750.0,
                left: 30.0,
                child: Text(
                  "${data[index].capital![0]}",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 17.0,
                  ),
                ),
              ),
              Positioned(
                top: 800.0,
                left: 30.0,
                child: Row(
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        fixedSize: Size(170.0, 50.0),
                        side: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ThirdInfoPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Preview",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 19.0),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        fixedSize: Size(170.0, 50.0),
                        side: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Start round",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  dynamic _changeFromKelvinToCelsius() {
    var data;
    var temp = data.main!.temp;

    double kelvin = 273.15;
    return (temp! - kelvin).toInt().toString();
  }

  Future<Weather> _getFromApiForSecondPage(List<Countries> data, index) async {
    try {
      var _res = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=${data[index].capital![0]}&appid=4f3be3ecf6969e1e7f898495e281db86",
        ),
      );
      if (_res.statusCode == 200) {
        return Weather.fromJson(json.decode(_res.body));
      } else {
        throw Exception("ERROR");
      }
    } catch (e) {
      throw Exception("Error");
    }
  }
}
