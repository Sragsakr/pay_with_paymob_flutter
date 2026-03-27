# pay_with_paymob_flutter

<p align="center">
  <a href="https://pub.dev/packages/pay_with_paymob_flutter">
    <img src="https://img.shields.io/pub/v/pay_with_paymob_flutter.svg" alt="pub version" />
  </a>
  <a href="https://pub.dev/packages/pay_with_paymob_flutter/score">
    <img src="https://img.shields.io/pub/points/pay_with_paymob_flutter" alt="pub points" />
  </a>
  <a href="https://pub.dev/packages/pay_with_paymob_flutter">
    <img src="https://img.shields.io/pub/likes/pay_with_paymob_flutter" alt="pub likes" />
  </a>
  <a href="https://pub.dev/packages/pay_with_paymob_flutter">
    <img src="https://img.shields.io/pub/popularity/pay_with_paymob_flutter" alt="pub popularity" />
  </a>
  <a href="https://github.com/Sragsakr/pay_with_paymob_flutter/blob/master/LICENSE">
    <img src="https://img.shields.io/github/license/Sragsakr/pay_with_paymob_flutter" alt="license" />
  </a>
</p>

<p align="center">
  A comprehensive Flutter plugin for integrating <a href="https://paymob.com">Paymob</a> payment gateway.<br/>
  Supports all Paymob payment methods including Unified Checkout (Intention API), iframe payments,<br/>
  payment links, digital wallets, and installment services.
</p>

---

## Platform Support

| Android | iOS | Web | macOS | Windows |
|:-------:|:---:|:---:|:-----:|:-------:|
| ✅ | ✅ | ✅ | ✅ | ✅ |

---

## Features

- **Unified Checkout** via Intention API (recommended)
- **Iframe payments** — embed payment forms directly in-app
- **Payment links** — shareable URLs customers pay from
- **Digital Wallets** — Apple Pay, Mobile Wallet
- **Installment Services** — ValU, Souhoola, Aman, Forsa, Premium, Bank Installments
- **Other services** — Kiosk, Contact, HALAN, SYMPL
- **Built-in multi-environment support** — `ConfigManager` + `AppConfig` included in the plugin
- **RTL/LTR** localization (Arabic & English)

---

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  pay_with_paymob_flutter: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

## Platform Setup

### Android

In `android/app/build.gradle`, set minimum SDK to 19 or higher:

```gradle
defaultConfig {
    minSdkVersion 19
}
```

### iOS

In `ios/Runner/Info.plist`, add:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

---

## Quick Start

### Option A — Direct initialization (simple apps)

Call `initializeWithConfig()` before `runApp()` in `main.dart`:

```dart
import 'package:pay_with_paymob_flutter/paymob_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  PaymobFlutter.instance.initializeWithConfig(
    apiKey: 'YOUR_API_KEY',
    publicKey: 'YOUR_PUBLIC_KEY',
    secretKey: 'YOUR_SECRET_KEY',
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
        paymentMethod: PaymobPaymentMethod.wallet,
        identifier: '01000000000', // customer phone number
        integrationId: 'YOUR_WALLET_INTEGRATION_ID',
        customSubtype: 'WALLET',
        displayName: 'Mobile Wallet',
        description: 'Pay with mobile wallet',
      ),
    ],
    iframes: [
      PaymobIframe(
        iframeId: 111111,
        integrationId: 1111111,
        name: 'Card Iframe',
        description: 'Credit/Debit card payment',
      ),
    ],
    defaultIntegrationId: 1111111,
  );

  runApp(const MyApp());
}
```

---

### Option B — ConfigManager (recommended for test/live switching)

The plugin ships `AppConfig`, `ConfigManager`, and `Environment` — no extra setup needed.

**Step 1** — Define your test and live configs:

```dart
// test_config.dart
import 'package:pay_with_paymob_flutter/paymob_flutter.dart';

class TestConfig {
  static AppConfig get config => AppConfig(
    apiKey: 'YOUR_TEST_API_KEY',
    publicKey: 'egy_pk_test_XXXXXXXXXXXXXXXXXXXX',
    secretKey: 'egy_sk_test_XXXXXXXXXXXXXXXXXXXX',
    paymentMethods: [
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.custom,
        identifier: 'YOUR_CARD_INTEGRATION_ID',
        integrationId: 'YOUR_CARD_INTEGRATION_ID',
        customSubtype: 'card',
        displayName: 'Online Card',
        description: 'Pay securely with your card',
      ),
      // add more methods...
    ],
    iframes: [
      PaymobIframe(
        iframeId: 111111,
        integrationId: 1111111,
        name: 'Card Iframe',
        description: 'Card payment iframe',
      ),
    ],
    defaultIntegrationId: 1111111,
  );
}
```

