import 'package:flutter/material.dart';
import 'package:flutter_pokedex/services/api_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List items = [];

  @override
  void initState() {
    super.initState();
    ApiService().getPokemos().then((value) {
      setState(() {
        items = value;
        print(items);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Image.asset('assets/img/filter.png'),
        backgroundColor: Color(0xFF6C79DB),
        onPressed: () {
          print('pressed button');
        },
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget> [
            Positioned(
              right: 0,
              child: Image.asset('assets/img/pokeball.png'),
            ),
            Positioned(
              right: 14,
              top: 42,
              child: IconButton(
                icon: Image.asset('assets/img/list.png'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/details');
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  titleContainer(),
                  SizedBox(
                    height: 30,
                  ),
                  gridView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget titleContainer() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text('Pokedex', style: TextStyle(fontSize: 30,
      fontWeight: FontWeight.bold,
      ),
      ),
    );
  }

  Widget gridView() {
    return Expanded(
      child: Container(
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 3.2),
            children: <Widget>[
              for (var item in items)
                itemList(item),
            ],
          )
      ),
    );
  }

  Widget itemList(item) {
    return GestureDetector(
      onTap: () {
        var pokemon = {
          'id': item['id'],
          'name': item['name'],
          'type': getType('${item['type']}'),
          'photo': item['photo'],
          'color': getColor('${item['type']}'),
        };
        Navigator.of(context).pushNamed('/about',
            arguments: pokemon);
        },
      child: Container(
        decoration: BoxDecoration(
          color: getColor('${item['type']}'),
          borderRadius: BorderRadius.circular(15),
        ),
        margin:  EdgeInsets.all(5),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20, left: 15,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${item['name']}', style: TextStyle(fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0x4DFFFFFF),
                      borderRadius: BorderRadius.circular(38),
                    ),
                    child: Text(getType('${item['type']}'), style: TextStyle(
                      fontSize: 8, color: Colors.white,
                    ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              width: 90,
              height: 90,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Image.asset('assets/img/mask.png',
                        color: Colors.white.withOpacity(0.5)),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Image.network('${item['photo']}'),
                  )
                ],
              ),
            ),
            Positioned(
              right: 14,
              top: 6,
              child: Text('#00'+'${item['id'].toString()}',
                style: TextStyle(
                  fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: getColorId('${item['type']}'),
              ),),
            ),
          ],
        ),
      ),
    );
  }

  Color getColor(String type) {
    if (type == 'grass') {
      return Color(0xFF48D0B0);
    } else if (type == 'fire') {
      return Color(0xFFFB6C6C);
    } else if (type == 'water') {
      return Color(0xFF7AC7FF);
    } else {
      return Color(0xFFFFCE4B);
    }
  }

  Color getColorId(String type) {
    if (type == 'grass') {
      return Color(0xFF3E8570).withOpacity(0.12);
    } else if (type == 'fire') {
      return Color(0xFFDE5050).withOpacity(0.2);
    } else if (type == 'water') {
      return Color(0xFF4689C7).withOpacity(0.12);
    } else {
      return Color(0xFFFBCD66).withOpacity(0.2);
    }
  }

  String getType(String type) {
    if (type == 'grass') {
      return 'Grass';
    } else if (type == 'fire') {
      return 'Fire';
    } else if (type == 'water') {
      return 'Water';
    } else {
      return type;
    }
  }
}
