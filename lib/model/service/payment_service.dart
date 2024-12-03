import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';

class PaymentService {
  // StreamSubscription for purchases
  StreamSubscription<List<PurchaseDetails>>? _purchasesSubscription;

  // Start listening to purchases
  void startListeningToPurchases(
      Function(List<PurchaseDetails>) onPurchaseUpdate) {
    _purchasesSubscription = InAppPurchase.instance.purchaseStream
        .listen((List<PurchaseDetails> purchaseDetailsList) {
      onPurchaseUpdate(
          purchaseDetailsList); // Notify caller with purchase updates
    });
  }

  // Stop listening to purchases
  void stopListeningToPurchases() {
    _purchasesSubscription?.cancel();
  }

  // query the  product by productID
  Future<ProductDetailsResponse> queryProductResponse(
      InAppPurchase iap, String productId) async {
    try {
      // Query product details
      final ProductDetailsResponse response =
          await iap.queryProductDetails({productId});

      if (response.productDetails.isEmpty) {
        // Product not found
        print('Product not found for ID: $productId');
        throw 'Product not found for ID: $productId';
      } else {
        return response;
      }
    } catch (e) {
      print('Error querying product response $e');
      throw 'Error querying product response $e';
    }
  }

  Future<void> buyProduct(
      InAppPurchase iap, PurchaseParam purchaseParam) async {
    try {
      await iap.buyConsumable(purchaseParam: purchaseParam, autoConsume: true);
      print('successfully bought product... i think');
    } catch (e) {
      print('couldnt buysproduct: $e');
      throw 'couldnt buysproduct: $e';
    }
  }

  Future<void> isInAppPurchaseAvailable(InAppPurchase iap) async {
    try {
      !(await iap.isAvailable());
      return;
    } catch (e) {
      print('isInAppPurchaseAvialble return iap not avialable: $e');
      throw 'isInAppPurchaseAvialble return iap not avialable: $e';
    }
  }

  Future<void> completePurchase(
      InAppPurchase iap, PurchaseDetails purchaseDetails) async {
    try {
      await iap.completePurchase(purchaseDetails);
      return;
    } catch (e) {
      print('couldnt completePurchase: $e');
      throw 'couldnt completePurchase: $e';
    }
  }
}
