import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:forcechallenge/state/message_store.dart';
import 'package:forcechallenge/widgets/message_sliver_widget.dart';
import 'package:forcechallenge/widgets/page_sliver_header.dart';
import 'package:forcechallenge/widgets/text_and_button.dart';
import 'package:forcechallenge/widgets/custom_text.dart';
import 'package:forcechallenge/constants.dart' as constants;

class MessageItemsView extends StatelessWidget {
  const MessageItemsView(this.messageStore);

  final MessageStore messageStore;

  @override
  Widget build(BuildContext context) => Observer(
        // ignore: missing_return
        builder: (_) {
          switch (messageStore.state) {
            case StoreState.initial:
              return buildInitialInput();

            case StoreState.loading:
              return buildLoading();

            case StoreState.loaded:
              messageStore.updateUnreadCounter();

              return RefreshIndicator(
                onRefresh: _refresh,
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverPersistentHeader(
                      pinned: true,
                      floating: true,
                      delegate: PageSliverHeader(
                        minExtent: 100.0,
                        maxExtent: 250.0,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: CustomText(text: 'Последние'),
                    ),
                    MessageSliverListWidget(
                      backgroundColor: constants.greyLight,
                      notificationList: messageStore.unreadMessages,
                    ),
                    SliverToBoxAdapter(child: CustomText(text: 'Ранее')),
                    MessageSliverListWidget(
                      backgroundColor: null,
                      notificationList: messageStore.readMessages,
                    ),
                    SliverFillRemaining(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'Это все сообщения!',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
          }
        },
      );

  Widget buildInitialInput() {
    return CustomScrollView(slivers: [
      SliverPersistentHeader(
        pinned: true,
        floating: true,
        delegate: PageSliverHeader(
          minExtent: 100.0,
          maxExtent: 250.0,
        ),
      ),
      SliverToBoxAdapter(
        child: TextAndButton(
          content: """
                <h3><center>Вы впервые?</center></h3>
                <center>Это очень важное сообщение. Пожалуйста, нажмите на кнопку ниже.</center>
                """,
          buttonText: 'Загрузить уведомления',
          onPressed: _refresh,
        ),
      ),
    ]);
  }

  Widget buildLoading() {
    return CustomScrollView(slivers: [
      SliverPersistentHeader(
        pinned: true,
        floating: true,
        delegate: PageSliverHeader(
          minExtent: 100.0,
          maxExtent: 250.0,
        ),
      ),
      SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              Text('Загрузка сообщений...'),
            ],
          ),
        ),
      ),
    ]);
  }

  Future _refresh() => messageStore.fetchMessages();
}
