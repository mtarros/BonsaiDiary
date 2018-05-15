import 'package:bonsai_diary/models/bonsaiModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bonsai_diary/bonsai.dart';
import 'package:bonsai_diary/bonsai_detail_page.dart';
import 'package:parallax_image/parallax_image.dart';

class BonsaiPage extends StatefulWidget {
  @override
  _BonsaiPageState createState() => new _BonsaiPageState();
}

class _BonsaiPageState extends State<BonsaiPage> {
  List<BonsaiModel> _bonsai = [];
  final _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    _loadBonsai();
  }

  _loadBonsai() async {
    setState(() {
      _bonsai = BonsaiModel.loadTestData();
    });
  }

//  _buildBonsaiItem(BuildContext context, int index) {
//    Bonsai bonsai = _bonsai[index];
//
//    return new GestureDetector(
//      onTap: () => _navigateToBonsaiDetails(bonsai, index),
//      child: new Dismissible(
//          direction: DismissDirection.endToStart,
//          key: new Key(bonsai.id),
//          background: new Container(
//            padding: new EdgeInsetsDirectional.only(end: 5.0),
//            color: Colors.redAccent,
//            alignment: new FractionalOffset(1.0, 0.5),
//            child: new Icon(
//              Icons.delete,
//              size: 40.0,
//              color: Colors.white30,
//            ),
//          ),
//          onDismissed: (direction) {
//            if (direction == DismissDirection.endToStart) {
//              _bonsai.removeAt(index);
//
//              Scaffold
//                  .of(context)
//                  .showSnackBar(new SnackBar(content: new Text("Deleted")));
//            }
//          },
//          child: new Stack(alignment: Alignment.bottomLeft, children: <Widget>[
//            new Container(
//                padding: const EdgeInsets.only(bottom: 0.0),
//                child: new AspectRatio(
//                    aspectRatio: 600 / 300,
//                    child: new Image.network(
//                      bonsai.avatar,
//                      fit: BoxFit.fitWidth,
//                      color: Colors.grey,
//                      colorBlendMode: BlendMode.exclusion,
//                    ))),
//
//            new Container(
//                padding: const EdgeInsets.only(bottom: 0.0),
//                child: new AspectRatio(
//                    aspectRatio: 600 / 300,
//                    child: new Hero(
//                      tag: _bonsai[index].id,
//                      child: new Container(
//                        decoration: new BoxDecoration(
//                            image: new DecorationImage(
//                          fit: BoxFit.fitWidth,
//                          alignment: FractionalOffset.center,
//                          image: new NetworkImage(bonsai.avatar),
//                        )),
//                      ),
//                    ))),
//            new Card(
//                elevation: 10.0,
//                color: Colors.white30,
//                child: new Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: new Container(
//                    height: 50.0,
//                    child: new Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        new Text(bonsai.name,
//                            style: new TextStyle(
//                                color: Colors.white,
//                                fontWeight: FontWeight.bold,
//                                fontSize: 20.0)),
//                        new Text(bonsai.species,
//                            style: new TextStyle(
//                                color: Colors.white,
//                                fontStyle: FontStyle.italic,
//                                fontSize: 18.00))
//                      ],
//                    ),
//                  ),
//                ))
//          ])),
//    );
//  }

  _navigateToBonsaiDetails(BonsaiModel bonsai, Object avatarTag) {
    Navigator.of(context).push(new PageRouteBuilder(
        opaque: true,
        transitionDuration: const Duration(milliseconds: 1000),
        pageBuilder: (BuildContext context, _, __) {
          return new BonsaiDetailsPage(bonsai, avatarTag: avatarTag);
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return new FadeTransition(opacity: animation, child: child);
        }));
  }

  @override
  Widget build(BuildContext context) {
    var content;

    if (_bonsai.isEmpty) {
      content = new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      content = new ListView.builder(
        controller: _controller,
        itemCount: _bonsai.length,
        itemBuilder: _buildBonsaiItem,
      );
    }

    //return content;
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        elevation: 4.0,
        onPressed: () {},
        child: new Icon(Icons.add),
      ),
      body: content,
    );
  }

  Widget _parallexImage(int index) {
    BonsaiModel bonsai = _bonsai[index];

    return new ParallaxImage(
      image: new NetworkImage(bonsai.avatar),
      // Extent of this widget in scroll direction.
      // In this case it is vertical scroll so extent defines
      // the height of this widget.
      // The image is scaled with BoxFit.fitWidth which makes it
      // occupy full width of this widget.
      // After image is scaled it should normally have height greater
      // than this value to allow for parallax effect to be
      // visible.
      extent: 100.0,
      // Optionally specify child widget.

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(left: 5.0),
            height: 60.0,
            width: double.maxFinite,
            color: Colors.black45,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(bonsai.name,
                    style: new TextStyle(
                        color: Colors.lightGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 21.0)),
                new Text(bonsai.species,
                    style: new TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 19.00))
              ],
            ),
          ),
        ],
      ),

