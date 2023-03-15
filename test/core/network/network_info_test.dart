import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_clean_architecture_example/core/network/network_info_connectivity_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([Connectivity])
void main() {
  late NetWorkInfoConnectivityImp netWorkInfoConnectivityImp;
  late MockConnectivity mockConnectivity;
  late bool connectivityResult;
  setUp(() {
    mockConnectivity = MockConnectivity();
    netWorkInfoConnectivityImp =
        NetWorkInfoConnectivityImp(connectivity: mockConnectivity);
  });
  group("device is online ", () {
    setUp(() {
      connectivityResult = true;
    });

    test("should call the Connectivity().checkCoonnectivity", () async {
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) => Future.value(ConnectivityResult.mobile));

      final result = await netWorkInfoConnectivityImp.isConected;
      verify(mockConnectivity.checkConnectivity());
    });

    test("should return true when the connectivityReuslt is mobile", () async {
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) => Future.value(ConnectivityResult.mobile));

      final result = await netWorkInfoConnectivityImp.isConected;
      verify(mockConnectivity.checkConnectivity());
      expect(result, connectivityResult);
    });
  });

  group("device is offiline", () {
    setUp(() => connectivityResult = false);
    test("should return false when the connectivityReuslt is none", () async {
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) => Future.value(ConnectivityResult.none));

      final result = await netWorkInfoConnectivityImp.isConected;

      expect(result, connectivityResult);
    });
  });
}
