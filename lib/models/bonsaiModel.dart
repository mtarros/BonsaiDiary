class BonsaiModel {
  int id;
  String name, age, height, trunkWidth, canopyWidth;
  DateTime ageDate, purchaseDate;

  String purchasePrice;

  String species;
  String style;

  String avatar;
  List<String> images;

  BonsaiModel(
      {
        this.id,
        this.name,
        this.avatar,
        this.images,
        this.species,
        this.style,
        this.age,
        this.height = "",
        this.trunkWidth = "",
        this.canopyWidth = "",
        this.ageDate,
        this.purchaseDate,
        this.purchasePrice
      });

  //int get id => _id;

  static List<BonsaiModel> loadTestData() {
    return [
      new BonsaiModel(
        id: 1,
          name: 'Pine',
          species: 'Japanese Black Pine',
          avatar: 'https://pbs.twimg.com/media/DZT32WYXcAApSkd.jpg'),
      new BonsaiModel(
          id: 2,
          name: 'Maple',
          species: 'Japanese Maple',
          avatar:
              'https://i.pinimg.com/originals/76/21/66/762166db92dd8dad6e05795defbdd903.jpg'),
      new BonsaiModel(
          id: 3,
          name: 'Pyracantha',
          species: 'Pyracantha Angustifolia',
          avatar:
              'https://static.boredpanda.com/blog/wp-content/uploads/2016/04/amazing-bonsai-trees-5-1-5710e79582acc__700.jpg'),
      new BonsaiModel(
          id: 4,
          name: 'Juniper',
          species: 'Itoigawa Juniper',
          avatar:
              'https://www.bonsaimary.com/images/Itoigawa-Shimpaku-JohnKirby600.jpg'),
      new BonsaiModel(
          id: 5,
          name: 'Juniter',
          species: 'Itoigawa Juniper',
          avatar: 'https://i.ytimg.com/vi/JFEL8YLKqcQ/maxresdefault.jpg'),
    ];
  }
}

class SpeciesModel {
  int id;
  String commonName, scientificName, description;
  List<SpeciesAnnualManagementModel> speciesAnnualManagement;
}

class StyleModel {}

class SpeciesAnnualManagementModel {}
