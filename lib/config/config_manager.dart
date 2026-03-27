import 'app_config.dart';

/// Paymob environment selector.
enum Environment { test, live }

/// Manages switching between test and live [AppConfig] instances.
///
/// Call [setup] once (e.g. in `main()`) before using [currentConfig].
///
/// ```dart
/// ConfigManager.setup(
///   testConfig: AppConfig(apiKey: '...', ...),
///   liveConfig: AppConfig(apiKey: '...', ...),
/// );
/// ConfigManager.setEnvironment(Environment.live);
/// PaymobFlutter.instance.initializeWithConfig(...ConfigManager.currentConfig);
/// ```
class ConfigManager {
  static Environment _currentEnvironment = Environment.test;
  static AppConfig? _testConfig;
  static AppConfig? _liveConfig;

  /// Register the test and live configs. Must be called before [currentConfig].
  static void setup({
    required AppConfig testConfig,
    required AppConfig liveConfig,
    Environment initialEnvironment = Environment.test,
  }) {
    _testConfig = testConfig;
    _liveConfig = liveConfig;
    _currentEnvironment = initialEnvironment;
  }

  /// The active environment.
  static Environment get currentEnvironment => _currentEnvironment;

  /// Switch environments at runtime.
  static void setEnvironment(Environment environment) {
    _currentEnvironment = environment;
  }

  /// Returns the [AppConfig] for the active environment.
  ///
  /// Throws [StateError] if [setup] has not been called.
  static AppConfig get currentConfig {
    switch (_currentEnvironment) {
      case Environment.test:
        if (_testConfig == null) {
          throw StateError('ConfigManager.setup() must be called before accessing currentConfig');
        }
        return _testConfig!;
      case Environment.live:
        if (_liveConfig == null) {
          throw StateError('ConfigManager.setup() must be called before accessing currentConfig');
        }
        return _liveConfig!;
    }
  }

  static bool get isTest => _currentEnvironment == Environment.test;
  static bool get isLive => _currentEnvironment == Environment.live;
}
