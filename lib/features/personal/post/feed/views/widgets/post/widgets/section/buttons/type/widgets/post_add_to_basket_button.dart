import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../../../core/dialogs/cart/add_to_cart_dialog.dart';
import '../../../../../../../../../../../../core/functions/app_log.dart';
import '../../../../../../../../../../../../core/sources/data_state.dart';
import '../../../../../../../../../../../../core/widgets/app_snakebar.dart';
import '../../../../../../../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../../../../../../../services/get_it.dart';
import '../../../../../../../../../domain/entities/post_entity.dart';
import '../../../../../../../../../domain/params/add_to_cart_param.dart';
import '../../../../../../../../../domain/usecase/add_to_cart_usecase.dart';

class PostAddToBasketButton extends StatefulWidget {
  const PostAddToBasketButton({required this.post, super.key});
  final PostEntity post;

  @override
  State<PostAddToBasketButton> createState() => _PostAddToBasketButtonState();
}

class _PostAddToBasketButtonState extends State<PostAddToBasketButton> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(8);
    final BoxDecoration decoration = BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: borderRadius,
    );
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: decoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  borderRadius: borderRadius,
                  onTap: () {
                    if (quantity == 1) return;
                    setState(() {
                      quantity--;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: decoration,
                    child: const Icon(Icons.remove),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    quantity.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: borderRadius,
                  onTap: () {
                    if (quantity == widget.post.quantity) return;
                    setState(() {
                      quantity++;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: decoration,
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: CustomElevatedButton(
            onTap: () async {
              try {
                if (widget.post.sizeColors.isNotEmpty) {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AddToCartDialog(post: widget.post);
                    },
                  );
                } else {
                  final AddToCartUsecase usecase = AddToCartUsecase(locator());
                  final DataState<bool> result = await usecase(
                    AddToCartParam(post: widget.post, quantity: quantity),
                  );
                  if (result is DataSuccess) {
                    AppSnackBar.showSnackBar(
                      // ignore: use_build_context_synchronously
                      context,
                      'successfull-add-to-basket'.tr(),
                      backgroundColor: Colors.green,
                    );
                  } else {
                    AppLog.error(
                      result.exception?.message ?? 'AddToCartDialog',
                      name: 'post_add_to_basket_button.dart',
                      error: result.exception,
                    );
                    AppSnackBar.showSnackBar(
                      // ignore: use_build_context_synchronously
                      context,
                      result.exception?.message ?? 'something-wrong'.tr(),
                    );
                  }
                }
                //
              } catch (e) {
                AppLog.error(
                  e.toString(),
                  name: 'PostAddToBasketButton.onTap - catch',
                  error: e,
                );
              }
            },
            title: 'add-to-basket'.tr(),
            bgColor: Colors.transparent,
            border: Border.all(color: Theme.of(context).primaryColor),
            textColor: Theme.of(context).primaryColor,
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
            isLoading: false,
          ),
        ),
      ],
    );
  }
}
