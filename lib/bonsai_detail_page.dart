import 'dart:async';
import 'dart:math';
import 'package:bonsai_diary/carousel.dart';
import 'package:bonsai_diary/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:bonsai_diary/models/bonsaiModel.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

class BonsaiDetailsPage extends StatefulWidget {
  BonsaiDetailsPage(
    this.bonsai, {
    @required this.avatarTag,
  });

  BonsaiModel bonsai;

  final Object avatarTag;

  @override
  _BonsaiDetailsPageState createState() => new _BonsaiDetailsPageState();
}

class _BonsaiDetailsPageState extends State<BonsaiDetailsPage> {
  double _appBarHeight = 310.0;
  DateTime _selectedDate = new DateTime.now();
  List<String> images = [];

  List<String> _species = [
    '',
    'Japanese Black Pine',
    'Japanese Maple',
    'Pyracantha Angustifolia',
    'Itoigawa Juniper'
  ];
  // Add validate name function.
  String _validateName(String value) {
    if (value.length < 1) {
      return 'The name must be longer than one character.';
    }

    return null;
  }

  void _showAddSpecies() {
    String _newName = 'New';

    AlertDialog addSpeciesAlert = new AlertDialog(
      content: new TextField(
          onChanged: (value) {
            _newName = value;
          },
          decoration: new InputDecoration(labelText: 'Name')),
      title: new Text('Add Species'),
      actions: <Widget>[
        new RaisedButton(
            onPressed: () {
              //Add new Item
              setState(() {
                if (!_species.contains(_newName)) {
                  _species.add(_newName);
                }
                this.widget.bonsai.species = _newName;
                this.widget.bonsai.name = _newName;
              });

              Navigator.pop(context);
            },
            child: new Text('Ok')),
        new RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: new Text('Cancel'))
      ],
    );

