// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'battery_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BatteryInfo {

 int get status; int get level;
/// Create a copy of BatteryInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BatteryInfoCopyWith<BatteryInfo> get copyWith => _$BatteryInfoCopyWithImpl<BatteryInfo>(this as BatteryInfo, _$identity);

  /// Serializes this BatteryInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BatteryInfo&&(identical(other.status, status) || other.status == status)&&(identical(other.level, level) || other.level == level));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,level);

@override
String toString() {
  return 'BatteryInfo(status: $status, level: $level)';
}


}

/// @nodoc
abstract mixin class $BatteryInfoCopyWith<$Res>  {
  factory $BatteryInfoCopyWith(BatteryInfo value, $Res Function(BatteryInfo) _then) = _$BatteryInfoCopyWithImpl;
@useResult
$Res call({
 int status, int level
});




}
/// @nodoc
class _$BatteryInfoCopyWithImpl<$Res>
    implements $BatteryInfoCopyWith<$Res> {
  _$BatteryInfoCopyWithImpl(this._self, this._then);

  final BatteryInfo _self;
  final $Res Function(BatteryInfo) _then;

/// Create a copy of BatteryInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? level = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BatteryInfo].
extension BatteryInfoPatterns on BatteryInfo {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BatteryInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BatteryInfo() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BatteryInfo value)  $default,){
final _that = this;
switch (_that) {
case _BatteryInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BatteryInfo value)?  $default,){
final _that = this;
switch (_that) {
case _BatteryInfo() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int status,  int level)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BatteryInfo() when $default != null:
return $default(_that.status,_that.level);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int status,  int level)  $default,) {final _that = this;
switch (_that) {
case _BatteryInfo():
return $default(_that.status,_that.level);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int status,  int level)?  $default,) {final _that = this;
switch (_that) {
case _BatteryInfo() when $default != null:
return $default(_that.status,_that.level);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BatteryInfo implements BatteryInfo {
  const _BatteryInfo({required this.status, required this.level});
  factory _BatteryInfo.fromJson(Map<String, dynamic> json) => _$BatteryInfoFromJson(json);

@override final  int status;
@override final  int level;

/// Create a copy of BatteryInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BatteryInfoCopyWith<_BatteryInfo> get copyWith => __$BatteryInfoCopyWithImpl<_BatteryInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BatteryInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BatteryInfo&&(identical(other.status, status) || other.status == status)&&(identical(other.level, level) || other.level == level));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,level);

@override
String toString() {
  return 'BatteryInfo(status: $status, level: $level)';
}


}

/// @nodoc
abstract mixin class _$BatteryInfoCopyWith<$Res> implements $BatteryInfoCopyWith<$Res> {
  factory _$BatteryInfoCopyWith(_BatteryInfo value, $Res Function(_BatteryInfo) _then) = __$BatteryInfoCopyWithImpl;
@override @useResult
$Res call({
 int status, int level
});




}
/// @nodoc
class __$BatteryInfoCopyWithImpl<$Res>
    implements _$BatteryInfoCopyWith<$Res> {
  __$BatteryInfoCopyWithImpl(this._self, this._then);

  final _BatteryInfo _self;
  final $Res Function(_BatteryInfo) _then;

/// Create a copy of BatteryInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? level = null,}) {
  return _then(_BatteryInfo(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
