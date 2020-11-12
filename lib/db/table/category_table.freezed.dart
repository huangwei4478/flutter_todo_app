// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'category_table.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
CategoryTable _$CategoryTableFromJson(Map<String, dynamic> json) {
  return _CategoryTable.fromJson(json);
}

class _$CategoryTableTearOff {
  const _$CategoryTableTearOff();

// ignore: unused_element
  _CategoryTable call({@required String id, @required String title}) {
    return _CategoryTable(
      id: id,
      title: title,
    );
  }
}

// ignore: unused_element
const $CategoryTable = _$CategoryTableTearOff();

mixin _$CategoryTable {
  String get id;
  String get title;

  Map<String, dynamic> toJson();
  $CategoryTableCopyWith<CategoryTable> get copyWith;
}

abstract class $CategoryTableCopyWith<$Res> {
  factory $CategoryTableCopyWith(
          CategoryTable value, $Res Function(CategoryTable) then) =
      _$CategoryTableCopyWithImpl<$Res>;
  $Res call({String id, String title});
}

class _$CategoryTableCopyWithImpl<$Res>
    implements $CategoryTableCopyWith<$Res> {
  _$CategoryTableCopyWithImpl(this._value, this._then);

  final CategoryTable _value;
  // ignore: unused_field
  final $Res Function(CategoryTable) _then;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      title: title == freezed ? _value.title : title as String,
    ));
  }
}

abstract class _$CategoryTableCopyWith<$Res>
    implements $CategoryTableCopyWith<$Res> {
  factory _$CategoryTableCopyWith(
          _CategoryTable value, $Res Function(_CategoryTable) then) =
      __$CategoryTableCopyWithImpl<$Res>;
  @override
  $Res call({String id, String title});
}

class __$CategoryTableCopyWithImpl<$Res>
    extends _$CategoryTableCopyWithImpl<$Res>
    implements _$CategoryTableCopyWith<$Res> {
  __$CategoryTableCopyWithImpl(
      _CategoryTable _value, $Res Function(_CategoryTable) _then)
      : super(_value, (v) => _then(v as _CategoryTable));

  @override
  _CategoryTable get _value => super._value as _CategoryTable;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
  }) {
    return _then(_CategoryTable(
      id: id == freezed ? _value.id : id as String,
      title: title == freezed ? _value.title : title as String,
    ));
  }
}

@JsonSerializable()
class _$_CategoryTable with DiagnosticableTreeMixin implements _CategoryTable {
  _$_CategoryTable({@required this.id, @required this.title})
      : assert(id != null),
        assert(title != null);

  factory _$_CategoryTable.fromJson(Map<String, dynamic> json) =>
      _$_$_CategoryTableFromJson(json);

  @override
  final String id;
  @override
  final String title;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CategoryTable(id: $id, title: $title)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CategoryTable'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CategoryTable &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title);

  @override
  _$CategoryTableCopyWith<_CategoryTable> get copyWith =>
      __$CategoryTableCopyWithImpl<_CategoryTable>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CategoryTableToJson(this);
  }
}

abstract class _CategoryTable implements CategoryTable {
  factory _CategoryTable({@required String id, @required String title}) =
      _$_CategoryTable;

  factory _CategoryTable.fromJson(Map<String, dynamic> json) =
      _$_CategoryTable.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  _$CategoryTableCopyWith<_CategoryTable> get copyWith;
}
