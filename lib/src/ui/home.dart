import 'package:exp_app/src/ui/article.dart';
import 'package:flutter/material.dart';
import 'package:exp_app/src/models/suggestion.dart';
import 'package:exp_app/src/models/article.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color grey = Color.fromARGB(255, 124, 124, 124);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      body: Column(
        children: <Widget>[
          // AppBar Replacement
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(28, 48, 28, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Hero(
                  tag: "article_header",
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      "Exp.App",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 28,
                  child:
                      ClipOval(child: Image.asset("assets/images/profile.png")),
                )
              ],
            ),
          ),
          // Suggestions List
          Expanded(
            child: ScrollConfiguration(
              behavior: NoScrollGlow(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 8, bottom: 48),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(64),
                        ),
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 32),
                            child: Text(
                              'Suggested themes',
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 32, top: 8, right: 24, bottom: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '12 suggested themes',
                                  style: TextStyle(fontSize: 18, color: grey),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "See all",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ScrollConfiguration(
                            behavior: NoScrollGlow(),
                            child: SingleChildScrollView(
                              padding: EdgeInsets.only(left: 36, right: 36),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: _buildSuggestions(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ..._buildArticleTiles(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Hero(
        tag: "bottom_navigation_bar",
        child: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          selectedItemColor: Color.fromARGB(255, 108, 99, 255),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), title: Text("Calender")),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text("Search")),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), title: Text("Account")),
          ],
        ),
      ),
    );
  }

  _buildSuggestions() {
    List<Widget> suggestions = [];
    for (Suggestion x in suggestionsData) {
      suggestions.add(SuggestionTile(x, func: () {}));
    }
    return suggestions;
  }

  _buildArticleTiles() {
    return <Widget>[
      for (int i = 0; i < articleData.length; i++)
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: ArticleTile(
            articleData[i],
            func: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ArticlePage(articleData[i])));
            },
          ),
        ),
      Padding(padding: EdgeInsets.only(bottom: 20)),
    ];
  }
}

class SuggestionTile extends StatelessWidget {
  final Suggestion data;
  final Function func;
  const SuggestionTile(this.data, {Key key, @required this.func})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        margin: EdgeInsets.all(4),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                data.image,
                width: 120,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Text(
                data.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoScrollGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

List<Article> articleData = [
  Article(
      'Best of Vienna Walking Tour Adventure',
      'We leave the big tour groups behind and explore'
          'the city in our small team. Let\'s make it interactive and fun.',
      'assets/images/location1.png',
      'assets/images/map1.png',
      '10:30',
      [
        "assets/images/profile2.png",
        "assets/images/profile.png",
        "assets/images/profile.png",
      ],
      [
        'Travelling',
        'History',
      ]),
  Article(
      "Cooking party",
      "We leave the big tour groups behind and explore the city in our small team. Let\'s make it interactive and fun.",
      "assets/images/location1.png",
      "assets/images/map1.png",
      "9:30", [
    "assets/images/profile2.png",
    "assets/images/profile.png",
    "assets/images/profile.png",
  ], [
    "Food",
  ]),
];
