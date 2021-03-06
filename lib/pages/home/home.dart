import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fmdb/constants/config.dart';
import 'package:fmdb/providers/models/upcomingmovies.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
 
class _HomePageState extends State<HomePage> {
 bool isloading = false;
 UpcomingMovies  fmdbupcoming;
  upcomingMovies() async {
  setState(() {
    isloading = true;
  });
  var res = await http.get(FMDBConfig.url+FMDBConfig.upcomingMovies, headers : {"Authorization": FMDBConfig.accessToken});
 
  var decoded = jsonDecode(res.body);
  fmdbupcoming = UpcomingMovies.fromJson(decoded);
  setState(() {
    isloading = false;
  });
  }
  
  @override
  void initState() {
    upcomingMovies();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:Text('my first app')),
    body: isloading ? Center(child: CircularProgressIndicator(),) : 
    GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                mainAxisSpacing: 6.0,
                crossAxisSpacing: 6.0,
                children: List.generate(
                  fmdbupcoming.results.length,
                  (index) {
                    var boxFit = BoxFit.fill;
                    return Center(
                      child: Image(
                        image:
                            NetworkImage(FMDBConfig.originalImage + fmdbupcoming.results[index].posterPath),
                        fit: boxFit,
                      ),
                    );
                  },
                ),
              )
  );                
  }
}
