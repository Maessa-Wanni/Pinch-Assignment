// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $FlutterDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $FlutterDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $FlutterDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<FlutterDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorFlutterDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $FlutterDatabaseBuilderContract databaseBuilder(String name) =>
      _$FlutterDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $FlutterDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$FlutterDatabaseBuilder(null);
}

class _$FlutterDatabaseBuilder implements $FlutterDatabaseBuilderContract {
  _$FlutterDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $FlutterDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $FlutterDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<FlutterDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$FlutterDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FlutterDatabase extends FlutterDatabase {
  _$FlutterDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  GamesDao? _gameDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
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
            'CREATE TABLE IF NOT EXISTS `GameEntity` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `summary` TEXT NOT NULL, `storyline` TEXT NOT NULL, `slug` TEXT NOT NULL, `screenshots` TEXT NOT NULL, `cover` TEXT NOT NULL, `alternativeNames` TEXT NOT NULL, `ageRatings` TEXT NOT NULL, `websites` TEXT NOT NULL, `gameLocalizations` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  GamesDao get gameDao {
    return _gameDaoInstance ??= _$GamesDao(database, changeListener);
  }
}

class _$GamesDao extends GamesDao {
  _$GamesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _gameEntityInsertionAdapter = InsertionAdapter(
            database,
            'GameEntity',
            (GameEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'summary': item.summary,
                  'storyline': item.storyline,
                  'slug': item.slug,
                  'screenshots': (item.screenshots),
                  'cover': (item.cover),
                  'alternativeNames': (item.alternativeNames),
                  'ageRatings': (item.ageRatings),
                  'websites': (item.websites),
                  'gameLocalizations': (item.gameLocalizations)
                }),
        _gameEntityDeletionAdapter = DeletionAdapter(
            database,
            'GameEntity',
            ['id'],
            (GameEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'summary': item.summary,
                  'storyline': item.storyline,
                  'slug': item.slug,
                  'screenshots': item.screenshots,
                  'cover': item.cover,
                  'alternativeNames': item.alternativeNames,
                  'ageRatings': item.ageRatings,
                  'websites': item.websites,
                  'gameLocalizations': item.gameLocalizations
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<GameEntity> _gameEntityInsertionAdapter;

  final DeletionAdapter<GameEntity> _gameEntityDeletionAdapter;

  @override
  Future<List<GameEntity>> getPaginatedGames(
    int offset,
      { int limit =10}
  ) async {
    return _queryAdapter.queryList('SELECT * FROM GameEntity LIMIT ?2 OFFSET ?1',
        mapper: (Map<String, Object?> row) => GameEntity(
            row['id'] as int,
            row['name'] as String,
            row['summary'] as String,
            row['storyline'] as String,
            row['slug'] as String,
            row['alternativeNames'] as String,
            row['screenshots'] as String,
            row['cover'] as String,
            row['ageRatings'] as String,
            row['websites'] as String,
            row['gameLocalizations'] as String),
        arguments: [offset, limit]);
  }

  @override
  Future<void> deleteGames() async {
    await _queryAdapter.queryNoReturn('DELETE FROM GameEntity');
  }

  @override
  Future<void> insertGame(GameEntity game) async {
    await _gameEntityInsertionAdapter.insert(game, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertGames(List<GameEntity> games) async {
    await _gameEntityInsertionAdapter.insertList(
        games, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteGame(GameEntity game) async {
    await _gameEntityDeletionAdapter.delete(game);
  }
}
