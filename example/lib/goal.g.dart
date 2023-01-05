// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:example/first_page.dart' as _i3;
import 'package:example/second_page.dart' as _i5;
import 'package:flutter/material.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
_i1.GetIt MainNavigator(
  _i1.GetIt getIt, {
  String environment,
  _i2.EnvironmentFilter environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.FirstPage>(() => _i3.FirstPage(key: gh<_i4.Key>()));
  gh.factory<_i5.SecondPage>(
    () => _i5.SecondPage(key: gh<_i4.Key>()),
    instanceName: 'custom-name',
  );
  return getIt;
}
