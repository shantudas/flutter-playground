import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'Article.dart';

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
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

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
  static const String TAG = "HomePage";
  bool isLoading = false;
  List<Article> articles = [];
  String _url = "http://tranquil-spire-95897.herokuapp.com/api/v1/articles";
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _fetchArticles(_url);

    _scrollController.addListener(() {
      double viewportDimension = _scrollController.position.viewportDimension;
      double minScroll = _scrollController.position.minScrollExtent;
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;

      print('$TAG:: viewportDimension- $viewportDimension minScroll- $minScroll maxScroll- $maxScroll currentScroll- $currentScroll');
       if (currentScroll == maxScroll) {
        if (_url != null) {
          print('$TAG inside listener called ::\n $_url');
          _fetchArticles(_url);
        } else {
          print('$TAG no more data to fetch');
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        child: ListView.builder(
            controller: _scrollController,
            itemCount: articles.length+1, // Add one more item for progress indicator
            itemBuilder: (context, index) {
              if(index== articles.length){
                return _buildProgressIndicator();
              }else{
                final article = articles[index];
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('${article.id}. ${article.title}'),
                      subtitle: Text('Posted by ${article.postedBy}'),
                    ), Divider()
                  ],
                );
              }
            }),
        onRefresh: () async {

          setState(() {
            articles.clear();
          });
          print('$TAG _fetchArticles on refresh called ::\n http://tranquil-spire-95897.herokuapp.com/api/v1/articles');
          final response = await get("http://tranquil-spire-95897.herokuapp.com/api/v1/articles");

          if (response.statusCode == 200) {
            var jsonBody = json.decode(response.body);
            List jsonArray = jsonBody['data'];

            var nextPageUrl = jsonBody['links']['next'];
            print('$TAG next page url :: $nextPageUrl');
            if (nextPageUrl != null) {
              _url = nextPageUrl;
            } else {
              _url = null;
            }

            for (var i in jsonArray) {
              Article article = Article.fromJson(i);
              articles.add(article);
            }

            setState(() {

            });
            print('$TAG article size :: ${articles.length}');
          } else {
            throw Exception('Unable to fetch articles');
          }
        }
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  //fetch articles from rest api
  // @params url
  _fetchArticles(String urlToCall) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      print('$TAG _fetchArticles called ::\n $urlToCall');
      final response = await get(urlToCall);

      if (response.statusCode == 200) {
        var jsonBody = json.decode(response.body);
        List jsonArray = jsonBody['data'];

        var nextPageUrl = jsonBody['links']['next'];
        print('$TAG next page url :: $nextPageUrl');
        if (nextPageUrl != null) {
          _url = nextPageUrl;
        } else {
          _url = null;
        }

        for (var i in jsonArray) {
          Article article = Article.fromJson(i);
          articles.add(article);
        }

        isLoading = false;

        setState(() {

        });
        print('$TAG article size :: ${articles.length}');
      } else {
        throw Exception('Unable to fetch articles');
      }
    }
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}
