import 'package:forcechallenge/repository/notification_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:built_collection/built_collection.dart';

import '../models/notification.dart' as a;

part 'message_store.g.dart';

enum MessageType { unread, read }
enum StoreState { initial, loaded, loading }

class MessageStore extends _MessageStore with _$MessageStore {
  MessageStore(notificationRepository) : super(notificationRepository);
}

abstract class _MessageStore with Store {
  final NotificationRepository _notificationRepository;

  _MessageStore(this._notificationRepository);

  @observable
  ObservableFuture<BuiltList<a.Notification>> _messagesFuture;
  @computed
  BuiltList<a.Notification> get messages => _messagesFuture?.value;
  @computed
  FutureStatus get status => _messagesFuture?.status;
  @computed
  String get errorMessage => _messagesFuture?.error?.toString();

  @computed
  BuiltList<a.Notification> get unreadMessages =>
      BuiltList<a.Notification>.from(
          messages?.where((message) => message.unread) ?? []);

  @computed
  BuiltList<a.Notification> get readMessages => BuiltList<a.Notification>.from(
      messages?.where((message) => !message.unread) ?? []);

  @computed
  int get unreadMessagesCounter => unreadMessages.length;

  // fetch messageList
  @action
  // ignore: missing_return
  Future<BuiltList<a.Notification>> fetchMessages() async {
    _messagesFuture = ObservableFuture(
        _notificationRepository.getNotification().then((response) {
      return response;
    }));
  }
}
