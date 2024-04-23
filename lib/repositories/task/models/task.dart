import 'package:realm/realm.dart';

part 'task.realm.dart';

@RealmModel()
class _Task {
  @PrimaryKey()
  late String id;
  late String title;
  late String description;
  late String createdAtTime;
  late String createdAtDate;
  late bool isDone;
  late bool isFavorite;
  late String category;
  late String categoryColor;

  @override
  String toString() {
    return '_Task(id: $id, title: $title, description: $description, createdAtTime: $createdAtTime, createdAtDate: $createdAtDate, isDone: $isDone, isFavorite: $isFavorite, category: $category)';
  }
}
