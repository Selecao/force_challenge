import 'package:mobx/mobx.dart';
import 'package:dio/dio.dart';
import 'package:built_collection/built_collection.dart';

import 'package:forcechallenge/services/networking.dart';
import 'package:forcechallenge/models/message.dart';
import 'package:forcechallenge/models/serializers.dart';

part 'message_store.g.dart';

enum MessageType { unread, read }
enum StoreState { initial, loaded, loading }

class MessageStore extends _MessageStore with _$MessageStore {
  MessageStore(NetworkHelper networkHelper) : super(networkHelper);
}

abstract class _MessageStore with Store {
  final NetworkHelper _networkHelper;

  _MessageStore(this._networkHelper);

  @observable
  ObservableFuture<BuiltList<Message>> _messagesFuture;
  @observable
  BuiltList<Message> messages;

  @observable
  String errorMessage;

  @computed
  int get unreadMessagesCounter => unreadMessages.length;

  @computed
  BuiltList<Message> get unreadMessages =>
      BuiltList<Message>.from(messages.where((message) => message.unread));

  @computed
  BuiltList<Message> get readMessages =>
      BuiltList<Message>.from(messages.where((message) => !message.unread));

  @computed
  StoreState get state {
    // If the user has not yet push the button firstLoad or there has been an error
    if (_messagesFuture == null ||
        _messagesFuture.status == FutureStatus.rejected) {
      return StoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _messagesFuture.status == FutureStatus.pending
        ? StoreState.loading
        : StoreState.loaded;
  }

  /*@action
  Future fetchMessages() => _messagesFuture =
          ObservableFuture(_networkHelper.getData().then((response) {
        return _handleListResponse<Message>(response);
      }));*/

  // fetch unfiltered messageList
  @action
  Future fetchMessages() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch message from the network and wrap the regular Future into an observable.
      // This _messagesFuture triggers updates to the computed state property.
      _messagesFuture =
          ObservableFuture(_networkHelper.getData().then((response) {
        return _handleListResponse<Message>(response);
      }));
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      messages = await _messagesFuture;
    } on Exception {
      errorMessage =
          "Не могу получить данные. Соединение с интернетом установлено?";
    }
  }

  // if response from server is [Iterable] then use this function:
  BuiltList<T> _handleListResponse<T>(Response response) {
    if (response.data == null) {
      return BuiltList<T>();
    }
    var rawList = (response.data as List<dynamic>);
    return BuiltList<T>(rawList.map((item) {
      if (T is String) {
        return item;
      } else {
        return serializers.deserializeWith<T>(
            serializers.serializerForType(T), item);
      }
    }).toList());
  }
}
