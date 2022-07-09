// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'material.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MaterialData _$MaterialDataFromJson(Map<String, dynamic> json) {
  return _MaterialData.fromJson(json);
}

/// @nodoc
mixin _$MaterialData {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  CategoryData? get category => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MaterialDataCopyWith<MaterialData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaterialDataCopyWith<$Res> {
  factory $MaterialDataCopyWith(
          MaterialData value, $Res Function(MaterialData) then) =
      _$MaterialDataCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String title,
      DateTime createdAt,
      CategoryData? category,
      String? imageUrl});
}

/// @nodoc
class _$MaterialDataCopyWithImpl<$Res> implements $MaterialDataCopyWith<$Res> {
  _$MaterialDataCopyWithImpl(this._value, this._then);

  final MaterialData _value;
  // ignore: unused_field
  final $Res Function(MaterialData) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? createdAt = freezed,
    Object? category = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryData?,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_MaterialDataCopyWith<$Res>
    implements $MaterialDataCopyWith<$Res> {
  factory _$$_MaterialDataCopyWith(
          _$_MaterialData value, $Res Function(_$_MaterialData) then) =
      __$$_MaterialDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String title,
      DateTime createdAt,
      CategoryData? category,
      String? imageUrl});
}

/// @nodoc
class __$$_MaterialDataCopyWithImpl<$Res>
    extends _$MaterialDataCopyWithImpl<$Res>
    implements _$$_MaterialDataCopyWith<$Res> {
  __$$_MaterialDataCopyWithImpl(
      _$_MaterialData _value, $Res Function(_$_MaterialData) _then)
      : super(_value, (v) => _then(v as _$_MaterialData));

  @override
  _$_MaterialData get _value => super._value as _$_MaterialData;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? createdAt = freezed,
    Object? category = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$_MaterialData(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryData?,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MaterialData with DiagnosticableTreeMixin implements _MaterialData {
  const _$_MaterialData(
      {required this.id,
      required this.title,
      required this.createdAt,
      this.category,
      this.imageUrl});

  factory _$_MaterialData.fromJson(Map<String, dynamic> json) =>
      _$$_MaterialDataFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final DateTime createdAt;
  @override
  final CategoryData? category;
  @override
  final String? imageUrl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MaterialData(id: $id, title: $title, createdAt: $createdAt, category: $category, imageUrl: $imageUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MaterialData'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('imageUrl', imageUrl));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MaterialData &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.category, category) &&
            const DeepCollectionEquality().equals(other.imageUrl, imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(category),
      const DeepCollectionEquality().hash(imageUrl));

  @JsonKey(ignore: true)
  @override
  _$$_MaterialDataCopyWith<_$_MaterialData> get copyWith =>
      __$$_MaterialDataCopyWithImpl<_$_MaterialData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MaterialDataToJson(this);
  }
}

abstract class _MaterialData implements MaterialData {
  const factory _MaterialData(
      {required final String id,
      required final String title,
      required final DateTime createdAt,
      final CategoryData? category,
      final String? imageUrl}) = _$_MaterialData;

  factory _MaterialData.fromJson(Map<String, dynamic> json) =
      _$_MaterialData.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  DateTime get createdAt;
  @override
  CategoryData? get category;
  @override
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_MaterialDataCopyWith<_$_MaterialData> get copyWith =>
      throw _privateConstructorUsedError;
}
