import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/devisStationModel.dart'; // Assurez-vous d'importer votre modèle

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'devis_station.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE devis(id INTEGER PRIMARY KEY AUTOINCREMENT, valeurArriver REAL, valeurDeDepart REAL, prixUnite REAL, consommation REAL, budgetObtenu REAL, dateAddDevis TEXT, idUser INTEGER, nomUtilisateur TEXT, prenomUtilisateur TEXT)',
        );
      },
    );
  }

  Future<void> insertDevis(DevisModel devis) async {
    final db = await database;
    await db.insert(
      'devis',
      devis.toMap(), // Assurez-vous d'avoir une méthode toMap() dans votre modèle
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Récupérer un devis par ID
  Future<DevisModel?> getDevisById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'devis',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return DevisModel.fromMap(maps.first); // Assurez-vous d'avoir une méthode fromMap() dans votre modèle
    }
    return null; // Aucun devis trouvé
  }
}
