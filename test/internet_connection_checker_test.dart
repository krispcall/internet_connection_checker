import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:test/test.dart';

void main() {
  group('internet_connection_checker', () {
    StreamSubscription<InternetConnectionStatus>? listener1;
    StreamSubscription<InternetConnectionStatus>? listener2;

    tearDown(() {
      // destroy any active listener after each test
      listener1?.cancel();
      listener2?.cancel();
    });

    test('''Shouldn't have any listeners attached''', () {
      expect(
        InternetConnectionChecker('https://www.google.com').hasListeners,
        isFalse,
      );
    });

    test('''Unawaited call hasConnection should return a Future<bool>''', () {
      expect(
        InternetConnectionChecker('https://www.google.com').hasConnection,
        isA<Future<bool>>(),
      );
    });

    test('''Awaited call to hasConnection should return a bool''', () async {
      expect(
        await InternetConnectionChecker('https://www.google.com').hasConnection,
        isA<bool>(),
      );
    });

    test(
        '''Unawaited call to connectionStatus '''
        '''should return a Future<InternetConnectionStatus>''', () {
      expect(
        InternetConnectionChecker('https://www.google.com').connectionStatus,
        isA<Future<InternetConnectionStatus>>(),
      );
    });

    test(
        '''Awaited call to connectionStatus '''
        '''should return a Future<InternetConnectionStatus>''', () async {
      expect(
        await InternetConnectionChecker('https://www.google.com').connectionStatus,
        isA<InternetConnectionStatus>(),
      );
    });

    test('''We shouldn't have any listeners 1''', () {
      expect(
        InternetConnectionChecker('https://www.google.com').hasListeners,
        isFalse,
      );
    });

    test('''We should have listeners 1''', () {
      listener1 = InternetConnectionChecker('https://www.google.com').onStatusChange.listen((_) {});
      expect(
        InternetConnectionChecker('https://www.google.com').hasListeners,
        isTrue,
      );
    });

    test('''We should have listeners 2''', () {
      listener1 = InternetConnectionChecker('https://www.google.com').onStatusChange.listen((_) {});
      listener2 = InternetConnectionChecker('https://www.google.com').onStatusChange.listen((_) {});
      expect(
        InternetConnectionChecker('https://www.google.com').hasListeners,
        isTrue,
      );
    });

    test('''We should have listeners 3''', () async {
      listener1 = InternetConnectionChecker('https://www.google.com').onStatusChange.listen((_) {});
      await listener1!.cancel();
      listener2 = InternetConnectionChecker('https://www.google.com').onStatusChange.listen((_) {});
      expect(
        InternetConnectionChecker('https://www.google.com').hasListeners,
        isTrue,
      );
    });

    test('''We shouldn't have any listeners 2''', () async {
      listener1 = InternetConnectionChecker('https://www.google.com').onStatusChange.listen((_) {});
      await listener1!.cancel();
      listener2 = InternetConnectionChecker('https://www.google.com').onStatusChange.listen((_) {});
      await listener2!.cancel();
      expect(
        InternetConnectionChecker('https://www.google.com').hasListeners,
        isFalse,
      );
    });

    test('''We shouldn't have any listeners 1''', () {
      expect(
        InternetConnectionChecker('https://www.google.com').hasListeners,
        isFalse,
      );
    });

    test('''We should have listeners 1 [isActivelyChecking]''', () {
      listener1 = InternetConnectionChecker('https://www.google.com').onStatusChange.listen((_) {});
      expect(
        InternetConnectionChecker('https://www.google.com').isActivelyChecking,
        isTrue,
      );
    });

    test('''We should have listeners 2 [isActivelyChecking]''', () {
      listener1 = InternetConnectionChecker('https://www.google.com').onStatusChange.listen((_) {});
      listener2 = InternetConnectionChecker('https://www.google.com').onStatusChange.listen((_) {});
      expect(
        InternetConnectionChecker('https://www.google.com').isActivelyChecking,
        isTrue,
      );
    });

    test('''We should have listeners 3 [isActivelyChecking]''', () async {
      listener1 = InternetConnectionChecker('https://www.google.com').onStatusChange.listen((_) {});
      await listener1!.cancel();
      listener2 = InternetConnectionChecker('https://www.google.com').onStatusChange.listen((_) {});
      expect(
        InternetConnectionChecker('https://www.google.com').isActivelyChecking,
        isTrue,
      );
    });

    test('''We shouldn't have any listeners 2 [isActivelyChecking]''',
        () async {
      listener1 = InternetConnectionChecker('https://www.google.com').onStatusChange.listen((_) {});
      await listener1!.cancel();
      listener2 = InternetConnectionChecker('https://www.google.com').onStatusChange.listen((_) {});
      await listener2!.cancel();
      expect(
        InternetConnectionChecker('https://www.google.com').isActivelyChecking,
        isFalse,
      );
    });

    test('''We should be able to set a custom timeout value''', () async {
      const Duration timeout = Duration(seconds: 1);
      final InternetConnectionChecker internetConnectionChecker =
          InternetConnectionChecker.createInstance(
        checkTimeout: timeout,
      );
      expect(
        internetConnectionChecker.addresses.every(
          (AddressCheckOptions element) => element.timeout == timeout,
        ),
        isTrue,
      );
    });

    test('''We should be able to set a custom interval value''', () async {
      const Duration interval = Duration(seconds: 1);
      final InternetConnectionChecker internetConnectionChecker =
          InternetConnectionChecker.createInstance(
        checkInterval: interval,
      );
      expect(
        internetConnectionChecker.checkInterval,
        interval,
      );
    });

    test('''We should be able to set a custom timeout value''', () async {
      const Duration timeout = Duration(seconds: 1);
      final InternetConnectionChecker internetConnectionChecker =
          InternetConnectionChecker.createInstance(
        checkTimeout: timeout,
      );
      expect(
        internetConnectionChecker.checkTimeout,
        timeout,
      );
      expect(
        internetConnectionChecker.addresses.every(
          (AddressCheckOptions element) => element.timeout == timeout,
        ),
        isTrue,
      );
    });

    test('''We should be able to set custom addresses''', () async {
      final List<AddressCheckOptions> addresses = <AddressCheckOptions>[
        InternetConnectionChecker.DEFAULT_ADDRESSES.first,
      ];
      final InternetConnectionChecker internetConnectionChecker =
          InternetConnectionChecker.createInstance(
        addresses: addresses,
      );
      expect(
        internetConnectionChecker.addresses,
        addresses,
      );
    });
  });
}
