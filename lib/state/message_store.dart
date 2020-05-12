import 'package:forcechallenge/repository/notification_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:built_collection/built_collection.dart';

import '../models/message.dart';
import '../models/serializers.dart';

part 'message_store.g.dart';

enum MessageType { unread, read }
enum StoreState { initial, loaded, loading }

class MessageStore extends _MessageStore with _$MessageStore {
  MessageStore();
}

abstract class _MessageStore with Store {
  static NotificationRepository _notificationRepository =
      NotificationRepository();

  _MessageStore();

  @observable
  ObservableFuture<BuiltList<Message>> _messagesFuture;
  @observable
  BuiltList<Message> messages;

  @observable
  String errorMessage;

  @observable
  int unreadMessagesCounter = 0;

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

  @action
  void updateUnreadCounter() {
    unreadMessagesCounter =
        unreadMessages.isNotEmpty ? unreadMessages.length : 0;
  }
  /*@action
  Future fetchMessages() => _messagesFuture =
          ObservableFuture(_networkHelper.getData().then((response) {
        return _handleListResponse<Message>(response);
      }));*/

  // fetch messageList
  @action
  // ignore: missing_return
  Future<BuiltList<Message>> fetchMessages() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch message from the network and wrap the regular Future into an observable.
      // This _messagesFuture triggers updates to the computed state property.
      _messagesFuture = ObservableFuture(
          _notificationRepository.getNotification().then((response) {
        return response;
      }));
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      messages = await _messagesFuture;
    } on Exception {
      errorMessage =
          "Не могу получить данные. Соединение с интернетом установлено?";
    }
  }
}
