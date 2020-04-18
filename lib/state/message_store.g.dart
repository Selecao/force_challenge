// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MessageStore on _MessageStore, Store {
  Computed<int> _$unreadMessagesCounterComputed;

  @override
  int get unreadMessagesCounter => (_$unreadMessagesCounterComputed ??=
          Computed<int>(() => super.unreadMessagesCounter))
      .value;
  Computed<BuiltList<Message>> _$unreadMessagesComputed;

  @override
  BuiltList<Message> get unreadMessages => (_$unreadMessagesComputed ??=
          Computed<BuiltList<Message>>(() => super.unreadMessages))
      .value;
  Computed<BuiltList<Message>> _$readMessagesComputed;

  @override
  BuiltList<Message> get readMessages => (_$readMessagesComputed ??=
          Computed<BuiltList<Message>>(() => super.readMessages))
      .value;
  Computed<StoreState> _$stateComputed;

  @override
  StoreState get state =>
      (_$stateComputed ??= Computed<StoreState>(() => super.state)).value;

  final _$_messagesFutureAtom = Atom(name: '_MessageStore._messagesFuture');

  @override
  ObservableFuture<BuiltList<Message>> get _messagesFuture {
    _$_messagesFutureAtom.context.enforceReadPolicy(_$_messagesFutureAtom);
    _$_messagesFutureAtom.reportObserved();
    return super._messagesFuture;
  }

  @override
  set _messagesFuture(ObservableFuture<BuiltList<Message>> value) {
    _$_messagesFutureAtom.context.conditionallyRunInAction(() {
      super._messagesFuture = value;
      _$_messagesFutureAtom.reportChanged();
    }, _$_messagesFutureAtom, name: '${_$_messagesFutureAtom.name}_set');
  }

  final _$messagesAtom = Atom(name: '_MessageStore.messages');

  @override
  BuiltList<Message> get messages {
    _$messagesAtom.context.enforceReadPolicy(_$messagesAtom);
    _$messagesAtom.reportObserved();
    return super.messages;
  }

  @override
  set messages(BuiltList<Message> value) {
    _$messagesAtom.context.conditionallyRunInAction(() {
      super.messages = value;
      _$messagesAtom.reportChanged();
    }, _$messagesAtom, name: '${_$messagesAtom.name}_set');
  }

  final _$errorMessageAtom = Atom(name: '_MessageStore.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.context.enforceReadPolicy(_$errorMessageAtom);
    _$errorMessageAtom.reportObserved();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.context.conditionallyRunInAction(() {
      super.errorMessage = value;
      _$errorMessageAtom.reportChanged();
    }, _$errorMessageAtom, name: '${_$errorMessageAtom.name}_set');
  }

  final _$fetchMessagesAsyncAction = AsyncAction('fetchMessages');

  @override
  Future<dynamic> fetchMessages() {
    return _$fetchMessagesAsyncAction.run(() => super.fetchMessages());
  }

  @override
  String toString() {
    final string =
        'messages: ${messages.toString()},errorMessage: ${errorMessage.toString()},unreadMessagesCounter: ${unreadMessagesCounter.toString()},unreadMessages: ${unreadMessages.toString()},readMessages: ${readMessages.toString()},state: ${state.toString()}';
    return '{$string}';
  }
}