//      child: new Card(
//          elevation: 10.0,
//          color: Colors.white30,
//          child: new Padding(
//            padding: const EdgeInsets.all(0.0),
//            child: new Container(
//
//              child: new Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  new Text(bonsai.name,
//                      style: new TextStyle(
//                          color: Colors.lightGreen,
//                          fontWeight: FontWeight.bold,
//                          fontSize: 20.0)),
//                  new Text(bonsai.species,
//                      style: new TextStyle(
//                          color: Colors.white,
//                          fontStyle: FontStyle.italic,
//                          fontSize: 18.00))
//                ],
//              ),
//            ),
//          ))
//      ,
      controller: _controller,
    );
  }

  Widget _buildBonsaiItem(context, index) {
    BonsaiModel bonsai = _bonsai[index];

    return new GestureDetector(
      onTap: () => _navigateToBonsaiDetails(bonsai, index),
      child: new Dismissible(
          direction: DismissDirection.endToStart,
          key: new Key(bonsai.id.toString()),
          background: new Container(
            padding: new EdgeInsetsDirectional.only(end: 5.0),
            color: Colors.redAccent,
            alignment: new FractionalOffset(1.0, 0.5),
            child: new Icon(
              Icons.delete,
              size: 40.0,
              color: Colors.white30,
            ),
          ),
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              _bonsai.removeAt(index);

              Scaffold
                  .of(context)
                  .showSnackBar(new SnackBar(content: new Text("Deleted")));
            }
          },
          child: new Container(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: new AspectRatio(
                  aspectRatio: 600 / 300, child: _parallexImage(index)))

//            new Stack(alignment: Alignment.bottomLeft, children: <Widget>[
//              new Container(
//                  padding: const EdgeInsets.only(bottom: 0.0),
//                  child: new AspectRatio(
//                      aspectRatio: 600 / 300,
//                      child: new Hero(
//                        tag: _bonsai[index].id,
//                        child: new Container(
//                          decoration: new BoxDecoration(
//                              image: new DecorationImage(
//                                fit: BoxFit.fitWidth,
//                                alignment: FractionalOffset.center,
//                                image: new NetworkImage(bonsai.avatar),
//                              )),
//                        ),
//                      ))),
//              new Card(
//                  elevation: 10.0,
//                  color: Colors.white30,
//                  child: new Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: new Container(
//                      height: 50.0,
//                      child: new Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          new Text(bonsai.name,
//                              style: new TextStyle(
//                                  color: Colors.white,
//                                  fontWeight: FontWeight.bold,
//                                  fontSize: 20.0)),
//                          new Text(bonsai.species,
//                              style: new TextStyle(
//                                  color: Colors.white,
//                                  fontStyle: FontStyle.italic,
//                                  fontSize: 18.00))
//                        ],
//                      ),
//                    ),
//                  ))
//            ])
          ),
    );
  }
}
