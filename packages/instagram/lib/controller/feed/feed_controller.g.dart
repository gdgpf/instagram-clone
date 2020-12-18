// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FeedController on _FeedControllerBase, Store {
  Computed<List<Profile>> _$profilesComputed;

  @override
  List<Profile> get profiles =>
      (_$profilesComputed ??= Computed<List<Profile>>(() => super.profiles,
              name: '_FeedControllerBase.profiles'))
          .value;
  Computed<List<Feed>> _$feedComputed;

  @override
  List<Feed> get feed =>
      (_$feedComputed ??= Computed<List<Feed>>(() => super.feed,
              name: '_FeedControllerBase.feed'))
          .value;

  final _$_profilesAtom = Atom(name: '_FeedControllerBase._profiles');

  @override
  ObservableList<Profile> get _profiles {
    _$_profilesAtom.reportRead();
    return super._profiles;
  }

  @override
  set _profiles(ObservableList<Profile> value) {
    _$_profilesAtom.reportWrite(value, super._profiles, () {
      super._profiles = value;
    });
  }

  final _$_feedAtom = Atom(name: '_FeedControllerBase._feed');

  @override
  ObservableList<Feed> get _feed {
    _$_feedAtom.reportRead();
    return super._feed;
  }

  @override
  set _feed(ObservableList<Feed> value) {
    _$_feedAtom.reportWrite(value, super._feed, () {
      super._feed = value;
    });
  }

  final _$initStateAsyncAction = AsyncAction('_FeedControllerBase.initState');

  @override
  Future initState() {
    return _$initStateAsyncAction.run(() => super.initState());
  }

  @override
  String toString() {
    return '''
profiles: ${profiles},
feed: ${feed}
    ''';
  }
}
