import 'dart:convert';

import '../../../auth/signin/data/sources/local/local_auth.dart';
import '../../domain/entities/cart_entity.dart';
import 'cart_model.dart';

class CartModel extends CartEntity {
  CartModel({
    String? cartID,
    DateTime? updatedAt,
    DateTime? createdAt,
    List<CartItemModel>? cartItems,
  }) : super(
          cartID: cartID ?? LocalAuth.uid ?? '',
          updatedAt: updatedAt ?? DateTime.now(),
          createdAt: createdAt ?? DateTime.now(),
          cartItems: cartItems ?? <CartItemModel>[],
        );

  factory CartModel.fromRaw(String value) =>
      CartModel.fromJson(json.decode(value));

  factory CartModel.fromJson(Map<String, dynamic> value) => CartModel(
        updatedAt: DateTime.parse(value['updated_at']),
        createdAt: DateTime.parse(value['created_at']),
        cartID: value['cart_id'],
        cartItems: List<CartItemModel>.from((value['cart_items'] ?? <dynamic>[])
            .map((dynamic x) => CartItemModel.fromJson(x))),
      );
}
