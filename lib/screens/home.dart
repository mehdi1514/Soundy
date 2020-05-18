import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:soundy/constants/mycolors.dart';
import 'package:soundy/screens/play_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Soundy",
          style: TextStyle(fontFamily: 'Lobster', fontSize: 30.0),
        ),
        elevation: 1,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Text(
            "   Recents",
            style: TextStyle(
                color: Colors.white, fontSize: 22.0, fontFamily: 'Bellota'),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          PageTransition(type: PageTransitionType.fade, child: PlayScreen())),
                      child: Container(
                        width: 200,
                        padding: EdgeInsets.all(60.0),
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: AppColors.loadingImageColor,
                          image: DecorationImage(
                              image: AssetImage('assets/albumart/album.png'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent.withOpacity(0.5),
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Song Name",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Bellota',
                        fontSize: 16.0,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Text(
            "\n   All Songs",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontFamily: 'Bellota',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 12,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.7),
            ),
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        PageTransition(type: PageTransitionType.fade, child: PlayScreen())),
                    child: Container(
                      padding: EdgeInsets.all(35.0),
                      decoration: BoxDecoration(
                        color: AppColors.loadingImageColor,
                        image: DecorationImage(
                            image: AssetImage(index % 2 == 0
                                ? 'assets/albumart/album2.png'
                                : 'assets/albumart/album.png')),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent.withOpacity(0.5),
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Song name",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Bellota',
                      fontSize: 16.0,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
