// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'todo_table.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
TodoTable _$TodoTableFromJson(Map<String, dynamic> json) {
  return _TodoTable.fromJson(json);
}

class _$TodoTableTearOff {
  const _$TodoTableTearOff();

// ignore: unused_element
  _TodoTable call(
      {@required String id,
      @required String categoryId,
      @required String title,
      @required int state,
      @required int position}) {
    return _TodoTable(
      id: id,
      categoryId: categoryId,
      title: title,
      state: state,
      position: position,
    );
  }
}

// ignore: unused_element
const $TodoTable = _$TodoTableTearOff();

mixin _$TodoTable {
  String get id;
  String get categoryId;
  String get title;
  int get state;
  int get position;

  Map<String, dynamic> toJson();
  $TodoTableCopyWith<TodoTable> get copyWith;
}

abstract class $TodoTableCopyWith<$Res> {
  factory $TodoTableCopyWith(TodoTable value, $Res Function(TodoTable) then) =
      _$TodoTableCopyWithImpl<$Res>;
  $Res call(
      {String id, String categoryId, String title, int state, int position});
}

class _$TodoTableCopyWithImpl<$Res> implements $TodoTableCopyWith<$Res> {
  _$TodoTableCopyWithImpl(this._value, this._then);

  final TodoTable _value;
  // ignore: unused_field
  final $Res Function(TodoTable) _then;

  @override
  $Res call({
    Object id = freezed,
    Object categoryId = freezed,
    Object title = freezed,
    Object state = freezed,
    Object position = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      categoryId:
          categoryId == freezed ? _value.categoryId : categoryId as String,
      title: title == freezed ? _value.title : title as String,
      state: state == freezed ? _value.state : state as int,
      position: position == freezed ? _value.position : position as int,
    ));
  }
}

abstract class _$TodoTableCopyWith<$Res> implements $TodoTableCopyWith<$Res> {
  factory _$TodoTableCopyWith(
          _TodoTable value, $Res Function(_TodoTable) then) =
      __$TodoTableCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id, String categoryId, String title, int state, int position});
}

class __$TodoTableCopyWithImpl<$Res> extends _$TodoTableCopyWithImpl<$Res>
    implements _$TodoTableCopyWith<$Res> {
  __$TodoTableCopyWithImpl(_TodoTable _value, $Res Function(_TodoTable) _then)
      : super(_value, (v) => _then(v as _TodoTable));

  @override
  _TodoTable get _value => super._value as _TodoTable;

  @override
  $Res call({
    Object id = freezed,
    Object categoryId = freezed,
    Object title = freezed,
    Object state = freezed,
    Object position = freezed,
  }) {
    return _then(_TodoTable(
      id: id == freezed ? _value.id : id as String,
      categoryId:
          categoryId == freezed ? _value.categoryId : categoryId as String,
      title: title == freezed ? _value.title : title as String,
      state: state == freezed ? _value.state : state as int,
      position: position == freezed ? _value.position : position as int,
    ));
  }
}

@JsonSerializable()
class _$_TodoTable with DiagnosticableTreeMixin implements _TodoTable {
  _$_TodoTable(
      {@required this.id,
      @required this.categoryId,
      @required this.title,
      @required this.state,
      @required this.position})
      : assert(id != null),
        assert(categoryId != null),
        assert(title != null),
        assert(state != null),
        assert(position != null);

  factory _$_TodoTable.fromJson(Map<String, dynamic> json) =>
      _$_$_TodoTableFromJson(json);

  @override
  final String id;
  @override
  final String categoryId;
  @override
  final String title;
  @override
  final int state;
  @override
  final int position;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TodoTable(id: $id, categoryId: $categoryId, title: $title, state: $state, position: $position)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TodoTable'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('categoryId', categoryId))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('state', state))
      ..add(DiagnosticsProperty('position', position));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TodoTable &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.categoryId, categoryId) ||
                const DeepCollectionEquality()
                    .equals(other.categoryId, categoryId)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)) &&
            (identical(other.position, position) ||
                const DeepCollectionEquality()
                    .equals(other.position, position)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(categoryId) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(state) ^
      const DeepCollectionEquality().hash(position);

  @override
  _$TodoTableCopyWith<_TodoTable> get copyWith =>
      __$TodoTableCopyWithImpl<_TodoTable>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_TodoTableToJson(this);
  }
}

abstract class _TodoTable implements TodoTable {
  factory _TodoTable(
      {@required String id,
      @required String categoryId,
      @required String title,
      @required int state,
      @required int position}) = _$_TodoTable;

  factory _TodoTable.fromJson(Map<String, dynamic> json) =
      _$_TodoTable.fromJson;

  @override
  String get id;
  @override
  String get categoryId;
  @override
  String get title;
  @override
  int get state;
  @override
  int get position;
  @override
  _$TodoTableCopyWith<_TodoTable> get copyWith;
}
