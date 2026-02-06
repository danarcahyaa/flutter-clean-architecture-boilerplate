import 'package:internet_connection_checker/internet_connection_checker.dart';

/// An abstract contract for checking the device's network connectivity.
///
/// This abstraction allows the data layer to remain agnostic of the
/// specific package used for connection checking, making it easier
/// to unit test and mock.
abstract class NetworkInfo {
  /// Returns [true] if the device is currently connected to the internet.
  Future<bool> get isConnected;
}

/// The concrete implementation of [NetworkInfo] using [InternetConnectionChecker].
///
/// This class provides real-time network status by attempting to ping
/// reliable addresses (like Google or Cloudflare).
class NetworkInfoImpl implements NetworkInfo {
  /// The underlying library used to perform the connection check.
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}