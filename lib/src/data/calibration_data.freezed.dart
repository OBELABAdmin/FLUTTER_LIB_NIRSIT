// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calibration_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalibrationData {

 int get progress; List<int> get ldGain; List<int> get pdGain;
/// Create a copy of CalibrationData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalibrationDataCopyWith<CalibrationData> get copyWith => _$CalibrationDataCopyWithImpl<CalibrationData>(this as CalibrationData, _$identity);

  /// Serializes this CalibrationData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalibrationData&&(identical(other.progress, progress) || other.progress == progress)&&const DeepCollectionEquality().equals(other.ldGain, ldGain)&&const DeepCollectionEquality().equals(other.pdGain, pdGain));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,progress,const DeepCollectionEquality().hash(ldGain),const DeepCollectionEquality().hash(pdGain));

@override
String toString() {
  return 'CalibrationData(progress: $progress, ldGain: $ldGain, pdGain: $pdGain)';
}


}

/// @nodoc
abstract mixin class $CalibrationDataCopyWith<$Res>  {
  factory $CalibrationDataCopyWith(CalibrationData value, $Res Function(CalibrationData) _then) = _$CalibrationDataCopyWithImpl;
@useResult
$Res call({
 int progress, List<int> ldGain, List<int> pdGain
});




}
/// @nodoc
class _$CalibrationDataCopyWithImpl<$Res>
    implements $CalibrationDataCopyWith<$Res> {
  _$CalibrationDataCopyWithImpl(this._self, this._then);

  final CalibrationData _self;
  final $Res Function(CalibrationData) _then;

/// Create a copy of CalibrationData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? progress = null,Object? ldGain = null,Object? pdGain = null,}) {
  return _then(_self.copyWith(
progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,ldGain: null == ldGain ? _self.ldGain : ldGain // ignore: cast_nullable_to_non_nullable
as List<int>,pdGain: null == pdGain ? _self.pdGain : pdGain // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [CalibrationData].
extension CalibrationDataPatterns on CalibrationData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalibrationData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalibrationData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalibrationData value)  $default,){
final _that = this;
switch (_that) {
case _CalibrationData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalibrationData value)?  $default,){
final _that = this;
switch (_that) {
case _CalibrationData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int progress,  List<int> ldGain,  List<int> pdGain)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalibrationData() when $default != null:
return $default(_that.progress,_that.ldGain,_that.pdGain);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int progress,  List<int> ldGain,  List<int> pdGain)  $default,) {final _that = this;
switch (_that) {
case _CalibrationData():
return $default(_that.progress,_that.ldGain,_that.pdGain);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int progress,  List<int> ldGain,  List<int> pdGain)?  $default,) {final _that = this;
switch (_that) {
case _CalibrationData() when $default != null:
return $default(_that.progress,_that.ldGain,_that.pdGain);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalibrationData implements CalibrationData {
  const _CalibrationData({required this.progress, required final  List<int> ldGain, required final  List<int> pdGain}): _ldGain = ldGain,_pdGain = pdGain;
  factory _CalibrationData.fromJson(Map<String, dynamic> json) => _$CalibrationDataFromJson(json);

@override final  int progress;
 final  List<int> _ldGain;
@override List<int> get ldGain {
  if (_ldGain is EqualUnmodifiableListView) return _ldGain;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ldGain);
}

 final  List<int> _pdGain;
@override List<int> get pdGain {
  if (_pdGain is EqualUnmodifiableListView) return _pdGain;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pdGain);
}


/// Create a copy of CalibrationData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalibrationDataCopyWith<_CalibrationData> get copyWith => __$CalibrationDataCopyWithImpl<_CalibrationData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalibrationDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalibrationData&&(identical(other.progress, progress) || other.progress == progress)&&const DeepCollectionEquality().equals(other._ldGain, _ldGain)&&const DeepCollectionEquality().equals(other._pdGain, _pdGain));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,progress,const DeepCollectionEquality().hash(_ldGain),const DeepCollectionEquality().hash(_pdGain));

@override
String toString() {
  return 'CalibrationData(progress: $progress, ldGain: $ldGain, pdGain: $pdGain)';
}


}

/// @nodoc
abstract mixin class _$CalibrationDataCopyWith<$Res> implements $CalibrationDataCopyWith<$Res> {
  factory _$CalibrationDataCopyWith(_CalibrationData value, $Res Function(_CalibrationData) _then) = __$CalibrationDataCopyWithImpl;
@override @useResult
$Res call({
 int progress, List<int> ldGain, List<int> pdGain
});




}
/// @nodoc
class __$CalibrationDataCopyWithImpl<$Res>
    implements _$CalibrationDataCopyWith<$Res> {
  __$CalibrationDataCopyWithImpl(this._self, this._then);

  final _CalibrationData _self;
  final $Res Function(_CalibrationData) _then;

/// Create a copy of CalibrationData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? progress = null,Object? ldGain = null,Object? pdGain = null,}) {
  return _then(_CalibrationData(
progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,ldGain: null == ldGain ? _self._ldGain : ldGain // ignore: cast_nullable_to_non_nullable
as List<int>,pdGain: null == pdGain ? _self._pdGain : pdGain // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