```dart
// live_config.dart
import 'package:pay_with_paymob_flutter/paymob_flutter.dart';

class LiveConfig {
  static AppConfig get config => AppConfig(
    apiKey: 'YOUR_LIVE_API_KEY',
    publicKey: 'egy_pk_live_XXXXXXXXXXXXXXXXXXXX',
    secretKey: 'egy_sk_live_XXXXXXXXXXXXXXXXXXXX',
    paymentMethods: [
      // same structure, different production integration IDs
    ],
    iframes: [
      // production iframes
    ],
    defaultIntegrationId: 9999999,
  );
}
```

**Step 2** — Setup `ConfigManager` and initialize in `main.dart`:

```dart
import 'package:pay_with_paymob_flutter/paymob_flutter.dart';
import 'test_config.dart';
import 'live_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Register both configs and set initial environment
  ConfigManager.setup(
    testConfig: TestConfig.config,
    liveConfig: LiveConfig.config,
    initialEnvironment: Environment.test, // change to Environment.live for production
  );

  // Initialize Paymob from the active environment config
  final config = ConfigManager.currentConfig;
  PaymobFlutter.instance.initializeWithConfig(
    apiKey: config.apiKey,
    publicKey: config.publicKey,
    secretKey: config.secretKey,
    paymentMethods: config.paymentMethods,
    iframes: config.iframes,
    defaultIntegrationId: config.defaultIntegrationId,
  );

  runApp(const MyApp());
}
```

**Step 3** — Switch environments at runtime (e.g. a debug toggle):

```dart
ConfigManager.setEnvironment(Environment.live);

// Check current environment
if (ConfigManager.isTest) { ... }
if (ConfigManager.isLive) { ... }

print(ConfigManager.currentEnvironment); // Environment.test or Environment.live
```

