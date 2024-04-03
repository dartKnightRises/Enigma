import 'package:local_auth/local_auth.dart';

import '../common_libraries.dart';

class AuthController extends GetxController with WidgetsBindingObserver {
  final LocalAuthentication auth = LocalAuthentication();
  Rx<SupportState> supportState = Rx<SupportState>(SupportState.unknown);
  RxBool? boolCanCheckBiometrics;
  RxList<BiometricType>? biometricTypeAvailableBiometrics;
  RxString stringAuthorized = RxString('Not Authorized');
  RxBool booleanIsAuthenticating = RxBool(false);
  RxBool booleanIsAuthorize = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    checkBiometrics();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      revokeAuthorization();
    }
  }

  Future<void> checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }

    boolCanCheckBiometrics = canCheckBiometrics.obs;

    if (boolCanCheckBiometrics!.value) {
      getAvailableBiometrics();
    }
  }

  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }

    biometricTypeAvailableBiometrics = availableBiometrics.obs;
  }

  Future<void> authenticate() async {
    bool authenticated = false;
    try {
      booleanIsAuthenticating.value = true;
      stringAuthorized.value = 'Authenticating';

      authenticated = await auth.authenticate(
        localizedReason: 'Only You Can See Your Data',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );

      booleanIsAuthenticating.value = false;
    } on PlatformException catch (e) {
      print(e);
      booleanIsAuthenticating.value = false;
      stringAuthorized.value = 'Error - ${e.message}';
      return;
    }

    stringAuthorized.value = authenticated ? 'Authorized' : 'Not Authorized';
    booleanIsAuthorize.value = authenticated ? true : false;
    if(booleanIsAuthorize.value) Get.offNamed( '/home');
  }

  Future<void> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      booleanIsAuthenticating.value = true;
      stringAuthorized.value = 'Authenticating';

      authenticated = await auth.authenticate(
        localizedReason:
        'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      booleanIsAuthenticating.value = false;
    } on PlatformException catch (e) {
      print(e);
      booleanIsAuthenticating.value = false;
      stringAuthorized.value = 'Error - ${e.message}';
      return;
    }

    stringAuthorized.value = authenticated ? 'Authorized' : 'Not Authorized';
    booleanIsAuthorize.value = authenticated ? true : false;
    if(booleanIsAuthorize.value) Get.offNamed( '/home');
  }

  void cancelAuthentication() async {
    await auth.stopAuthentication();
    booleanIsAuthenticating.value = false;
  }

  void revokeAuthorization() {
    if (booleanIsAuthenticating.value) {
      cancelAuthentication();
    }

    // Additional cleanup logic if needed
    // For example, you may want to clear any saved tokens or flags
    stringAuthorized.value = 'Not Authorized';
    booleanIsAuthorize.value =  false;
  }
}

enum SupportState {
  unknown,
  supported,
  unsupported,
}