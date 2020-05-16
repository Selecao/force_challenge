import 'package:built_collection/built_collection.dart';

import '../models/notification.dart';
import '../services/api_service.dart';

class NotificationRepository {
  ApiService httpClient = ApiService();

  Future<BuiltList<Notification>> getNotification() async {
    return httpClient.getList('/5e85a947300000290097b2b4?mocky-delay=2000ms');
  }
}
