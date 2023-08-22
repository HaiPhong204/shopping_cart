import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_cart/app/common_wigets/ink_well_wrapper.dart';
import 'package:shopping_cart/app/controllers/product_controller/product_controller.dart';
import '../../routes/routes.dart';
import 'product_item.dart';
import '../../../data/product_model.dart';
import '../../../data/shoes.dart';

import '../../resources/colors/colors.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<ProductModel> products = [];
  final productController = Get.put(ProductController());

  @override
  void initState() {
    data['shoes']?.forEach((v) {
      products.add(ProductModel.fromJson(v));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height / 5,
            child: CustomPaint(
              painter: MyCustomPainter(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/nike.png',
                          width: 55, height: 55),
                      InkWellWrapper(
                        onTap: () => Get.toNamed(cartScreenRoute),
                        width: 55,
                        height: 55,
                        paddingChild: const EdgeInsets.all(15),
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.gray.withOpacity(0.1),
                        child: const Icon(Icons.shopping_cart),
                      )
                    ],
                  )
                ),
                const Text(
                  'Our Products',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 4 / 5,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                    itemBuilder: (context, index) {
                      return ProductItem(
                        product: products[index],
                        onAddProductToCart: (){
                          productController.addToCart(product: products[index]);
                        },
                      );
                    },
                    itemCount: products.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 20),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.yellow
      ..style = PaintingStyle.fill;

    final rect = Rect.fromPoints(
      Offset(-size.width, -size.height), // Điểm bắt đầu (góc trái trên)
      Offset(size.width, size.height), // Điểm kết thúc (góc phải dưới)
    );
    const startAngle = 1.5708; // Góc bắt đầu, tương ứng với 1/4 hình tròn
    const sweepAngle = -1.5708; // Góc duyệt qua, tương ứng với 1/4 hình tròn

    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
