import 'package:exp_app/src/models/article.dart';
import 'package:exp_app/src/ui/multi_avatar.dart';
import 'package:exp_app/src/ui/sticky_sliver.dart';
import 'package:flutter/material.dart';

class ArticleTile extends StatelessWidget {
  final Article data;
  final Function func;
  ArticleTile(this.data, {this.func, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        margin: EdgeInsets.only(left: 32),
        width: MediaQuery.of(context).size.width - 32,
        padding: EdgeInsets.only(left: 32, top: 20, bottom: 32, right: 32),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: "article_title_${data.title}",
              child: Material(
                color: Colors.transparent,
                child: Text(
                  data.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 8)),
            Hero(
              tag: "article_category_${data.title}",
              child: Material(
                color: Colors.transparent,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    for (String category in data.category)
                      CategoryTile(category),
                    CategoryTile(
                      "• starts at ${data.time}",
                      backgroundColor: Colors.transparent,
                      textColor: Color.fromARGB(255, 148, 148, 148),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Hero(
                  tag: "article_members_${data.title}",
                  child: MultipleAvatar(data.members, size: 44, border: 3)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 16),
              child: Hero(
                tag: "article_detail_${data.title}",
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    data.details,
                    style: TextStyle(
                      height: 1.35,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 148, 148, 148),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticlePage extends StatefulWidget {
  final Article article;
  ArticlePage(this.article, {Key key}) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Hero(
              tag: "article_header",
              child: ClipRRect(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(64)),
                child: Container(
                  height: 400,
                  color: Colors.white,
                  child: Image.asset(
                    widget.article.image,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          StickySliver(
            child: Container(
              // height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.fromLTRB(48, 36, 36, 8),
              child: Hero(
                tag: "article_title_${widget.article.title}",
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    widget.article.title,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(48, 16, 32, 16),
            sliver: SliverList(
                delegate: SliverChildListDelegate(
              [
                Padding(padding: EdgeInsets.only(top: 8)),
                Hero(
                  tag: "article_category_${widget.article.title}",
                  child: Material(
                    color: Colors.transparent,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: <Widget>[
                        for (String category in widget.article.category)
                          CategoryTile(category),
                        CategoryTile(
                          "• starts at ${widget.article.time}",
                          backgroundColor: Colors.transparent,
                          textColor: Color.fromARGB(255, 148, 148, 148),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Hero(
                      tag: "article_members_${widget.article.title}",
                      child: MultipleAvatar(widget.article.members,
                          size: 44, border: 3)),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Hero(
                    tag: "article_detail_${widget.article.title}",
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        widget.article.details,
                        style: TextStyle(
                          height: 1.35,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 148, 148, 148),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, top: 12, bottom: 12),
                  child: Text(
                    "How to get there?",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    child: Image.asset("assets/images/map1.png"),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                )
              ],
            )),
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
}

class CategoryTile extends StatelessWidget {
  final String text;
  final Color backgroundColor, textColor;
  CategoryTile(this.text,
      {this.backgroundColor = const Color.fromARGB(255, 244, 243, 255),
      this.textColor = const Color.fromARGB(255, 108, 99, 255),
      key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Text(
          text,
          style: TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w600),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
        ),
      ),
    );
  }
}