    showDialog(context: context, child: addSpeciesAlert);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new CustomScrollView(
        shrinkWrap: false,
        slivers: <Widget>[
          new SliverAppBar(
            backgroundColor: Colors.green,
            forceElevated: true,
            expandedHeight: _appBarHeight,
            pinned: true,
            floating: false,
            snap: false,
            actions: <Widget>[
              new IconButton(
                icon: const Icon(Icons.camera_enhance),
                tooltip: 'Add Image',
                onPressed: () {
                  setState(() {
                    //TODO: Add function
                    images.add(
                        'https://i.pinimg.com/originals/76/21/66/762166db92dd8dad6e05795defbdd903.jpg');
                  });
                },
              )
            ],
            flexibleSpace: new FlexibleSpaceBar(
              title: new Text(widget.bonsai.name),
              background: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  new Image.network(
                    widget.bonsai.avatar,
                    fit: BoxFit.cover,
                    height: _appBarHeight,
                  ),
                  // This gradient ensures that the toolbar icons are distinct
                  // against the background image.
                  const DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: const LinearGradient(
                        begin: const Alignment(0.0, -1.0),
                        end: const Alignment(0.0, -0.4),
                        colors: const <Color>[
                          const Color(0x60000000),
                          const Color(0x00000000)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          new SliverSafeArea(
            minimum: new EdgeInsets.only(top: 20.0),
            top: false,
            sliver: new SliverList(
              delegate: new SliverChildListDelegate(<Widget>[
                new ListTile(
                    title: new TextFormField(
                        decoration: new InputDecoration(labelText: 'Name'),
                        validator: _validateName,
                        onSaved: (String value) {
                          this.widget.bonsai.name = value;
                        })),

                //Species Dropdown list
                new Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: new InputDecorator(
                      decoration: const InputDecoration(
                        isDense: false,
                        // icon: const Icon(Icons.wifi_tethering),
                        labelText: 'Species',
                        hintText: 'Select Species',
                        //contentPadding: const EdgeInsets.all(10.0)
                      ),
                      isEmpty: this.widget.bonsai.species == '',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                            child: new DropdownButtonHideUnderline(
                              child: new DropdownButton<String>(
                                value: this.widget.bonsai.species,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    this.widget.bonsai.name = newValue;
                                    this.widget.bonsai.species = newValue;
                                  });
                                },
                                items: _species.map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Dismissible(
                                        direction: DismissDirection.endToStart,
                                        key: new Key(value),
                                        background: new Container(color: Colors.red),
                                        onDismissed: (direction) {
                                          if (direction == DismissDirection.endToStart) {
                                            var index = _species.indexOf(value);
                                            _species.removeAt(index);
                                          }
                                        },
                                        child: new Text(value)),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          new InkWell(
                            child: new Icon(
                              Icons.add,
                              color: Colors.green,
                              size: 22.0,
                            ),
                            onTap: () {
                              //Add New
                              _showAddSpecies();
                            },
                          )
                        ],
                      )),
                ),

                new ListTile(
                    title: new TextFormField(
                        decoration: new InputDecoration(labelText: 'Style'),
                        onSaved: (String value) {
                          this.widget.bonsai.style = value;
                        })),
                new ListTile(
                    title: new TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(labelText: 'Age'),
                        onSaved: (String value) {
                          this.widget.bonsai.age = value;
                        })),

                new DateTimePicker(
                  labelText: 'Purchase Date',
                  selectedDate: _selectedDate,
                  selectDate: (DateTime date) {
                    setState(() {
                      widget.bonsai.purchaseDate = date;
                      _selectedDate = date;
                    });
                  },
                ),

                new ListTile(
                    title: new TextFormField(
                        keyboardType: TextInputType.number,
                        decoration:
                            new InputDecoration(labelText: 'Purchase Price'),
                        onSaved: (String value) {
                          this.widget.bonsai.purchasePrice = value;
                        })),

                new ListTile(
                    title: new TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(labelText: 'Height'),
                        onSaved: (String value) {
                          this.widget.bonsai.height = value;
                        })),
                new ListTile(
                    title: new TextFormField(
                        keyboardType: TextInputType.number,
                        decoration:
                            new InputDecoration(labelText: 'Trunk Width'),
                        onSaved: (String value) {
                          this.widget.bonsai.trunkWidth = value;
                        })),
                new ListTile(
                    title: new TextFormField(
                        keyboardType: TextInputType.number,
                        decoration:
                            new InputDecoration(labelText: 'Canopy Width'),
                        onSaved: (String value) {
                          this.widget.bonsai.canopyWidth = value;
                        })),

                imagesGrid(),

//new Container(height: 100.0,
//child:  new Carousel())

//
//               new Card(
//                 elevation: 5.0,
//                 color: Colors.white70,
//                 child: new Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: <Widget>[
//                   new Padding(
//                     padding: new EdgeInsets.only(left: 16.0, top: 16.0 ),
//                     child: new Text('Images', style: new TextStyle(fontSize: 14.0, color: Colors.grey),),
//                   ),
//                   new Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: imagesExpansionTile(),
//                   )
//
//                 ]),
//               ),

                // new Container(height: 700.0),

//new DateTimePicker(
//  labelText: 'Purchase Date',
//  selectedDate: widget.bonsai.purchaseDate,
//  //selectedTime: _toTime,
//  selectDate: (DateTime date) {
//    setState(() {
//      widget.bonsai.purchaseDate = date;
//    });
//  },
//)
              ]),
            ),
          ),
        ],
      ),
    );

//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text(widget.bonsai.name),
//      ),
//      body: new SingleChildScrollView(
//        child: new Column(children: [
//          new Hero(
//              tag: widget.bonsai.id,
//              child: new Stack(
//                children: <Widget>[
//                  new Container(
//                      padding: const EdgeInsets.only(bottom: 0.0),
//                      child: new AspectRatio(
//                          aspectRatio: 600 / 200,
//                          child: new Container(
//                            decoration: new BoxDecoration(
//                                image: new DecorationImage(
//                              fit: BoxFit.fitWidth,
//                              alignment: FractionalOffset.center,
//                              image: new NetworkImage(widget.bonsai.avatar),
//                            )),
//                          ))),
//                ],
//              )),
//          imagesExpansionTile(),
//          new ListTile(
//              title: new TextFormField(
//                  decoration: new InputDecoration(labelText: 'Name'),
//                  validator: _validateName,
//                  onSaved: (String value) {
//                    this.widget.bonsai.name = value;
//                  })),
//          new ListTile(
//              title: new TextField(
//                  decoration: new InputDecoration(labelText: 'Species'))),
//          new ListTile(
//              leading: new Icon(Icons.date_range),
//              title: new Text(
//                'Purchase Date',
//                textScaleFactor: 0.8,
//                style: new TextStyle(color: Colors.grey),
//              ),
//              subtitle: new Text(_formattedDate),
//              onTap: () {
//                _selectDate(context);
//              }),
//        ]),
//      ),
//      floatingActionButton: new FloatingActionButton(
//        onPressed: () {},
//        tooltip: 'Add new weight entry',
//        child: new Icon(Icons.done),
//      ),
//    );
  }

  Widget imagesGrid() {
    GridView imageGrid = new GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this would produce 2 rows.
        crossAxisCount: 3,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: images.map((String item) {
          return _singleItemDisplay(item);
        }).toList());

    double tempHeight = 720.0;

    return Container(height: tempHeight, child: imageGrid);

