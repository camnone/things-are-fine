// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Task extends _Task with RealmEntity, RealmObjectBase, RealmObject {
  Task(
    String id,
    String title,
    String description,
    String createdAtTime,
    String createdAtDate,
    bool isDone,
    bool isFavorite,
    String category,
    String categoryColor,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'createdAtTime', createdAtTime);
    RealmObjectBase.set(this, 'createdAtDate', createdAtDate);
    RealmObjectBase.set(this, 'isDone', isDone);
    RealmObjectBase.set(this, 'isFavorite', isFavorite);
    RealmObjectBase.set(this, 'category', category);
    RealmObjectBase.set(this, 'categoryColor', categoryColor);
  }

  Task._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  String get createdAtTime =>
      RealmObjectBase.get<String>(this, 'createdAtTime') as String;
  @override
  set createdAtTime(String value) =>
      RealmObjectBase.set(this, 'createdAtTime', value);

  @override
  String get createdAtDate =>
      RealmObjectBase.get<String>(this, 'createdAtDate') as String;
  @override
  set createdAtDate(String value) =>
      RealmObjectBase.set(this, 'createdAtDate', value);

  @override
  bool get isDone => RealmObjectBase.get<bool>(this, 'isDone') as bool;
  @override
  set isDone(bool value) => RealmObjectBase.set(this, 'isDone', value);

  @override
  bool get isFavorite => RealmObjectBase.get<bool>(this, 'isFavorite') as bool;
  @override
  set isFavorite(bool value) => RealmObjectBase.set(this, 'isFavorite', value);

  @override
  String get category =>
      RealmObjectBase.get<String>(this, 'category') as String;
  @override
  set category(String value) => RealmObjectBase.set(this, 'category', value);

  @override
  String get categoryColor =>
      RealmObjectBase.get<String>(this, 'categoryColor') as String;
  @override
  set categoryColor(String value) =>
      RealmObjectBase.set(this, 'categoryColor', value);

  @override
  Stream<RealmObjectChanges<Task>> get changes =>
      RealmObjectBase.getChanges<Task>(this);

  @override
  Task freeze() => RealmObjectBase.freezeObject<Task>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'title': title.toEJson(),
      'description': description.toEJson(),
      'createdAtTime': createdAtTime.toEJson(),
      'createdAtDate': createdAtDate.toEJson(),
      'isDone': isDone.toEJson(),
      'isFavorite': isFavorite.toEJson(),
      'category': category.toEJson(),
      'categoryColor': categoryColor.toEJson(),
    };
  }

  static EJsonValue _toEJson(Task value) => value.toEJson();
  static Task _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'title': EJsonValue title,
        'description': EJsonValue description,
        'createdAtTime': EJsonValue createdAtTime,
        'createdAtDate': EJsonValue createdAtDate,
        'isDone': EJsonValue isDone,
        'isFavorite': EJsonValue isFavorite,
        'category': EJsonValue category,
        'categoryColor': EJsonValue categoryColor,
      } =>
        Task(
          fromEJson(id),
          fromEJson(title),
          fromEJson(description),
          fromEJson(createdAtTime),
          fromEJson(createdAtDate),
          fromEJson(isDone),
          fromEJson(isFavorite),
          fromEJson(category),
          fromEJson(categoryColor),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Task._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Task, 'Task', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('createdAtTime', RealmPropertyType.string),
      SchemaProperty('createdAtDate', RealmPropertyType.string),
      SchemaProperty('isDone', RealmPropertyType.bool),
      SchemaProperty('isFavorite', RealmPropertyType.bool),
      SchemaProperty('category', RealmPropertyType.string),
      SchemaProperty('categoryColor', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
