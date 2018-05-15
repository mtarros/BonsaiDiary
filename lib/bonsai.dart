//import 'dart:convert';
//import 'package:meta/meta.dart';
//
//class Bonsai {
//  Bonsai({
//    @required this.avatar,
//    @required this.id,
//    @required this.name,
//    @required this.species,
//    @required this.location,
//  });
//
//  final String avatar;
//  final String id;
//  String name;
//  final String species;
//  final String location;
//
//  static List<Bonsai> allFromResponse(String json) {
//    return [
//      new Bonsai(id: '1', name: 'Pine', species: 'Japanese Black Pine', location: '',
//      avatar: 'https://pbs.twimg.com/media/DZT32WYXcAApSkd.jpg'),
//      new Bonsai(id: '2', name: 'Maple', species: 'Japanese Maple', location: '',
//          avatar: 'https://i.pinimg.com/originals/76/21/66/762166db92dd8dad6e05795defbdd903.jpg'),
//      new Bonsai(id: '3', name: 'Pyracantha', species: 'Pyracantha Angustifolia', location: '',
//          avatar: 'https://static.boredpanda.com/blog/wp-content/uploads/2016/04/amazing-bonsai-trees-5-1-5710e79582acc__700.jpg'),
//      new Bonsai(id: '4', name: 'Juniper', species: 'Itoigawa Juniper', location: '',
//          avatar: 'https://www.bonsaimary.com/images/Itoigawa-Shimpaku-JohnKirby600.jpg'),
//      new Bonsai(id: '5', name: 'Juniter', species: 'Itoigawa Juniper', location: '',
//          avatar: 'https://i.ytimg.com/vi/JFEL8YLKqcQ/maxresdefault.jpg'),
//      new Bonsai(id: '6', name: 'Pine', species: 'Japanese Black Pine', location: '',
//          avatar: 'https://pbs.twimg.com/media/DZT32WYXcAApSkd.jpg'),
//      new Bonsai(id: '7', name: 'Pine', species: 'Japanese Black Pine', location: '',
//          avatar: 'https://pbs.twimg.com/media/DZT32WYXcAApSkd.jpg'),
//      new Bonsai(id: '8', name: 'Pine', species: 'Japanese Black Pine', location: '',
//          avatar: 'https://pbs.twimg.com/media/DZT32WYXcAApSkd.jpg'),
//      new Bonsai(id: '9', name: 'Pine', species: 'Japanese Black Pine', location: '',
//          avatar: 'https://pbs.twimg.com/media/DZT32WYXcAApSkd.jpg'),
//      new Bonsai(id: '10', name: 'Pine', species: 'Japanese Black Pine', location: '',
//          avatar: 'https://pbs.twimg.com/media/DZT32WYXcAApSkd.jpg')
//
//    ];
////    return JSON
////        .decode(json)['results']
////        .map((obj) => Friend.fromMap(obj))
////        .toList();
//  }
//
////  static Bonsai fromMap(Map map) {
////    var name = map['id'];
////
////    return new Bonsai(
////      id: map['picture']['large'],
////      name: '${_capitalize(name['first'])} ${_capitalize(name['last'])}',
////      species: map['email'],
////      location: _capitalize(map['location']['state']),
////    );
////  }
////
////  static String _capitalize(String input) {
////    return input.substring(0, 1).toUpperCase() + input.substring(1);
////  }
//}