//    return new GridView.count(
//      // Create a grid with 2 columns. If you change the scrollDirection to
//      // horizontal, this would produce 2 rows.
//      crossAxisCount: 4,
//
//children:  images.map((String item) {
//            return _singleItemDisplay(item);
//          }).toList()
//    );

//    return new Container(
//        height: 150.0,
//        child: new ListView(
//            scrollDirection: Axis.horizontal,
//            children: images.map((String item) {
//              return _singleItemDisplay(item);
//            }).toList()));

    //    return Center(
//      child: new Row(
//        children: <Widget>[
//          new IconButton(
//              icon: new Icon(Icons.add_circle, color: Colors.green),
//              onPressed: () {
//                setState(() {
//                  //TODO: Add function
//                  images.add(
//                      'https://i.pinimg.com/originals/76/21/66/762166db92dd8dad6e05795defbdd903.jpg');
//                });
//              }),
//          new Container(
//            height: 200.00,
//            width: 500.0,
//            child: new ListView(
//                scrollDirection: Axis.horizontal,
//                shrinkWrap: true,
//                children: images.map((String item) {
//                  return _singleItemDisplay(item);
//                }).toList()),
//          )
//        ],
//      ),
//    );

//        return  Container(
//          height: 100.0,
//          child: new ListView.builder(
//                    scrollDirection: Axis.horizontal,
//                    itemCount: images.length,
//                    itemBuilder: _buildImageItem,
//                  ),
//        )
//
//
//
//
//   ;

//    return new ExpansionTile(
//          key: new Key('imagesTile'),
//          title: new Text(
//            'Images',
//            style: new TextStyle(color: Colors.black87),
//          ),
//          leading: new IconButton(
//            iconSize: 30.0,
//              icon: new Icon(Icons.add_circle),
//              color: Colors.green,
//              onPressed: () {
//
//            setState(() {
//              //TODO: Add function
//              images.add('https://i.pinimg.com/originals/76/21/66/762166db92dd8dad6e05795defbdd903.jpg');
//            });
//          }),
//          initiallyExpanded: images.length > 0,
//          children: <Widget>[
//            new Container(
//                height: 100.0,
//                child: new ListView.builder(
//                  scrollDirection: Axis.horizontal,
//                  itemCount: images.length,
//                  itemBuilder: _buildImageItem,
//                ))
//          ],
//        );
  }

  Widget _singleItemDisplay(String item) {
    return new Card(
        elevation: 5.0, child: new Container(child: new Image.network(item)));

//    return Padding(
//      padding: const EdgeInsets.all(20.0),
//      child: Card(
//        elevation: 15.0,
//          child: new Container(child: new Image.network(item))),
//    );
  }
}

//class ImageList extends StatefulWidget {
//  @override
//  _ImageListState createState() => new _ImageListState();
//}
//
//class _ImageListState extends State<ImageList> {
//  List<String> _images = ['1','2'];
//
//  _addImage(String image) async {
//
//    setState(() {
//      _images.add(image);
//    });
//  }
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new ListView.builder(
//      scrollDirection: Axis.horizontal,
//      itemCount: _images.length,
//      itemBuilder: _buildImageItem,
//    );
//
//    //return new Container();
//  }
//
//  Widget _buildImageItem(BuildContext context, int index) {
//    return  new Container(
//      width: 160.0,
//      color: Colors.red,
//    );
//
//  }
//}
