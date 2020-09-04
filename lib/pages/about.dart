import 'package:flutter/material.dart';
import 'package:flutter_pokedex/services/api_service.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> with TickerProviderStateMixin {
  TabController _tabController;
  var _details;
  Map pokemon;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);

    Future.delayed(Duration.zero,(){
      setState(() {
        pokemon = ModalRoute.of(context).settings.arguments as Map;

        ApiService().getDetails(pokemon['id']).then((value) {
          setState(() {
            _details = value;
            print(value);
          });
        });
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pokemon = ModalRoute.of(context).settings.arguments as Map;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: pokemon['color'],
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  right: 80,
                  child: Image.asset('assets/img/dotted.png',
                      color: Colors.white.withOpacity(0.5)),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset('assets/img/ornament.png',
                      color: Colors.white.withOpacity(0.5)),
                ),
                Positioned(
                  top: 0,
                  bottom: 60,
                  right: 0,
                  left: 0,
                  child: Image.asset('assets/img/subtract.png',
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
                Column(
                  children: <Widget>[
                    appBarWidget(),
                    titleWidget(pokemon),
                  ],
                ),
              ],
            ),
          ),
          if(_details!=null)
            Positioned(
                bottom: 0,
                width: MediaQuery.of(context).size.width * 1,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                      child: Column(
                        children: <Widget>[
                          tabBarWidget(),
                          tabViewWidget()
                        ],
                      ),
                    ),
                  ],
                )
            ),
          if(_details!=null)
            Positioned(
              bottom: 380,
              right: 160,
              child: Image.network(pokemon['photo']),
            ),
        ],
      ),
    );
  }

  Widget appBarWidget() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Image.asset('assets/img/back.png'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Image.asset('assets/img/love.png'),
          onPressed: () {
            print('favorite');
          },
        ),
      ],
    );
  }

  Widget titleWidget(pokemon) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(pokemon['name'], style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                ),
                Text('#00'+pokemon['id'].toString(), style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0x4DFFFFFF),
                    borderRadius: BorderRadius.circular(38),
                  ),
                  child: Text(pokemon['type'], style: TextStyle(
                    fontSize: 12, color: Colors.white,
                  ),
                  ),
                ),
                Text('Seed Pokemon', style: TextStyle(
                  fontSize: 14, color: Colors.white,
                ),
                )
              ],
            ),
          ]
      ),
    );
  }

  Widget tabBarWidget(){
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              height: 2.0,
              decoration: BoxDecoration(
                color: Color(0xFFF4F5F4),
              ),
            ),
          ),
          Positioned(
            child: tabWidget(),
          )
        ],
      ),
    );
  }

  Widget tabWidget() {
    return DefaultTabController(
      //initialIndex: 0,
      length: 4,
      child: TabBar(
        tabs: <Widget>[
          new Container(
            width: 60.0,
            child: new Tab(text: 'About'),
          ),
          new Container(
            width: 80.0,
            child: new Tab(text: 'Base Stats'),
          ),
          new Container(
            width: 80.0,
            child: new Tab(text: 'Evolution'),
          ),
          new Container(
            width: 60.0,
            child: new Tab(text: 'Moves'),
          ),
        ],

        unselectedLabelColor: const Color(0xff303943).withOpacity(0.4),
        indicatorColor: Color(0xFF6C79DB),
        labelColor: Color(0xFF303943),
        labelStyle: TextStyle(fontSize: 14,),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 2.0,
        isScrollable: true,
        controller: _tabController,
      ),
    );
  }

  Widget tabViewWidget() {
    return Container(
      height: 340,
      child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _details['about'],
                    style: TextStyle(
                      color: Color(0xFF303943),
                      fontSize: 14,
                    ),
                    //maxLines: 5,
                    //overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Height',
                              style: TextStyle(
                                color: Color(0xFF303943).withOpacity(0.4),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              _details['height'].toString(),
                              style: TextStyle(
                                color: Color(0xFF303943),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Weight',
                              style: TextStyle(
                                color: Color(0xFF303943).withOpacity(0.4),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              _details['weight'].toString(),
                              style: TextStyle(
                                color: Color(0xFF303943),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 4,
                          blurRadius: 20,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: ListView(
                children: <Widget>[
                  for (var stats in _details['stats'].reversed.toList())
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: statsWidget(stats),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Container(
              child: Center(
                  child: Text("Evolution")
              ),
            ),
            Container(
              child: Center(
                  child: Text("Moves")
              ),
            ),
          ]
      ),
    );
  }

  Widget statsWidget(stats) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '${stats['name']}',
            style: TextStyle(
              color: Color(0xFF303943).withOpacity(0.6),
              fontSize: 14,
            ),
          ),
          Row(
              children: <Widget>[
                Text(
                  '${stats['base'].toString()}',
                  style: TextStyle(
                    color: Color(0xFF303943),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: 190,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Color(0xFFF4F5F4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: Container(
                          width: getTransformWidth(stats['base']),
                          height: 5,
                          decoration: BoxDecoration(
                            color: getStatColor(stats['base']),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]
          ),
        ],
      ),
    );
  }

  double getTransformWidth(value) {
    return (190 * value) / 100;
  }

  Color getStatColor(int base) {
    if (base >= 65) {
      return Color(0xFF4BC07A);
    } else {
      return Color(0xFFFB6C6C);
    }
  }

}
