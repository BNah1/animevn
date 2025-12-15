// import 'dart:convert';
//
// import 'package:barcode_scan2/barcode_scan2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:safetysigning2022/src/app/core/app_setting.dart';
// import 'package:safetysigning2022/src/app/core/baseViewModel.dart';
// import 'package:safetysigning2022/src/app/helper/validator-helper.dart';
// import 'package:safetysigning2022/src/app/models/domain_api.dart';
// import 'package:safetysigning2022/src/app/models/one_drive/information_user.dart';
// import 'package:safetysigning2022/src/app/models/res-partner.dart';
// import 'package:safetysigning2022/src/app/models/user-internal.dart';
// import 'package:safetysigning2022/src/app/pages/login/webview/web_view_page.dart';
// import 'package:safetysigning2022/src/app/pages/tab/tab_page.dart';
// import 'package:safetysigning2022/src/app/pages_ixhd/tab_ixhd/tab_ixhd_page.dart';
// import 'package:safetysigning2022/src/app/provider/api_master.dart';
// import 'package:safetysigning2022/src/app/service/apple-service.dart';
// import 'package:safetysigning2022/src/app/service/common-service.dart';
// import 'package:safetysigning2022/src/app/service/encrypt-service.dart';
// import 'package:safetysigning2022/src/app/service/googleplus-service.dart';
// import 'package:safetysigning2022/src/app/service/lang/translation_service.dart';
// import 'package:safetysigning2022/src/app/service/one_drive_service/one_drive_service.dart';
// import 'package:safetysigning2022/src/app/service/onesingal-service.dart';
// import 'package:safetysigning2022/src/app/service/qrcode_service.dart';
// import 'package:safetysigning2022/src/app/theme/theme_primary.dart';
// import 'package:safetysigning2022/src/app/widget/popupConfirm.dart';
// import 'package:safetysigning2022/src/app/widget/ts24_utils_widget.dart';
//
// import 'forgetPassword/forget_password_page.dart';
// import 'login_page.dart';
// import 'widget/agree_service_dialog.dart';
//
// class LoginPageViewModel extends GetViewModelBase with WidgetsBindingObserver {
//   final formKey = GlobalKey<FormState>();
//
//   FocusNode emailFocusNode = FocusNode();
//
//   FocusNode passwordFocusNode = FocusNode();
//
//   RxBool isSecurePass = true.obs;
//
//   // String urlDomain = '';
//
//   TextEditingController _emailController = TextEditingController();
//
//   set emailSetter(email) {
//     _emailController.text = email;
//   }
//
//   set passSetter(pass) {
//     _passController.text = pass;
//   }
//
//   get emailController => _emailController;
//   TextEditingController _passController = TextEditingController();
//
//   get passController => _passController;
//
//   RxString errorEmail = "".obs;
//   RxString errorPass = "".obs;
//
//   // String _errorEmail;
//   //
//   // get errorEmail => _errorEmail;
//   //
//   // String _errorPass;
//   //
//   // get errorPass => _errorPass;
//
//   // LoginPageViewModel() {
//   //   // DomainApi domainApi = DomainApi();
//   //   // urlDomain = domainApi.domainUrl;
//   //   //account demo
//   //   // _emailController.text = "luan.vm@safecert.com.vn";
//   //   // _passController.text = "123456";
//   // }
//
//   var urlDomain = ''.obs;
//
//   var langVi = true.obs;
//
//   Rx<Color> colorButtonSignInWithHr24 = Colors.transparent.obs;
//
//   AppLifecycleState state = AppLifecycleState.resumed;
//
//   @override
//   void onInit() async {
//     WidgetsBinding.instance.addObserver(this);
//     super.onInit();
//     WidgetsBinding.instance.addObserver(this);
//     langVi.value = (TranslationService.fallbackLocale.languageCode == 'vi')
//         ? true
//         : false;
//     DomainApi domainApi = DomainApi();
//     if (domainApi.domainUrl != null && domainApi.domainUrl != "") {
//       urlDomain(domainApi.domainUrl!);
//     }
//     // _emailController.text = 'safetysigning@gmail.com';
//     // _emailController.text = 'play@ts24.com.vn';
//     // _emailController.text =  'jaylucin@gmail.com';// 'test@ts24corp.com';
//     // _passController.text = '123456';
//     _emailController.text = "ktpm.ts24@gmail.com";
//     _passController.text = "km!1230TS240789!tm";
//     _emailController.addListener(() {
//       if (_emailController.text.length > 1) isValidEmail();
//     });
//     _passController.addListener(() {
//       isValidPass();
//     });
//     initFocusNodeListener();
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   GuideLineManager()
//     //       .show(GuideLineModelInput(LoginPage.routeName, context));
//     // });
//   }
//
//   initFocusNodeListener() {
//     passwordFocusNode = FocusNode();
//     passwordFocusNode.addListener(() async {
//       if (state == AppLifecycleState.inactive) passwordFocusNode.requestFocus();
//     });
//     emailFocusNode = FocusNode();
//     emailFocusNode.addListener(() async {
//       if (state == AppLifecycleState.inactive) emailFocusNode.requestFocus();
//     });
//   }
//
//   void fieldFocusChange(
//     BuildContext context,
//     FocusNode currentNode,
//     FocusNode nextNode,
//   ) {
//     currentNode.unfocus();
//     if (currentNode != nextNode) FocusScope.of(context).requestFocus(nextNode);
//   }
//
//   onChangeLang(bool isLangVi) {
//     langVi(isLangVi);
//     if (isLangVi)
//       TranslationService.updateLocale(Locale("vi", "VN"));
//     else
//       TranslationService.updateLocale(Locale("en", "US"));
//   }
//
//   bool isValidEmail() {
//     errorEmail.value = "";
//     var resultEmail = Validator.validateEmail(_emailController.text);
//     var resultPhone = Validator.validatePhone(_emailController.text);
//     if (resultEmail != null && resultPhone != null) {
//       errorEmail.value = 'COMMON.EMAIL_PHONE_INVALID'.tr;
//       return false;
//     }
//     return true;
//   }
//
//   bool isValidPass() {
//     errorPass.value = "";
//     var resultPass = Validator.validatePassword(_passController.text);
//     if (resultPass != null) {
//       errorPass.value = resultPass;
//       // this.updateState();
//       return false;
//     }
//     return true;
//   }
//
//   bool isValidInfo() {
//     if (isValidEmail() && isValidPass()) {
//       return true;
//     }
//     return false;
//   }
//
//   // check login
//   onLoginButtonClicked() async {
//     // hide keyboard
//     FocusManager.instance.primaryFocus?.unfocus();
//     if (isValidInfo()) {
//       // Kiểm tra login
//       LoadingDialog.showLoadingDialog(
//         context!,
//         "WAITING_MESSAGE.AUTH_ACCOUNT".tr,
//       );
//       var _checkLogin = await api.checkLogin(
//         username: _emailController.text.trim(),
//         password: _passController.text.trim(),
//       );
//
//       if (_checkLogin == StatusCodeGetToken.TRUE) {
//         //        Navigator.pushReplacementNamed(context, TabsPage.routeName);
//         // get info customer
//         var customerInfo = await api.getCustomerInfoAfterLogin();
//         print('customerinfo $customerInfo');
//         if (customerInfo == null) {
//           LoadingDialog.hideLoadingDialog(context!);
//           return LoadingDialog.showMsgDialog(
//             context!,
//             "ERROR_MESSAGE.PERMISSION_APP".tr,
//           );
//         }
//
//         // Lấy lại accessToken theo user
//         // await api.getAccessTokenBySocialNetWork(_emailController.text.trim());
//         UserInternal userInternal = UserInternal();
//
//         // OneSignalService.sendTags(userInternal.toJsonOneSignal());
//         // OneSignalService.setEmail(userInternal.email.toString());
//
//         //Begin-Phân luồng app Quận
//         // await api.generalThreadingAppQuan();
//         //End-Phân luồng app Quận
//         LoadingDialog.hideLoadingDialog(context!);
//         ToastController.show(
//           context: context!,
//           duration: Duration(milliseconds: 300),
//           message: "WAITING_MESSAGE.PERMISSION_CONNECT".tr,
//         );
//
//         Future.delayed(const Duration(milliseconds: 300), () {
//           PermissionRightType? permissionRightType =
//               ExtensionPermissionRightType.fromString(
//                 userInternal.permissionRightType,
//               );
//           String _route;
//           switch (permissionRightType) {
//             case PermissionRightType.internal:
//               _route = TabsPage.routeName;
//               break;
//             case PermissionRightType.ixhd:
//               _route = TabsIXHDPage.routeName;
//               break;
//             default:
//               _route = TabsPage.routeName;
//               break;
//           }
//
//           Navigator.pushReplacementNamed(context!, _route);
//         });
//       } else {
//         LoadingDialog.hideLoadingDialog(context!);
//         return LoadingDialog.showMsgDialog(
//           context!,
//           "ERROR_MESSAGE.WRONG_LOGIN".tr,
//         );
//       }
//     }
//   }
//
//   void onShowPasswordClicked() {
//     isSecurePass.value = !isSecurePass.value;
//     // this.updateState();
//   }
//
//   void onForgetPasswordClicked() {
//     FocusManager.instance.primaryFocus!.unfocus();
//     Navigator.pushNamed(context!, ForgetPasswordPage.routeName);
//   }
//
//   // onTapRegister() {
//   //   FocusManager.instance.primaryFocus.unfocus();
//   //   Navigator.pushNamed(context, RegisterPage.routeName).then((onValue) {
//   //     if (onValue != null) {
//   //       print('onvalue $onValue');
//   //       List tempt = onValue;
//   //       _emailController.text = tempt[0];
//   //       _passController.text = tempt[1];
//   //     }
//   //   });
//   // }
//
//   onTapLicenses() {
//     Get.toNamed(
//       WebViewPage.routeName,
//       arguments: WebViewArg(
//         title: "DIEU_KHOAN_DICH_VU".tr,
//         url: linkTermsOfService,
//       ),
//     );
//   }
//
//   onTapPolicy() {
//     Get.toNamed(
//       WebViewPage.routeName,
//       arguments: WebViewArg(
//         title: "CHINH_SACH_BAO_MAT".tr,
//         url: linkPrivacyPolicy,
//       ),
//     );
//   }
//
//   onShowAgreeService() async {
//     var result = await showDialog<bool>(
//       context: context!,
//       builder: (BuildContext context) => Dialog(child: AgreeServiceDialog()),
//       barrierDismissible: false,
//     );
//     print("AgreeService $result");
//     return result;
//   }
//
//   googleLogin() async {
//     LoadingDialog.showLoadingDialog(
//       context!,
//       "WAITING_MESSAGE.SOCIAL_NETWORK".tr,
//     );
//     try {
//       if (GooglePlusService.currentUser != null)
//         await GooglePlusService.handleSignOut();
//       var _result = await GooglePlusService.handleSignIn();
//       //    print('${GooglePlusService.currentUser.email}, ${GooglePlusService.currentUser.displayName}');
//       //    print('result $_result');
//       if (_result) {
//         var _checkExist = await api.checkUserExist(
//           GooglePlusService.currentUser!.email,
//         );
//         if (_checkExist == null) {
//           bool agree = await onShowAgreeService();
//           if (!(agree is bool && agree)) {
//             return LoadingDialog.hideLoadingDialog(context!);
//           }
//
//           ResPartner resPartner = new ResPartner();
//           resPartner.email = GooglePlusService.currentUser!.email.trim();
//           resPartner.name = '${GooglePlusService.currentUser!.displayName}';
//           resPartner.password = Common.genRandomNumberString(numberRan: 6);
//           resPartner.phone = "  ";
//           await api.insertUserPortal(resPartner);
//         }
//         LoadingDialog.hideLoadingDialog(context!);
//         await _socialLogin(
//           GooglePlusService.currentUser!.email,
//           TypeLogin.google,
//         );
//         // // Đăng xuất google khi login thành công.
//         // if (GooglePlusService.currentUser != null)
//         //   GooglePlusService.handleSignOut();
//       } else
//         LoadingDialog.hideLoadingDialog(context!);
//     } catch (ex) {
//       debugPrint("google login ex: ${ex.toString()}");
//       LoadingDialog.hideLoadingDialog(context!);
//     }
//   }
//
//   // facebookLogin() async {
//   //   LoadingDialog.showLoadingDialog(
//   //       context!, "WAITING_MESSAGE.SOCIAL_NETWORK".tr);
//   //   try {
//   //     FacebookService facebookService = FacebookService();
//   //     if (facebookService.email != null) await facebookService.handleSignOut();
//   //     var _result = await facebookService.handleSignIn();
//   //     print('fb ${facebookService.email} ${facebookService.name}');
//   //     // if (_result) _socialLogin(facebookService.email, TypeLogin.facebook);
//   //     if (_result) {
//   //       var _checkExist = await api.checkUserExist(facebookService.email);
//   //       if (_checkExist == null) {
//   //         bool agree = await onShowAgreeService();
//   //         if (!(agree is bool && agree)) {
//   //           return LoadingDialog.hideLoadingDialog(context!);
//   //         }
//   //
//   //         ResPartner resPartner = new ResPartner();
//   //         resPartner.email = facebookService.email.trim();
//   //         resPartner.name = '${facebookService.name}';
//   //         resPartner.password = Common.genRandomNumberString(numberRan: 6);
//   //         resPartner.phone = "  ";
//   //         await api.insertUserPortal(resPartner);
//   //       }
//   //       LoadingDialog.hideLoadingDialog(context!);
//   //       _socialLogin(facebookService.email, TypeLogin.facebook);
//   //     } else
//   //       LoadingDialog.hideLoadingDialog(context!);
//   //   } catch (ex) {
//   //     debugPrint(ex.toString());
//   //     LoadingDialog.hideLoadingDialog(context!);
//   //   }
//   // }
//
//   appleLogin() async {
//     LoadingDialog.showLoadingDialog(
//       context!,
//       "WAITING_MESSAGE.SOCIAL_NETWORK".tr,
//     );
//     try {
//       var _result = await AppleService.handleLogin();
//       // LoadingDialog.hideLoadingDialog(context);
//       // if (_result) _socialLogin(AppleService.currentUser.email, TypeLogin.apple);
//       if (_result) {
//         var _checkExist = await api.checkUserExist(
//           AppleService.firebaseUser!.email,
//         );
//         if (_checkExist == null) {
//           bool agree = await onShowAgreeService();
//           if (!(agree is bool && agree)) {
//             return LoadingDialog.hideLoadingDialog(context!);
//           }
//
//           //Kiểm tra nếu người dùng k cho hiện email sau khi login apple id
//           if (AppleService.firebaseUser!.email != null &&
//               AppleService.firebaseUser!.email != "") {
//             ResPartner resPartner = new ResPartner();
//             resPartner.email = AppleService.firebaseUser!.email!.trim();
//             resPartner.name =
//                 '${AppleService.currentUser!.givenName} ${AppleService.currentUser!.familyName}';
//             resPartner.password = Common.genRandomNumberString(numberRan: 6);
//             resPartner.phone = "  ";
//             await api.insertUserPortal(resPartner);
//           } else {
//             LoadingDialog.hideLoadingDialog(context!);
//             return LoadingDialog.showMsgDialog(
//               context!,
//               "ERROR_MESSAGE.PERMISSION_LOGIN_APPLE".tr,
//             );
//           }
//         }
//         LoadingDialog.hideLoadingDialog(context!);
//         _socialLogin(AppleService.firebaseUser!.email, TypeLogin.apple);
//       } else
//         LoadingDialog.hideLoadingDialog(context!);
//     } catch (ex) {
//       debugPrint(ex.toString());
//       LoadingDialog.hideLoadingDialog(context!);
//     }
//   }
//
//   microsoftLogin() async {
//     LoadingDialog.showLoadingDialog(
//       context!,
//       "WAITING_MESSAGE.SOCIAL_NETWORK".tr,
//     );
//     try {
//       InformationUser? informationUser =
//           await OneDriveService.logInSocialMicrosoft(context);
//       // LoadingDialog.hideLoadingDialog(context);
//       // if (_result) _socialLogin(AppleService.currentUser.email, TypeLogin.apple);
//       if (informationUser != null) {
//         var _checkExist = await api.checkUserExist(
//           informationUser.userPrincipalName,
//         );
//         if (_checkExist == null) {
//           bool agree = await onShowAgreeService();
//           if (!(agree is bool && agree)) {
//             return LoadingDialog.hideLoadingDialog(context!);
//           }
//
//           //Kiểm tra nếu người dùng k cho hiện email sau khi login apple id
//           if (informationUser.userPrincipalName != null &&
//               informationUser.userPrincipalName != "") {
//             ResPartner resPartner = new ResPartner();
//             resPartner.email = informationUser.userPrincipalName!.trim();
//             resPartner.name = informationUser.displayName;
//             resPartner.password = Common.genRandomNumberString(numberRan: 6);
//             resPartner.phone = "  ";
//             await api.insertUserPortal(resPartner);
//           } else {
//             LoadingDialog.hideLoadingDialog(context!);
//           }
//         }
//         LoadingDialog.hideLoadingDialog(context!);
//         _socialLogin(informationUser.userPrincipalName, TypeLogin.onedrive);
//       } else
//         LoadingDialog.hideLoadingDialog(context!);
//     } catch (ex) {
//       debugPrint(ex.toString());
//       LoadingDialog.hideLoadingDialog(context!);
//     }
//   }
//
//   _socialLogin(String? email, TypeLogin typeLogin) async {
//     // print('email $email');
//     LoadingDialog.showLoadingDialog(
//       context!,
//       "WAITING_MESSAGE.AUTH_ACCOUNT".tr,
//     );
//     var _checkExist = await api.checkUserExist(email);
//     if (_checkExist != null) {
//       // get info customer
//       var customerInfo = await api.getCustomerInfoAfterLoginSocial(
//         _checkExist.id,
//         username: _checkExist.login,
//       );
//       print('customerinfo $customerInfo');
//       if (customerInfo == null) {
//         LoadingDialog.hideLoadingDialog(context!);
//         return LoadingDialog.showMsgDialog(
//           context!,
//           "ERROR_MESSAGE.PERMISSION_APP".tr,
//         );
//       }
//       // Lấy lại accessToken theo user
//       // await api.getAccessTokenBySocialNetWork(_emailController.text.trim());
//       UserInternal userInternal = UserInternal();
//       OneSignalService.sendTags(userInternal.toJsonOneSignal());
//       LoadingDialog.hideLoadingDialog(context!);
//       ToastController.show(
//         context: context!,
//         duration: Duration(milliseconds: 300),
//         message: "WAITING_MESSAGE.PERMISSION_CONNECT".tr,
//       );
//
//       Future.delayed(const Duration(milliseconds: 300), () {
//         PermissionRightType? permissionRightType =
//             ExtensionPermissionRightType.fromString(
//               userInternal.permissionRightType ?? "",
//             );
//         String _route;
//         switch (permissionRightType) {
//           case PermissionRightType.internal:
//             _route = TabsPage.routeName;
//             break;
//           case PermissionRightType.ixhd:
//             _route = TabsIXHDPage.routeName;
//             break;
//           default:
//             _route = TabsPage.routeName;
//             break;
//         }
//
//         Get.offAndToNamed(_route);
//       });
//     } else {
//       LoadingDialog.hideLoadingDialog(context!);
//     }
//   }
//
//   Future<void> importQRImage({bool showDialog = false}) async {
//     try {
//       String result = (await QrCodeService.fromGallery())!;
//       if (result.isNotEmpty) {
//         UserInternal userInternal = UserInternal();
//         userInternal.domainQrCode = result;
//         String? code = EncrypteService.decryptFernet(result);
//         if (code?.isNotEmpty ?? false) {
//           Map<String, dynamic> jsonConfig = json.decode(code!);
//           DomainApi domain = DomainApi();
//           domain.fromJson(jsonConfig);
//           domain
//               .saveLocal()
//               .whenComplete(() async {
//                 // Lấy language từ api
//                 // await LanguageObjectService.init();
//                 ToastController.show(
//                   context: context!,
//                   message: 'LOGIN_PAGE.IMPORT_QR_SUCCESS'.tr,
//                   duration: Duration(seconds: 2),
//                 );
//                 urlDomain.value = domain.domainUrl!;
//                 if (showDialog) {
//                   LoadingDialog.showMsgDialog(
//                     context!,
//                     "LOGIN_PAGE.HR24_DIALOG".tr,
//                   );
//                 }
//               })
//               .catchError((_) {
//                 ToastController.show(
//                   context: context!,
//                   message: "LOGIN_PAGE.IMPORT_QR_UNSUCCESS".tr,
//                   duration: Duration(seconds: 2),
//                 );
//               });
//         } else {
//           ToastController.show(
//             context: context!,
//             message: 'LOGIN_PAGE.WRONG_FORMAT_CODE'.tr,
//             duration: Duration(seconds: 2),
//           );
//         }
//       }
//     } catch (e) {
//       ToastController.show(
//         context: context!,
//         message: 'LOGIN_PAGE.WRONG_FORMAT_CODE'.tr,
//         duration: Duration(seconds: 2),
//       );
//     }
//   }
//
//   Future<String> scanQR() async {
//     try {
//       ScanOptions options = ScanOptions(
//         strings: {
//           "cancel": 'POPUP_CONFIRM.CANCEL'.tr,
//           "flash_on": 'FLASH_ON'.tr,
//           "flash_off": 'FLASH_OFF'.tr,
//         },
//         restrictFormat: [BarcodeFormat.qr],
//         useCamera: -1,
//         autoEnableFlash: false,
//         android: AndroidOptions(useAutoFocus: true),
//       );
//       ScanResult result = await BarcodeScanner.scan(options: options);
//       return result?.rawContent ?? "";
//     } catch (e) {
//       return "";
//     }
//   }
//
//   Future<void> cameraScanQR({bool showDialog = false}) async {
//     try {
//       String result = await scanQR();
//       if (result.isNotEmpty) {
//         UserInternal userInternal = UserInternal();
//         userInternal.domainQrCode = result;
//         String? code = EncrypteService.decryptFernet(result);
//         if (code?.isNotEmpty ?? false) {
//           Map<String, dynamic> jsonConfig = json.decode(code!);
//           DomainApi domain = DomainApi();
//           domain.fromJson(jsonConfig);
//           domain
//               .saveLocal()
//               .whenComplete(() async {
//                 // Lấy language từ api
//                 // await LanguageObjectService.init();
//                 ToastController.show(
//                   context: context!,
//                   message: 'LOGIN_PAGE.SCAN_QR_SUCCESS'.tr,
//                   duration: Duration(seconds: 2),
//                 );
//                 urlDomain.value = domain.domainUrl!;
//                 if (showDialog) {
//                   LoadingDialog.showMsgDialog(
//                     context!,
//                     "LOGIN_PAGE.HR24_DIALOG".tr,
//                   );
//                 }
//               })
//               .catchError((_) {
//                 ToastController.show(
//                   context: context!,
//                   message: 'LOGIN_PAGE.SCAN_QR_UNSUCCESS'.tr,
//                   duration: Duration(seconds: 2),
//                 );
//               });
//         } else {
//           ToastController.show(
//             context: context!,
//             message: 'LOGIN_PAGE.WRONG_FORMAT_CODE'.tr,
//             duration: Duration(seconds: 2),
//           );
//         }
//       }
//     } catch (e) {
//       ToastController.show(
//         context: context!,
//         message: 'LOGIN_PAGE.WRONG_FORMAT_CODE'.tr,
//         duration: Duration(seconds: 2),
//       );
//     }
//   }
//
//   ///Reset from hr24 domain to dedault domain
//   void resetToDefaultDomain() {
//     popupConfirm(
//       context: context!,
//       title: 'LOGIN_PAGE.ALERT_TITLE'.tr,
//       desc: 'LOGIN_PAGE.ALERT_DESC'.tr,
//       yes: 'LOGIN_PAGE.ALERT_YES'.tr,
//       no: 'LOGIN_PAGE.ALERT_NO'.tr,
//       primaryColor: ThemePrimary.primaryColor,
//       colorButtonYes: ThemePrimary.primaryColor,
//       onTap: () async {
//         DomainApi domain = DomainApi();
//         await domain.clearLocal().whenComplete(() {
//           urlDomain.value = domain.domainUrl!;
//           Future.delayed(const Duration(milliseconds: 500), () {
//             Get.back();
//           });
//         });
//       },
//     );
//   }
//
//   @override
//   void onClose() {
//     WidgetsBinding.instance.removeObserver(this);
//     passwordFocusNode.dispose();
//     emailFocusNode.dispose();
//     super.onClose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//     this.state = state;
//   }
// }
