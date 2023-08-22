import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller/product_controller.dart';
import '../../common_wigets/ink_well_wrapper.dart';
import '../../resources/colors/colors.dart';
import '../../../data/product_model.dart';

class ProductItem extends StatefulWidget {
  final ProductModel product;
  final Function()? onAddProductToCart;

  const ProductItem(
      {super.key, required this.product, this.onAddProductToCart});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 3 / 5,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: widget.product.color),
          child: Transform.rotate(
            angle: -20 * 3.141592653589793 / 180,
            child: Image.network(
              widget.product.image ?? '',
              width: MediaQuery.of(context).size.height * 2/5,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          widget.product.name ?? '',
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rubik',
          ),
        ),
        const SizedBox(height: 30),
        Text(
          widget.product.description ?? '',
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Rubik',
            wordSpacing: 0.5,
            height: 2,
          ),
        ),
        const SizedBox(height: 30),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Text(
                '\$${widget.product.price?.toStringAsFixed(2) ?? ''}',
                style: const TextStyle(
                  fontSize: 25,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Obx(
              () =>
                  productController.checkProductContain(product: widget.product)
                      ? Container(
                          width: 55,
                          height: 55,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: AppColors.yellow,
                              borderRadius: BorderRadius.circular(30)),
                          child: Image.asset('assets/images/check.png'),
                        )
                      : InkWellWrapper(
                          onTap: widget.onAddProductToCart,
                          paddingChild: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          color: AppColors.yellow,
                          borderRadius: BorderRadius.circular(30),
                          child: const Text(
                            'ADD TO CART',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
            ),
          ],
        ),
        const SizedBox(height: 70),
      ],
    );
  }
}
