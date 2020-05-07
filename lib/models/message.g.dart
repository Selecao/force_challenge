// GENERATED CODE - DO NOT MODIFY BY HAND

part of message;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Message> _$messageSerializer = new _$MessageSerializer();

class _$MessageSerializer implements StructuredSerializer<Message> {
  @override
  final Iterable<Type> types = const [Message, _$Message];
  @override
  final String wireName = 'Message';

  @override
  Iterable<Object> serialize(Serializers serializers, Message object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'unread',
      serializers.serialize(object.unread, specifiedType: const FullType(bool)),
    ];
    if (object.text != null) {
      result
        ..add('text')
        ..add(serializers.serialize(object.text,
            specifiedType: const FullType(String)));
    }
    if (object.img != null) {
      result
        ..add('img')
        ..add(serializers.serialize(object.img,
            specifiedType: const FullType(String)));
    }
    if (object.price != null) {
      result
        ..add('price')
        ..add(serializers.serialize(object.price,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  Message deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MessageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'unread':
          result.unread = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'text':
          result.text = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'img':
          result.img = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$Message extends Message {
  @override
  final bool unread;
  @override
  final String text;
  @override
  final String img;
  @override
  final int price;

  factory _$Message([void Function(MessageBuilder) updates]) =>
      (new MessageBuilder()..update(updates)).build();

  _$Message._({this.unread, this.text, this.img, this.price}) : super._() {
    if (unread == null) {
      throw new BuiltValueNullFieldError('Message', 'unread');
    }
  }

  @override
  Message rebuild(void Function(MessageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MessageBuilder toBuilder() => new MessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Message &&
        unread == other.unread &&
        text == other.text &&
        img == other.img &&
        price == other.price;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, unread.hashCode), text.hashCode), img.hashCode),
        price.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Message')
          ..add('unread', unread)
          ..add('text', text)
          ..add('img', img)
          ..add('price', price))
        .toString();
  }
}

class MessageBuilder implements Builder<Message, MessageBuilder> {
  _$Message _$v;

  bool _unread;
  bool get unread => _$this._unread;
  set unread(bool unread) => _$this._unread = unread;

  String _text;
  String get text => _$this._text;
  set text(String text) => _$this._text = text;

  String _img;
  String get img => _$this._img;
  set img(String img) => _$this._img = img;

  int _price;
  int get price => _$this._price;
  set price(int price) => _$this._price = price;

  MessageBuilder();

  MessageBuilder get _$this {
    if (_$v != null) {
      _unread = _$v.unread;
      _text = _$v.text;
      _img = _$v.img;
      _price = _$v.price;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Message other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Message;
  }

  @override
  void update(void Function(MessageBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Message build() {
    final _$result = _$v ??
        new _$Message._(unread: unread, text: text, img: img, price: price);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
