import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_wigets/ink_well_wrapper.dart';
import 'cart_item.dart';
import '../../controllers/product_controller/product_controller.dart';
import '../../resources/colors/colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ProductController productController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                            onTap: () => Get.back(),
                            width: 55,
                            height: 55,
                            paddingChild: const EdgeInsets.all(15),
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.gray.withOpacity(0.1),
                            child: const Icon(Icons.arrow_back),
                          )
                        ],
                      )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Your cart',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Obx(
                          () => Text(
                            '\$${productController.total.value == 0 ? '0' : productController.total.value.toStringAsFixed(2)}',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 4 / 5,
                    child: Obx(() {
                      var products = productController.productsCart;
                      return products.isEmpty
                          ? const Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text(
                                'Your cart is empty',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 16,
                                ),
                              ),
                          )
                          : ListView.separated(
                              padding: const EdgeInsets.only(top: 20),
                              itemBuilder: (context, index) {
                                return CartItem(product: products[index]);
                              },
                              itemCount: products.length,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(height: 80),
                            );
                    }),
                  ),
                ],
              ),
            )
          ],
        ),
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
