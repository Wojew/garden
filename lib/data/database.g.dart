// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PlantDao _plantDaoInstance;

  PlantTypeDao _plantTypeDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `plants` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `type_id` INTEGER NOT NULL, `planted_at_timestamp` INTEGER NOT NULL, FOREIGN KEY (`type_id`) REFERENCES `plant_types` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `plant_types` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PlantDao get plantDao {
    return _plantDaoInstance ??= _$PlantDao(database, changeListener);
  }

  @override
  PlantTypeDao get plantTypeDao {
    return _plantTypeDaoInstance ??= _$PlantTypeDao(database, changeListener);
  }
}

class _$PlantDao extends PlantDao {
  _$PlantDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _plantEntityInsertionAdapter = InsertionAdapter(
            database,
            'plants',
            (PlantEntity item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'type_id': item.typeId,
                  'planted_at_timestamp': item.plantedAtTimestamp
                }),
        _plantEntityUpdateAdapter = UpdateAdapter(
            database,
            'plants',
            ['id'],
            (PlantEntity item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'type_id': item.typeId,
                  'planted_at_timestamp': item.plantedAtTimestamp
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PlantEntity> _plantEntityInsertionAdapter;

  final UpdateAdapter<PlantEntity> _plantEntityUpdateAdapter;

  @override
  Future<List<PlantEntity>> findAllPlants() async {
    return _queryAdapter.queryList('SELECT * FROM plants ORDER BY id DESC',
        mapper: (Map<String, dynamic> row) => PlantEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            typeId: row['type_id'] as int,
            plantedAtTimestamp: row['planted_at_timestamp'] as int));
  }

  @override
  Future<List<PlantEntity>> findPlantsAfter(int lastId, int itemsOnPage) async {
    return _queryAdapter.queryList(
        'SELECT * FROM plants WHERE id < ? ORDER BY id DESC LIMIT ?',
        arguments: <dynamic>[lastId, itemsOnPage],
        mapper: (Map<String, dynamic> row) => PlantEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            typeId: row['type_id'] as int,
            plantedAtTimestamp: row['planted_at_timestamp'] as int));
  }

  @override
  Future<List<PlantEntity>> findPlants(int itemsOnPage) async {
    return _queryAdapter.queryList(
        'SELECT * FROM plants ORDER BY id DESC LIMIT ?',
        arguments: <dynamic>[itemsOnPage],
        mapper: (Map<String, dynamic> row) => PlantEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            typeId: row['type_id'] as int,
            plantedAtTimestamp: row['planted_at_timestamp'] as int));
  }

  @override
  Future<List<PlantEntity>> findPlantsWhichNameLikeAndAfter(
      String name, int lastId, int itemsOnPage) async {
    return _queryAdapter.queryList(
        'SELECT * FROM plants WHERE name LIKE ? AND id < ? ORDER BY id DESC LIMIT ?',
        arguments: <dynamic>[name, lastId, itemsOnPage],
        mapper: (Map<String, dynamic> row) => PlantEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            typeId: row['type_id'] as int,
            plantedAtTimestamp: row['planted_at_timestamp'] as int));
  }

  @override
  Future<List<PlantEntity>> findPlantsWhichNameLike(
      String name, int itemsOnPage) async {
    return _queryAdapter.queryList(
        'SELECT * FROM plants WHERE name LIKE ? ORDER BY id DESC LIMIT ?',
        arguments: <dynamic>[name, itemsOnPage],
        mapper: (Map<String, dynamic> row) => PlantEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            typeId: row['type_id'] as int,
            plantedAtTimestamp: row['planted_at_timestamp'] as int));
  }

  @override
  Future<int> insertPlant(PlantEntity plant) {
    return _plantEntityInsertionAdapter.insertAndReturnId(
        plant, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePlant(PlantEntity plant) async {
    await _plantEntityUpdateAdapter.update(plant, OnConflictStrategy.abort);
  }
}

class _$PlantTypeDao extends PlantTypeDao {
  _$PlantTypeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _plantTypeEntityInsertionAdapter = InsertionAdapter(
            database,
            'plant_types',
            (PlantTypeEntity item) =>
                <String, dynamic>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PlantTypeEntity> _plantTypeEntityInsertionAdapter;

  @override
  Future<List<PlantTypeEntity>> findAllPlantTypes() async {
    return _queryAdapter.queryList('SELECT * FROM plant_types',
        mapper: (Map<String, dynamic> row) =>
            PlantTypeEntity(id: row['id'] as int, name: row['name'] as String));
  }

  @override
  Future<void> insertPlantTypes(List<PlantTypeEntity> plantTypes) async {
    await _plantTypeEntityInsertionAdapter.insertList(
        plantTypes, OnConflictStrategy.abort);
  }
}
