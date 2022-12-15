import 'dart:async';
import 'dart:io';
import 'package:food_app/model/cart_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
  }

  initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "cart.db");
    var db = await openDatabase(path, version: 1, onCreate: _oncreate);
    return db;
  }

  FutureOr<void> _oncreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL , '
        'productId VARCHAR UNIQUE,productName TEXT,initialPrice INTEGER, '
        'productPrice INTEGER , quantity INTEGER , image TEXT,unit TEXT )');
  }

  Future<Cart?> insert(Cart cart) async {
    try {
      var dbClient = await db;
      await dbClient!.insert("cart", cart.toMap());
    } catch (e) {
      updateQuantity(cart);
    }
  }

  Future<List<Cart>> getCartList() async {
    var dbClient = await db;
    final List<Map<String, dynamic>?> data = await dbClient!.query("cart");
    return data.map((e) => Cart.fromMap(e!)).toList();
  }

  Future<int?> delete(int id) async {
    var dbClient = await db;
    return dbClient!.delete("cart", where: 'productId = ?', whereArgs: [id]);
  }

  Future<int?> updateQuantity(Cart cart) async {
    var dbClient = await db;
    return dbClient!.update("cart", cart.toMap(),
        where: 'productId = ?', whereArgs: [cart.productId]);
  }
}
