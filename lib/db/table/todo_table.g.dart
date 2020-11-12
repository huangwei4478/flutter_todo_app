// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TodoTable _$_$_TodoTableFromJson(Map<String, dynamic> json) {
  return _$_TodoTable(
    id: json['id'] as String,
    categoryId: json['categoryId'] as String,
    title: json['title'] as String,
    state: json['state'] as int,
    position: json['position'] as int,
  );
}

Map<String, dynamic> _$_$_TodoTableToJson(_$_TodoTable instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'title': instance.title,
      'state': instance.state,
      'position': instance.position,
    };
