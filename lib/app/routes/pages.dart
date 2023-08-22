import 'package:get/get.dart';
import '../features/cart/cart_screen.dart';
import '../features/product/product_screen.dart';
import 'routes.dart';

//routes navigation
class AppPages {
  static final pages = [
    //AUTHENTICATION ROUTES
    GetPage(
        name: productScreenRoute,
        page: () => const ProductScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: cartScreenRoute,
        page: () => const CartScreen(),
        transition: Transition.fadeIn),
  ];
}
