import 'dart:developer';
import 'package:get/get.dart';
import '../../../data/product_model.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.put(ProductController());

  var productsCart = <ProductModel>[].obs;
  RxDouble total = 0.0.obs;

  void subToCart({required ProductModel product}) {
    int index = productsCart.indexWhere((element) => element.id == product.id);
    if(productsCart[index].buy.value != 1) {
      productsCart[index].buy--;
      total.value -= product.price!;
    } else {
      total.value -= product.price!;
      productsCart.removeAt(index);
    }
  }

  void addToCart({required ProductModel product}) {
    int index = productsCart.indexWhere((element) => element.id == product.id);
    if (index == -1) {
      productsCart.add(product);
      productsCart[productsCart.length - 1].buy++;
    } else {
      productsCart[index].buy++;
    }
    total.value += product.price!;
  }

  void removeItemCart({required ProductModel product}) {
    int index = productsCart.indexWhere((element) => element.id == product.id);
    total.value -= product.price! * productsCart[index].buy.value;
    productsCart.removeAt(index);
  }

  bool checkProductContain({required ProductModel product}) {
    return productsCart.any((element) => element.id == product.id);
  }
}
