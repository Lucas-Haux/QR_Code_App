import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:qr_code_generator/model/service/payment_service.dart';

class PaymentRepository {
  // Private constructor
  PaymentRepository._();

  // Singleton instance
  static final PaymentRepository _instance = PaymentRepository._();

  // Getter to access the instance
  static PaymentRepository get paymentRepositoryInstance => _instance;

  // A private variable
  final InAppPurchase _iap = InAppPurchase.instance;

  late StreamSubscription<List<PurchaseDetails>> purchasesSubscription;

  void onInit() {
    initialize();
  }

  // Start listening to purchases
  void startListeningToPurchases(
      Function(List<PurchaseDetails>) onPurchaseUpdate) {
    PaymentService().startListeningToPurchases(onPurchaseUpdate);
  }

  // Stop listening to purchases
  void stopListeningToPurchases() {
    PaymentService().stopListeningToPurchases();
  }

  //Checks if store is avialable
  Future<void> isInAppPurchaseAvailable() async {
    try {
      await PaymentService().isInAppPurchaseAvailable(_iap);
      print('store is avialable, ${_iap.queryProductDetails}');
    } catch (e) {
      print('store is not aviable: $e');
      throw 'store is not aviable: $e';
    }
  }

  Future<void> initialize() async {}

  Future<void> completePurchase(PurchaseDetails purchaseDetails) async {
    try {
      await PaymentService().completePurchase(_iap, purchaseDetails);
    } catch (e) {
      print('isInAppPurchaseAvialble return iap not avialable: $e');
      throw 'isInAppPurchaseAvialble return iap not avialable: $e';
    }
  }

  Future<void> buyConsumableProduct(String productId) async {
    try {
      ProductDetailsResponse response =
          await PaymentService().queryProductResponse(_iap, productId);
      final ProductDetails productDetails = response.productDetails.first;

      // Create purchase parameter
      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: productDetails);

      // Buy consumable product
      PaymentService().buyProduct(_iap, purchaseParam);
    } catch (e) {
      // Handle purchase error
      print('Failed to buy product: $e');
    }
  }
}
