import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/ImageDao.dart';
import '../entity/ImageEntity.dart';

part 'AppDatabase.g.dart';

@Database(version: 1, entities: [ImageEntity])
abstract class AppDatabase extends FloorDatabase {
  ImageDao get imageDao;
}
