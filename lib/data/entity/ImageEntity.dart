import 'package:floor/floor.dart';

@Entity(tableName: 'images')
class ImageEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String imagePath;

  ImageEntity(this.id, this.imagePath);
}
