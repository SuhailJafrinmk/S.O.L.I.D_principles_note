/// Dependency Inversion Principle (DIP) states that high-level modules should not depend
/// on low-level implementations but rather on abstractions (interfaces or abstract classes).
///
/// Here's an example that violates the Dependency Inversion Principle:

class PaymentViaCreditCard {
  void payment() {
    print('Payment through credit card');
  }
}

class PaymentViaDebitCard {
  void payment() {
    print('Payment through debit card');
  }
}

class PaymentViaOnlineBanking {
  void payment() {
    print('Payment through online banking');
  }
}

class CheckOut {
  /// This violates the Dependency Inversion Principle because CheckOut
  /// directly depends on the low-level concrete class PaymentViaCreditCard.
  /// We cannot easily swap out the payment method for a different one without
  /// modifying this class, which also violates the Open/Closed Principle.
  
  void checkOut(PaymentViaCreditCard paymentViaCreditCard) {
    paymentViaCreditCard.payment();
  }
}

///////////////////////////////////////////////////////////////////////

/// To adhere to the Dependency Inversion Principle, we introduce an abstraction 
/// (PaymentMethods), and let the high-level module depend on this abstraction:

abstract class PaymentMethods {
  void payment();
}

class CreditCardPayment implements PaymentMethods {
  @override
  void payment() {
    print('Payment done using credit card');
  }
}

class DebitCardPayment implements PaymentMethods {
  @override
  void payment() {
    print('Payment done using debit card');
  }
}

class OnlineBankingPayment implements PaymentMethods {
  @override
  void payment() {
    print('Payment done using online banking');
  }
}

class CheckOutPayment {
  /// Now, CheckOutPayment depends on the high-level abstraction PaymentMethods.
  /// This allows us to swap between payment methods without changing this class.
  
  void checkOut(PaymentMethods paymentMethods) {
    paymentMethods.payment();
  }
}

/// We can now swap the payment method easily by passing in any class that implements PaymentMethods.
void main() {
  CheckOutPayment checkOutPayment = CheckOutPayment();
  checkOutPayment.checkOut(DebitCardPayment());  // Example usage
}
