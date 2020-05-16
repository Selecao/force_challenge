// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MessageStore on _MessageStore, Store {
  Computed<BuiltList<a.Notification>> _$messagesComputed;

  @override
  BuiltList<a.Notification> get messages => (_$messagesComputed ??=
          Computed<BuiltList<a.Notification>>(() => super.messages,
              name: '_MessageStore.messages'))
      .value;
  Computed<FutureStatus> _$statusComputed;

  @override
  FutureStatus get status =>
      (_$statusComputed ??= Computed<FutureStatus>(() => super.status,
              name: '_MessageStore.status'))
          .value;
  Computed<String> _$errorMessageComputed;

  @override
  String get errorMessage =>
      (_$errorMessageComputed ??= Computed<String>(() => super.errorMessage,
              name: '_MessageStore.errorMessage'))
          .value;
  Computed<BuiltList<a.Notification>> _$unreadMessagesComputed;

  @override
  BuiltList<a.Notification> get unreadMessages => (_$unreadMessagesComputed ??=
          Computed<BuiltList<a.Notification>>(() => super.unreadMessages,
              name: '_MessageStore.unreadMessages'))
      .value;
  Computed<BuiltList<a.Notification>> _$readMessagesComputed;

  @override
  BuiltList<a.Notification> get readMessages => (_$readMessagesComputed ??=
          Computed<BuiltList<a.Notification>>(() => super.readMessages,
              name: '_MessageStore.readMessages'))
      .value;
  Computed<int> _$unreadMessagesCounterComputed;

  @override
  int get unreadMessagesCounter => (_$unreadMessagesCounterComputed ??=
          Computed<int>(() => super.unreadMessagesCounter,
              name: '_MessageStore.unreadMessagesCounter'))
      .value;

  final _$_messagesFutureAtom = Atom(name: '_MessageStore._messagesFuture');

  @override
  ObservableFuture<BuiltList<a.Notification>> get _messagesFuture {
    _$_messagesFutureAtom.reportRead();
    return super._messagesFuture;
  }

  @override
  set _messagesFuture(ObservableFuture<BuiltList<a.Notification>> value) {
    _$_messagesFutureAtom.reportWrite(value, super._messagesFuture, () {
      super._messagesFuture = value;
    });
  }

  final _$fetchMessagesAsyncAction = AsyncAction('_MessageStore.fetchMessages');

  @override
  Future<BuiltList<a.Notification>> fetchMessages() {
    return _$fetchMessagesAsyncAction.run(() => super.fetchMessages());
  }

  @override
  String toString() {
    return '''
messages: ${messages},
status: ${status},
errorMessage: ${errorMessage},
unreadMessages: ${unreadMessages},
readMessages: ${readMessages},
unreadMessagesCounter: ${unreadMessagesCounter}
    ''';
  }
}
