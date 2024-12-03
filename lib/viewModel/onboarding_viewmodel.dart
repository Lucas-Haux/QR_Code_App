import 'package:qr_code_generator/model/repository/payment_repository.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class OnboardingViewmodel {
  final PaymentRepository _paymentRepository =
      PaymentRepository.paymentRepositoryInstance;
  Future<void> initialize() async {
    try {
      await PaymentRepository.paymentRepositoryInstance
          .isInAppPurchaseAvailable();
      _startListeningToPurchases();
    } catch (e) {
      print('failed to initialize');
      throw 'failed to initialize';
      // return error to snack bar
    }
  }

  Future<void> buy90Tokens() async {
    try {
      _paymentRepository.buyConsumableProduct('consumable');
    } catch (e) {
      print('couldnt buy 90 tokens: $e');
    }
  }

  void _startListeningToPurchases() {
    _paymentRepository
        .startListeningToPurchases((List<PurchaseDetails> purchases) async {
      await _handlePurchaseUpdates(purchases);
    });
  }

  Future<void> _handlePurchaseUpdates(purchaseDetailsList) async {
    for (int index = 0; index < purchaseDetailsList.length; index++) {
      var purchaseStatus = purchaseDetailsList[index].status;
      switch (purchaseDetailsList[index].status) {
        case PurchaseStatus.pending:
          print(' purchase is in pending ');
          continue;
        case PurchaseStatus.error:
          print(' purchase error ');
          break;
        case PurchaseStatus.canceled:
          print(' purchase cancel ');
          break;
        case PurchaseStatus.purchased:
          print(' purchased ');
          break;
        case PurchaseStatus.restored:
          print(' purchase restore ');
          break;
      }

      if (purchaseDetailsList[index].pendingCompletePurchase) {
        await _paymentRepository
            .completePurchase(purchaseDetailsList[index])
            .then(
          (value) {
            if (purchaseStatus == PurchaseStatus.purchased) {
              print('seems like your purchese completed');
              //on purchase success you can call your logic and your API here.
            }
          },
        );
      }
    }
  }
}
