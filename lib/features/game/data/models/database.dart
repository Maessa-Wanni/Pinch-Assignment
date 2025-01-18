import 'dart:async';
import 'package:Pinch_assignment/features/game/data/models/game_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'game_dao.dart';

part 'database.g.dart';

@Database(version: 1, entities: [GameEntity])
abstract class FlutterDatabase extends FloorDatabase {
  GamesDao get gameDao;
}
