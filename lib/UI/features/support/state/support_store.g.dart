// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SupportStore on SupportStoreBase, Store {
  late final _$chatMessagesAtom = Atom(
    name: 'SupportStoreBase.chatMessages',
    context: context,
  );

  @override
  ObservableList<SupportMessage> get chatMessages {
    _$chatMessagesAtom.reportRead();
    return super.chatMessages;
  }

  @override
  set chatMessages(ObservableList<SupportMessage> value) {
    _$chatMessagesAtom.reportWrite(value, super.chatMessages, () {
      super.chatMessages = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: 'SupportStoreBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$sendMessageAsyncAction = AsyncAction(
    'SupportStoreBase.sendMessage',
    context: context,
  );

  @override
  Future<void> sendMessage(String text) {
    return _$sendMessageAsyncAction.run(() => super.sendMessage(text));
  }

  late final _$SupportStoreBaseActionController = ActionController(
    name: 'SupportStoreBase',
    context: context,
  );

  @override
  void clearChat() {
    final _$actionInfo = _$SupportStoreBaseActionController.startAction(
      name: 'SupportStoreBase.clearChat',
    );
    try {
      return super.clearChat();
    } finally {
      _$SupportStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
chatMessages: ${chatMessages},
isLoading: ${isLoading}
    ''';
  }
}
