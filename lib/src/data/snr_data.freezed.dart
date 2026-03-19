// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'snr_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SnrData {

 int get index; int get snrLimit; List<int> get snr780; List<int> get snr850;
/// Create a copy of SnrData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SnrDataCopyWith<SnrData> get copyWith => _$SnrDataCopyWithImpl<SnrData>(this as SnrData, _$identity);

  /// Serializes this SnrData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SnrData&&(identical(other.index, index) || other.index == index)&&(identical(other.snrLimit, snrLimit) || other.snrLimit == snrLimit)&&const DeepCollectionEquality().equals(other.snr780, snr780)&&const DeepCollectionEquality().equals(other.snr850, snr850));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index,snrLimit,const DeepCollectionEquality().hash(snr780),const DeepCollectionEquality().hash(snr850));

@override
String toString() {
  return 'SnrData(index: $index, snrLimit: $snrLimit, snr780: $snr780, snr850: $snr850)';
}


}

/// @nodoc
abstract mixin class $SnrDataCopyWith<$Res>  {
  factory $SnrDataCopyWith(SnrData value, $Res Function(SnrData) _then) = _$SnrDataCopyWithImpl;
@useResult
$Res call({
 int index, int snrLimit, List<int> snr780, List<int> snr850
});




}
/// @nodoc
class _$SnrDataCopyWithImpl<$Res>
    implements $SnrDataCopyWith<$Res> {
  _$SnrDataCopyWithImpl(this._self, this._then);

  final SnrData _self;
  final $Res Function(SnrData) _then;

/// Create a copy of SnrData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? snrLimit = null,Object? snr780 = null,Object? snr850 = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,snrLimit: null == snrLimit ? _self.snrLimit : snrLimit // ignore: cast_nullable_to_non_nullable
as int,snr780: null == snr780 ? _self.snr780 : snr780 // ignore: cast_nullable_to_non_nullable
as List<int>,snr850: null == snr850 ? _self.snr850 : snr850 // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [SnrData].
extension SnrDataPatterns on SnrData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SnrData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SnrData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SnrData value)  $default,){
final _that = this;
switch (_that) {
case _SnrData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SnrData value)?  $default,){
final _that = this;
switch (_that) {
case _SnrData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  int snrLimit,  List<int> snr780,  List<int> snr850)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SnrData() when $default != null:
return $default(_that.index,_that.snrLimit,_that.snr780,_that.snr850);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  int snrLimit,  List<int> snr780,  List<int> snr850)  $default,) {final _that = this;
switch (_that) {
case _SnrData():
return $default(_that.index,_that.snrLimit,_that.snr780,_that.snr850);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  int snrLimit,  List<int> snr780,  List<int> snr850)?  $default,) {final _that = this;
switch (_that) {
case _SnrData() when $default != null:
return $default(_that.index,_that.snrLimit,_that.snr780,_that.snr850);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SnrData implements SnrData {
  const _SnrData({required this.index, required this.snrLimit, required final  List<int> snr780, required final  List<int> snr850}): _snr780 = snr780,_snr850 = snr850;
  factory _SnrData.fromJson(Map<String, dynamic> json) => _$SnrDataFromJson(json);

@override final  int index;
@override final  int snrLimit;
 final  List<int> _snr780;
@override List<int> get snr780 {
  if (_snr780 is EqualUnmodifiableListView) return _snr780;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_snr780);
}

 final  List<int> _snr850;
@override List<int> get snr850 {
  if (_snr850 is EqualUnmodifiableListView) return _snr850;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_snr850);
}


/// Create a copy of SnrData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SnrDataCopyWith<_SnrData> get copyWith => __$SnrDataCopyWithImpl<_SnrData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SnrDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SnrData&&(identical(other.index, index) || other.index == index)&&(identical(other.snrLimit, snrLimit) || other.snrLimit == snrLimit)&&const DeepCollectionEquality().equals(other._snr780, _snr780)&&const DeepCollectionEquality().equals(other._snr850, _snr850));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index,snrLimit,const DeepCollectionEquality().hash(_snr780),const DeepCollectionEquality().hash(_snr850));

@override
String toString() {
  return 'SnrData(index: $index, snrLimit: $snrLimit, snr780: $snr780, snr850: $snr850)';
}


}

/// @nodoc
abstract mixin class _$SnrDataCopyWith<$Res> implements $SnrDataCopyWith<$Res> {
  factory _$SnrDataCopyWith(_SnrData value, $Res Function(_SnrData) _then) = __$SnrDataCopyWithImpl;
@override @useResult
$Res call({
 int index, int snrLimit, List<int> snr780, List<int> snr850
});




}
/// @nodoc
class __$SnrDataCopyWithImpl<$Res>
    implements _$SnrDataCopyWith<$Res> {
  __$SnrDataCopyWithImpl(this._self, this._then);

  final _SnrData _self;
  final $Res Function(_SnrData) _then;

/// Create a copy of SnrData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? snrLimit = null,Object? snr780 = null,Object? snr850 = null,}) {
  return _then(_SnrData(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,snrLimit: null == snrLimit ? _self.snrLimit : snrLimit // ignore: cast_nullable_to_non_nullable
as int,snr780: null == snr780 ? _self._snr780 : snr780 // ignore: cast_nullable_to_non_nullable
as List<int>,snr850: null == snr850 ? _self._snr850 : snr850 // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
