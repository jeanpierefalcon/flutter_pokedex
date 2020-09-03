
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Image.asset('assets/img/back.png',
          color: Color(0xFF333333),),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Image.asset('assets/img/hero_image.png',),
            SizedBox(
              height: 20,
            ),
            Text('Pokémon Rumble Rush Arrives Soon', style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF303943),
            ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('15 May 2019', style: TextStyle(
              fontSize: 12,
              color: Color(0xFF303943).withOpacity(0.6),
            ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla in nisi at turpis.', style: TextStyle(
              fontSize: 14,
              color: Color(0xFF303943).withOpacity(0.6),
            ),
            ),
            SizedBox(
              height: 20,
            ),
            imagesArticle(),
            SizedBox(
              height: 20,
            ),
            Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla in nisi at turpis faucibus maximus eget vel augue. Duis vel lorem eu ligula sollicitudin accumsan a at turpis.', style: TextStyle(
              fontSize: 14,
              color: Color(0xFF303943).withOpacity(0.6),
            ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imagesArticle() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: new BorderRadius.circular(20),
            child: Image.asset('assets/img/image_article_1.png',),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: new BorderRadius.circular(20),
                child: Image.asset('assets/img/image_article_2.png',),
              ),
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: new BorderRadius.circular(20),
                child: Image.asset('assets/img/image_article_3.png',),
              ),
            ],
          )
        ],
      ),
    );
  }
}
