import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_wigets/ink_well_wrapper.dart';
import '../../controllers/product_controller/product_controller.dart';
import '../../resources/colors/colors.dart';
import '../../../data/product_model.dart';

class CartItem extends StatefulWidget {
  final ProductModel product;

  const CartItem({super.key, required this.product});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: widget.product.color),
              ),
              Positioned(
                right: 0,
                top: -25,
                child: Transform.rotate(
                  angle: -30 * 3.141592653589793 / 180,
                  child: Image.network(
                    widget.product.image ?? '',
                    fit: BoxFit.cover,
                    height: 130,
                    width: 130,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product.name ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                ),
              ),
              const SizedBox(height: 15),
              Text(
                '\$${widget.product.price?.toStringAsFixed(2)}',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWellWrapper(
                    onTap: () =>
                        productController.subToCart(product: widget.product),
                    color: AppColors.gray.withOpacity(0.2),
                    width: 30,
                    height: 30,
                    borderRadius: BorderRadius.circular(15),
                    paddingChild: const EdgeInsets.all(5),
                    child: const Text(
                      '-',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Obx(
                    () => Text(
                      widget.product.buy.value.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  InkWellWrapper(
                    onTap: () =>
                        productController.addToCart(product: widget.product),
                    color: AppColors.gray.withOpacity(0.2),
                    width: 30,
                    height: 30,
                    borderRadius: BorderRadius.circular(15),
                    paddingChild: const EdgeInsets.all(5),
                    child: const Text(
                      '+',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWellWrapper(
                        onTap: () => productController.removeItemCart(
                            product: widget.product),
                        width: 30,
                        height: 30,
                        paddingChild: const EdgeInsets.all(2),
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.yellow,
                        child: const Icon(Icons.delete_outline),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
