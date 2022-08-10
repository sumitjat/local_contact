import 'package:houzeo_example/common/models/contact_model.dart';
import 'package:sqflite/sqflite.dart';

class DBService {
  Future<Database> init() async {
    return await openDatabase(
        //open the database or create a database if there isn't any
        // Get a location using getDatabasesPath

        'houzeo.db',
        version: 1, onCreate: (Database db, int version) async {
      await db.execute("""
          CREATE TABLE contacts(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          phone TEXT,
          email TEXT,
          image TEXT)""");
    });
  }

  Future<int> addItem(ContactModel item) async {
    //returns number of items inserted as an integer

    final db = await init(); //open database

    return db.insert(
      "contacts", item.toMap(), //toMap() function from MemoModel
      conflictAlgorithm:
          ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
    );
  }

  Future<List<ContactModel>> fetchMemos() async {
    //returns the memos as a list (array)

    final db = await init();
    final maps = await db
        .query("contacts"); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of memos
      return ContactModel(
        id: int.tryParse(maps[i]['id'].toString()) ?? 0,
        name: maps[i]['name'].toString(),
        phone: maps[i]['phone'].toString(),
        email: maps[i]['email'].toString(),
        image: maps[i]['image'].toString(),
      );
    });
  }

  Future<int> deleteContact(int id) async {
    //returns number of items deleted
    final db = await init();

    int result = await db.delete("contacts", //table name
        where: "id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
        );

    return result;
  }

  Future<int> updateMemo(int id, ContactModel item) async {
    // returns the number of rows updated
    final db = await init();
    int result = await db
        .update("contacts", item.toMap(), where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<ContactModel> getParticularContact(int id) async {
    final db = await init();
    final maps = await db.query('contacts', where: "id = ?", whereArgs: [id]);

    return ContactModel(
      id: int.tryParse(maps[0]['id'].toString()) ?? 0,
      name: maps[0]['name'].toString(),
      phone: maps[0]['phone'].toString(),
      email: maps[0]['email'].toString(),
      image: maps[0]['image'].toString(),
    );
  }
}