> You can find your keys and IDs in your [Paymob dashboard](https://accept.paymob.com).

---

## Payment Methods

### Unified Checkout (Intention API) — Recommended

Displays a single checkout screen supporting multiple payment methods at once.

```dart
await PaymobFlutter.instance.payWithIntentionApi(
  context: context,
  currency: 'EGP',
  amount: 150.0, // currency units, NOT cents
  paymentMethodIntegrationIds: [1111111, 2222222],
  billingData: BillingData(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@example.com',
    phoneNumber: '01012345678',
    apartment: '5',
    building: '20',
    postalCode: '11511',
    city: 'Cairo',
    state: 'Cairo',
    country: 'Egypt',
    floor: '2',
    street: '123 Main St',
    shippingMethod: 'Standard',
  ),
  specialReference: 'order_${DateTime.now().millisecondsSinceEpoch}',
  onPayment: (PaymentPaymobResponse response) {
    if (response.success) {
      print('Payment succeeded! TX: ${response.transactionID}');
    } else {
      print('Payment failed: ${response.message}');
    }
  },
);
```

#### Optional parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `expiration` | `int?` | Token expiration in seconds |
| `title` | `Widget?` | Custom app bar title widget |
| `appBarColor` | `Color?` | App bar background color |
| `items` | `List<Map<String, dynamic>>?` | Order items list |
| `extras` | `Map<String, dynamic>?` | Extra data passed to Paymob |

---

### Iframe Payment

Embeds a Paymob-hosted payment form inside a WebView.

```dart
final iframe = PaymobFlutter.instance.availableIframes.first;

await PaymobFlutter.instance.payWithIframe(
  context: context,
  iframe: iframe,
  currency: 'EGP',
  amount: 150.0,
  billingData: BillingData(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@example.com',
    phoneNumber: '01012345678',
    city: 'Cairo',
    country: 'Egypt',
  ),
  onPayment: (PaymentPaymobResponse response) {
    if (response.success) {
      print('Transaction ID: ${response.transactionID}');
    }
  },
);
```

---

### Payment Links

Creates a shareable payment URL and opens it in a WebView.

```dart
final request = PaymentLinkRequest.fromAmount(
  amount: 100.0,
  paymentMethods: ['YOUR_INTEGRATION_ID'],
  email: 'john@example.com',
  fullName: 'John Doe',
  phoneNumber: '01012345678',
  description: 'Order #1234',
  isLive: ConfigManager.isLive,
);

await PaymobFlutter.instance.createPayLink(
  context: context,
  apiKey: ConfigManager.currentConfig.apiKey,
  request: request,
  title: const Text('Complete Payment'),
  onPayment: (PaymentPaymobResponse response) {
    if (response.success) {
      print('Paid! Transaction: ${response.transactionID}');
    }
  },
);
```

---

## Configuration Reference

### `AppConfig`

Holds all credentials and payment configuration for one environment.

| Field | Type | Description |
|-------|------|-------------|
| `apiKey` | `String` | Paymob legacy API key |
| `publicKey` | `String` | Public key for Intention API |
| `secretKey` | `String` | Secret key for Intention API |
| `paymentMethods` | `List<PaymentMethodConfig>` | Payment methods to enable |
| `iframes` | `List<PaymobIframe>` | Iframes to enable |
| `defaultIntegrationId` | `int` | Fallback integration ID |

---

### `ConfigManager`

| Member | Description |
|--------|-------------|
| `ConfigManager.setup(testConfig:, liveConfig:, initialEnvironment:)` | Register configs — call once in `main()` |
| `ConfigManager.setEnvironment(Environment)` | Switch environment at runtime |
| `ConfigManager.currentConfig` | Returns `AppConfig` for the active environment |
| `ConfigManager.currentEnvironment` | Returns `Environment.test` or `Environment.live` |
| `ConfigManager.isTest` | `true` when in test mode |
| `ConfigManager.isLive` | `true` when in live mode |

---

### `initializeWithConfig` parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `apiKey` | `String` | Yes | Paymob legacy API key |
| `publicKey` | `String` | Yes | Public key for Intention API |
| `secretKey` | `String` | Yes | Secret key for Intention API |
| `paymentMethods` | `List<PaymentMethodConfig>` | Yes | Configured payment methods |
| `iframes` | `List<PaymobIframe>` | Yes | Configured iframes |
| `defaultIntegrationId` | `int?` | No | Fallback integration ID |
| `userTokenExpiration` | `int` | No | Token TTL in seconds (default: 3600) |

---

### `PaymentMethodConfig`

```dart
const PaymentMethodConfig(
  paymentMethod: PaymobPaymentMethod.valu,
  identifier: 'YOUR_VALU_INTEGRATION_ID', // or phone number for wallet
  integrationId: 'YOUR_VALU_INTEGRATION_ID',
  customSubtype: 'VALU',
  displayName: 'ValU',
  description: 'Buy now, pay later',
)
```

### Supported `PaymobPaymentMethod` values

| Enum value | `customSubtype` | Notes |
|------------|----------------|-------|
| `custom` | `'card'` | Online card (credit/debit) |
| `applePay` | `'APPLE_PAY'` | Apple Pay |
| `wallet` | `'WALLET'` | Mobile wallet — set `identifier` to customer phone |
| `valu` | `'VALU'` | ValU installments |
| `bankInstallments` | `'BANK_INSTALLMENTS'` | Bank installments |
| `souhoolaV3` | `'SOUHOOLA_V3'` | Souhoola V3 |
| `amanV3` | `'AMAN_V3'` | Aman V3 |
| `forsa` | `'FORSA'` | Forsa |
| `premium` | `'PREMIUM'` | Premium |
| `contact` | `'CONTACT'` | Contact |
| `halan` | `'HALAN'` | HALAN |
| `sympl` | `'SYMPL'` | SYMPL |
| `kiosk` | `'AGGREGATOR'` | Cash at kiosk |

---

### `PaymobIframe`

```dart
PaymobIframe(
  iframeId: 111111,            // iframe ID from Paymob dashboard
  integrationId: 1111111,      // integration ID (int)
  name: 'Card Iframe',         // optional display name
  description: 'Card payment', // optional description
)
```

---

### `BillingData`

All fields are optional strings:

```dart
BillingData(
  firstName: 'John',
  lastName: 'Doe',
  email: 'john@example.com',
  phoneNumber: '01012345678',
  apartment: '5',
  building: '20',
  floor: '2',
  street: '123 Main St',
  city: 'Cairo',
  state: 'Cairo',
  country: 'Egypt',
  postalCode: '11511',
  shippingMethod: 'Standard',
)
```

---

### `PaymentLinkRequest`

Pass amount in currency units — the plugin converts to cents:

```dart
PaymentLinkRequest.fromAmount(
  amount: 100.0,
  paymentMethods: ['YOUR_INTEGRATION_ID'],
  email: 'john@example.com',
  fullName: 'John Doe',
  phoneNumber: '01012345678',
  description: 'Optional description',
  isLive: false,
  referenceId: 'order_123',        // optional
  paymentLinkImage: 'https://...', // optional image URL
)
```

---

## Handling the Payment Response

All three payment methods return `PaymentPaymobResponse` in the `onPayment` callback:

| Field | Type | Description |
|-------|------|-------------|
| `success` | `bool` | `true` if payment completed |
| `transactionID` | `String?` | Paymob transaction ID |
| `responseCode` | `String?` | Paymob response code |
| `message` | `String?` | Human-readable status message |
| `amountCents` | `int?` | Amount paid in cents |
| `dataMessage` | `String?` | Additional data message |

```dart
onPayment: (response) {
  if (response.success) {
    final txId = response.transactionID;
    final amount = (response.amountCents ?? 0) / 100.0;
    print('Paid EGP $amount — TX: $txId');
  } else {
    print('Failed: ${response.message}');
  }
},
```

---

## Error Handling

All payment methods throw typed exceptions:

```dart
try {
  await PaymobFlutter.instance.payWithIntentionApi(...);
} on InvalidApiKeyException catch (e) {
  // Invalid or missing API key
} on PaymentInitializationException catch (e) {
  // Plugin not initialized before payment call
} on PaymentMethodNotAvailableException catch (e) {
  // Requested method not in configured list
} on IframeNotAvailableException catch (e) {
  // Requested iframe not in configured list
} on OrderCreationException catch (e) {
  // Paymob order creation failed
} on PaymentTokenException catch (e) {
  // Payment token retrieval failed
} on PaymentIntentionException catch (e) {
  // Intention API call failed
} on PaymentLinkException catch (e) {
  // Payment link creation failed
} on ApiRequestException catch (e) {
  // Generic API request failure
} catch (e) {
  // Unexpected error
}
```

---

## Accessing Configured Methods and Iframes

```dart
// All configured payment methods
final methods = PaymobFlutter.instance.availablePaymentMethods;

// All configured iframes
final iframes = PaymobFlutter.instance.availableIframes;
```

Filter by category:

```dart
final wallets = PaymobFlutter.instance.availablePaymentMethods
    .where((m) => [
          PaymobPaymentMethod.wallet,
          PaymobPaymentMethod.applePay,
        ].contains(m.paymentMethod))
    .toList();

final installments = PaymobFlutter.instance.availablePaymentMethods
    .where((m) => [
          PaymobPaymentMethod.valu,
          PaymobPaymentMethod.bankInstallments,
          PaymobPaymentMethod.souhoolaV3,
          PaymobPaymentMethod.amanV3,
          PaymobPaymentMethod.forsa,
          PaymobPaymentMethod.premium,
        ].contains(m.paymentMethod))
    .toList();
```

---

## Amount Handling

Always pass amounts in **currency units** (e.g. EGP), not cents. The plugin converts automatically:

```
amount: 100.0  →  sends 10000 to Paymob API
amount: 1.5    →  sends 150  to Paymob API
```

Response `amountCents` is in cents — divide by 100 to display:

```dart
final display = (response.amountCents ?? 0) / 100.0;
```

---

## Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `dio` | ^5.4.0 | HTTP client for Paymob API calls |
| `flutter_inappwebview` | ^6.1.5 | In-app WebView for payment screens |

---

## Requirements

| | Minimum |
|---|---|
| Flutter | 3.0.0 |
| Dart | 3.0.5 |
| Android | minSdkVersion 19 |
| iOS | iOS 11+ |
| macOS | macOS 10.14+ |
| Windows | Windows 10+ |
| Web | Any modern browser |
