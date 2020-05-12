// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MessageStore on _MessageStore, Store {
  Computed<BuiltList<Notification>> _$unreadMessagesComputed;

  @override
  BuiltList<Notification> get unreadMessages => (_$unreadMessagesComputed ??=
          Computed<BuiltList<Notification>>(() => super.unreadMessages))
      .value;
  Computed<BuiltList<Notification>> _$readMessagesComputed;

  @override
  BuiltList<Notification> get readMessages => (_$readMessagesComputed ??=
          Computed<BuiltList<Notification>>(() => super.readMessages))
      .value;
  Computed<StoreState> _$stateComputed;

  @override
  StoreState get state =>
      (_$stateComputed ??= Computed<StoreState>(() => super.state)).value;

  final _$_messagesFutureAtom = Atom(name: '_MessageStore._messagesFuture');

  @override
  ObservableFuture<BuiltList<Notification>> get _messagesFuture {
    _$_messagesFutureAtom.context.enforceReadPolicy(_$_messagesFutureAtom);
    _$_messagesFutureAtom.reportObserved();
    return super._messagesFuture;
  }

  @override
  set _messagesFuture(ObservableFuture<BuiltList<Notification>> value) {
    _$_messagesFutureAtom.context.conditionallyRunInAction(() {
      super._messagesFuture = value;
      _$_messagesFutureAtom.reportChanged();
    }, _$_messagesFutureAtom, name: '${_$_messagesFutureAtom.name}_set');
  }

  final _$messagesAtom = Atom(name: '_MessageStore.messages');

  @override
  BuiltList<Notification> get messages {
    _$messagesAtom.context.enforceReadPolicy(_$messagesAtom);
    _$messagesAtom.reportObserved();
    return super.messages;
  }

  @override
  set messages(BuiltList<Notification> value) {
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

  final _$unreadMessagesCounterAtom =
      Atom(name: '_MessageStore.unreadMessagesCounter');

  @override
  int get unreadMessagesCounter {
    _$unreadMessagesCounterAtom.context
        .enforceReadPolicy(_$unreadMessagesCounterAtom);
    _$unreadMessagesCounterAtom.reportObserved();
    return super.unreadMessagesCounter;
  }

  @override
  set unreadMessagesCounter(int value) {
    _$unreadMessagesCounterAtom.context.conditionallyRunInAction(() {
      super.unreadMessagesCounter = value;
      _$unreadMessagesCounterAtom.reportChanged();
    }, _$unreadMessagesCounterAtom,
        name: '${_$unreadMessagesCounterAtom.name}_set');
  }

  final _$fetchMessagesAsyncAction = AsyncAction('fetchMessages');

  @override
  Future<BuiltList<Notification>> fetchMessages() {
    return _$fetchMessagesAsyncAction.run(() => super.fetchMessages());
  }

  final _$_MessageStoreActionController =
      ActionController(name: '_MessageStore');

  @override
  void updateUnreadCounter() {
    final _$actionInfo = _$_MessageStoreActionController.startAction();
    try {
      return super.updateUnreadCounter();
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'messages: ${messages.toString()},errorMessage: ${errorMessage.toString()},unreadMessagesCounter: ${unreadMessagesCounter.toString()},unreadMessages: ${unreadMessages.toString()},readMessages: ${readMessages.toString()},state: ${state.toString()}';
    return '{$string}';
  }
}
