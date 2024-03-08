import 'package:repore/lib.dart';

abstract class IPaymentRepo {
  Future<dynamic> createSetupIntentFromDb();
  Future<List<GetCards>> getCards();
  Future<bool> deletedCard(String cardId);
}
