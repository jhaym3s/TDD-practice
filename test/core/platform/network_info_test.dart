import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_driven_development/core/platform/network_info.dart';

class MockConnectivity extends Mock implements Connectivity{}

void main() {
  NetworkInfoImpl networkInfoImpl;
  MockConnectivity connectivity;
  setUp((){
    connectivity = MockConnectivity();
    networkInfoImpl = NetworkInfoImpl(connectivity);
  });

  group('is connected', (){
    test('should forward the call to connectivity ', () async{
      
    });
  });
}