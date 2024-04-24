import 'package:floor/floor.dart';
import '../entity/ImageEntity.dart';


@dao
abstract class ImageDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertImage(ImageEntity image);

  @Query('SELECT * FROM images')
  Future<List<ImageEntity>> getAllImages();
}
