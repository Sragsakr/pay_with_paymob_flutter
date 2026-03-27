import 'package:pay_with_paymob_flutter/paymob_flutter.dart';

/// Live/Production configuration — replace with your own keys from https://accept.paymob.com
class LiveConfig {
  static AppConfig get config => AppConfig(
    apiKey: "YOUR_LIVE_API_KEY",
    publicKey: "egy_pk_live_XXXXXXXXXXXXXXXXXXXXXXXXXXXX",
    secretKey: "egy_sk_live_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",

    paymentMethods: [
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.custom,
        identifier: 'YOUR_CARD_INTEGRATION_ID',
        integrationId: 'YOUR_CARD_INTEGRATION_ID',
        customSubtype: 'card',
        displayName: 'Online Card',
        description: 'Pay securely with your card',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.applePay,
        identifier: 'YOUR_APPLE_PAY_INTEGRATION_ID',
        integrationId: 'YOUR_APPLE_PAY_INTEGRATION_ID',
        customSubtype: 'APPLE_PAY',
        displayName: 'Apple Pay',
        description: 'Pay securely with Apple Pay',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.valu,
        identifier: 'YOUR_VALU_INTEGRATION_ID',
        integrationId: 'YOUR_VALU_INTEGRATION_ID',
        customSubtype: 'VALU',
        displayName: 'ValU',
        description: 'Buy now, pay later with ValU',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.bankInstallments,
        identifier: 'YOUR_BANK_INSTALLMENTS_INTEGRATION_ID',
        integrationId: 'YOUR_BANK_INSTALLMENTS_INTEGRATION_ID',
        customSubtype: 'BANK_INSTALLMENTS',
        displayName: 'Bank Installments',
        description: 'Pay in installments with your bank',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.souhoolaV3,
        identifier: 'YOUR_SOUHOOLA_INTEGRATION_ID',
        integrationId: 'YOUR_SOUHOOLA_INTEGRATION_ID',
        customSubtype: 'SOUHOOLA_V3',
        displayName: 'Souhoola V3',
        description: 'Souhoola V3 payment service',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.amanV3,
        identifier: 'YOUR_AMAN_INTEGRATION_ID',
        integrationId: 'YOUR_AMAN_INTEGRATION_ID',
        customSubtype: 'AMAN_V3',
        displayName: 'Aman V3',
        description: 'Aman V3 payment service',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.forsa,
        identifier: 'YOUR_FORSA_INTEGRATION_ID',
        integrationId: 'YOUR_FORSA_INTEGRATION_ID',
        customSubtype: 'FORSA',
        displayName: 'Forsa',
        description: 'Forsa payment service',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.premium,
        identifier: 'YOUR_PREMIUM_INTEGRATION_ID',
        integrationId: 'YOUR_PREMIUM_INTEGRATION_ID',
        customSubtype: 'PREMIUM',
        displayName: 'Premium',
        description: 'Premium payment service',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.contact,
        identifier: 'YOUR_CONTACT_INTEGRATION_ID',
        integrationId: 'YOUR_CONTACT_INTEGRATION_ID',
        customSubtype: 'CONTACT',
        displayName: 'Contact',
        description: 'Contact payment service',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.halan,
        identifier: 'YOUR_HALAN_INTEGRATION_ID',
        integrationId: 'YOUR_HALAN_INTEGRATION_ID',
        customSubtype: 'HALAN',
        displayName: 'HALAN',
        description: 'HALAN payment service',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.sympl,
        identifier: 'YOUR_SYMPL_INTEGRATION_ID',
        integrationId: 'YOUR_SYMPL_INTEGRATION_ID',
        customSubtype: 'SYMPL',
        displayName: 'SYMPL',
        description: 'SYMPL payment service',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.kiosk,
        identifier: 'AGGREGATOR',
        integrationId: 'YOUR_KIOSK_INTEGRATION_ID',
        customSubtype: 'AGGREGATOR',
        displayName: 'Kiosk',
        description: 'Pay at kiosk locations',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.wallet,
        identifier: '01000000000',
        integrationId: 'YOUR_WALLET_INTEGRATION_ID',
        customSubtype: 'WALLET',
        displayName: 'Wallet',
        description: 'Digital wallet payment',
      ),
    ],

    iframes: [
      PaymobIframe(
        iframeId: 111111,
        integrationId: 1111111,
        name: 'Card Iframe',
        description: 'Credit / Debit card iframe',
      ),
      PaymobIframe(
        iframeId: 222222,
        integrationId: 2222222,
        name: 'ValU Iframe',
        description: 'ValU installment iframe',
      ),
      PaymobIframe(
        iframeId: 333333,
        integrationId: 3333333,
        name: 'Souhoola Iframe',
        description: 'Souhoola V2 iframe',
      ),
    ],

    defaultIntegrationId: 1111111,
  );
}
