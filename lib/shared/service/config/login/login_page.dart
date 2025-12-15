// import 'dart:io';
// import 'dart:math' as math;
//
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:safetysigning2022/src/app/core/app_setting.dart';
// import 'package:safetysigning2022/src/app/models/focus_menu.dart';
// import 'package:safetysigning2022/src/app/models/focus_menu_item.dart';
// import 'package:safetysigning2022/src/app/pages/login/widget/custom_switcher.dart';
// import 'package:safetysigning2022/src/app/service/lang/translation_service.dart';
// import 'package:safetysigning2022/src/app/theme/theme_primary.dart';
// import 'package:safetysigning2022/src/app/widget/guideLine/guide_line_manager.dart';
//
// import 'login_page_viewmodel.dart';
//
// enum TypeLogin { facebook, google, apple, onedrive }
//
// class LoginPage extends GetView<LoginPageViewModel> {
//   static const routeName = "/loginPage";
//
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     controller.context = context;
//
//     _body() {
//       Widget __content() {
//         List<BoxShadow> __initBoxShadow() {
//           return [
//             BoxShadow(
//               color: Colors.black12,
//               offset: Offset(0.0, 5.0),
//               blurRadius: 5.0,
//             ),
//             BoxShadow(
//               color: Colors.black12,
//               offset: Offset(0.0, -3.0),
//               blurRadius: 3.0,
//             ),
//           ];
//         }
//
//         Widget ___loginButton() {
//           return Container(
//             height: 50,
//             width: double.infinity,
//             margin: const EdgeInsets.symmetric(horizontal: 30),
//             constraints: BoxConstraints(
//               maxWidth: double.infinity,
//               minHeight: 38,
//             ),
//             child: OutlinedButton(
//               onPressed: () {
//                 controller.onLoginButtonClicked();
//               },
//               style: OutlinedButton.styleFrom(
//                 backgroundColor: Colors.white, // nền trắng
//                 side: BorderSide(
//                   color: ThemePrimary.primaryColor, // viền xanh
//                   width: 1.5,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(50.0), // bo tròn
//                 ),
//               ),
//               child: Text(
//                 "LOGIN_PAGE.SIGN_IN".tr.toUpperCase(),
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: ThemePrimary.primaryColor),
//               ),
//             ),
//           );
//         }
//
//         Widget ___socialLogin() {
//           double widthButton = 240;
//
//           // Widget _loginFacebook() {
//           //   return Container(
//           //     width: 50,
//           //     height: 50,
//           //     decoration: BoxDecoration(
//           //       color: Color(0xff3b5998),
//           //       //shape: BoxShape.circle,
//           //       borderRadius: BorderRadius.circular(10),
//           //       boxShadow: __initBoxShadow(),
//           //     ),
//           //     child: Material(
//           //       color: Colors.transparent,
//           //       child: InkWell(
//           //         borderRadius: BorderRadius.circular(24.0),
//           //         onTap: controller.facebookLogin,
//           //         child: Center(
//           //           child: Icon(
//           //             FontAwesomeIcons.facebook,
//           //             color: Colors.white,
//           //           ),
//           //         ),
//           //       ),
//           //     ),
//           //   );
//           // }
//
//           Widget _loginGoogle() {
//             return Container(
//               height: 50,
//               width: Platform.isIOS ? widthButton : widthButton,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(4.0),
//                 // boxShadow: __initBoxShadow(),
//               ),
//               child: Material(
//                 color: Colors.white,
//                 elevation: 1.0,
//                 borderRadius: BorderRadius.circular(4.0),
//                 child: InkWell(
//                   onTap: controller.googleLogin,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       SizedBox(width: 10),
//                       Image.asset(
//                         "assets/icons/icon-google.png",
//                         width: 30,
//                         height: 30,
//                       ),
//                       SizedBox(width: 10),
//                       Text(
//                         "LOGIN_PAGE.GOOGLE".tr,
//                         style: GoogleFonts.roboto(
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff808483),
//                         ),
//                       ),
//                       SizedBox(width: 15),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//             // return Platform.isIOS
//             //     ? Container(
//             //         width: 50,
//             //         height: 50,
//             //         decoration: BoxDecoration(
//             //           color: Color(0xffDC4E41),
//             //           //shape: BoxShape.circle,
//             //           borderRadius: BorderRadius.circular(10),
//             //           boxShadow: __initBoxShadow(),
//             //         ),
//             //         child: Material(
//             //           color: Colors.transparent,
//             //           child: InkWell(
//             //             borderRadius: BorderRadius.circular(24.0),
//             //             onTap: controller.googleLogin,
//             //             child: Center(
//             //               child: Icon(
//             //                 FontAwesomeIcons.google,
//             //                 color: Colors.white,
//             //               ),
//             //             ),
//             //           ),
//             //         ),
//             //       )
//             //     : Container(
//             //         height: 50,
//             //         decoration: BoxDecoration(
//             //             color: Colors.white,
//             //             borderRadius: BorderRadius.circular(4.0)
//             //             // boxShadow: __initBoxShadow(),
//             //             ),
//             //         child: Material(
//             //           color: Colors.white,
//             //           elevation: 1.0,
//             //           borderRadius: BorderRadius.circular(4.0),
//             //           child: InkWell(
//             //             onTap: controller.googleLogin,
//             //             child: Row(
//             //               children: [
//             //                 SizedBox(
//             //                   width: 10,
//             //                 ),
//             //                 Image.asset("assets/icons/icon-google.png",
//             //                     width: 30, height: 30),
//             //                 SizedBox(
//             //                   width: 10,
//             //                 ),
//             //                 Text(
//             //                   "LOGIN_PAGE.GOOGLE".tr,
//             //                   style: GoogleFonts.roboto(
//             //                       fontWeight: FontWeight.bold,
//             //                       color: Colors.grey),
//             //                 ),
//             //                 SizedBox(
//             //                   width: 15,
//             //                 ),
//             //               ],
//             //             ),
//             //           ),
//             //         ),
//             //       );
//           }
//
//           Widget _loginApple() {
//             return Platform.isIOS
//                 ? Container(
//                     height: 50,
//                     width: widthButton,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(4.0),
//                       // boxShadow: __initBoxShadow(),
//                     ),
//                     child: Material(
//                       color: Colors.white,
//                       elevation: 1.0,
//                       borderRadius: BorderRadius.circular(4.0),
//                       child: InkWell(
//                         onTap: () {
//                           controller.appleLogin();
//                         },
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             SizedBox(width: 10),
//                             Icon(
//                               FontAwesomeIcons.apple,
//                               color: Colors.black,
//                               size: 30,
//                             ),
//                             SizedBox(width: 10),
//                             Text(
//                               "LOGIN_PAGE.APPLE".tr,
//                               style: GoogleFonts.roboto(
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xff808483),
//                               ),
//                             ),
//                             SizedBox(width: 15),
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                 //             Container(
//                 //                     width: 50,
//                 //                     height: 50,
//                 //                     decoration: BoxDecoration(
//                 // //                      color: Color(0xffDC4E41),
//                 //                       //shape: BoxShape.circle,
//                 //                       borderRadius: BorderRadius.circular(10),
//                 //                       color: Colors.black,
//                 // //                      shape: BoxShape.circle,
//                 //                       boxShadow: __initBoxShadow(),
//                 //                     ),
//                 //                     child: Material(
//                 //                       color: Colors.transparent,
//                 //                       child: InkWell(
//                 //                         borderRadius: BorderRadius.circular(24.0),
//                 //                         onTap: () {
//                 //                           controller.appleLogin();
//                 //                         },
//                 //                         child: Center(
//                 //                           child: Icon(
//                 //                             FontAwesomeIcons.apple,
//                 //                             color: Colors.white,
//                 //                             size: 27,
//                 //                           ),
//                 //                         ),
//                 //                       ),
//                 //                     ),
//                 //                   )
//                 : Container();
//           }
//
//           Widget _loginHr24() {
//             return FocusedMenuHolder(
//               canScroll: false,
//               onPressed: () {
//                 /// set màu trắng
//                 /// để hiện background màu trắng khi các option qrcode show lên
//                 controller.colorButtonSignInWithHr24.value = Colors.white;
//                 print("FocusedMenuHolder onPressed");
//               },
//               onFunctionBack: () {
//                 /// set màu transparent
//                 /// để có affect khi long press
//                 controller.colorButtonSignInWithHr24.value = Colors.transparent;
//                 print("onFunctionBack");
//               },
//               menuWidth:
//                   MediaQuery.of(context).orientation == Orientation.portrait
//                   ? MediaQuery.of(context).size.width * 0.88
//                   : MediaQuery.of(context).size.width * 0.5,
//               blurSize: 0.0,
//               menuItemExtent: 40,
//               menuAlignment: Alignment.topCenter,
//               menuBoxDecoration: BoxDecoration(
//                 color: ThemePrimary.primaryColor,
//                 borderRadius: const BorderRadius.only(
//                   bottomRight: Radius.circular(5.0),
//                   bottomLeft: Radius.circular(5.0),
//                 ),
//               ),
//               duration: Duration(milliseconds: 500),
//               animateMenuItems: true,
//               blurBackgroundColor: Colors.black26,
//               menuOffset: 0,
//               isCheckTitle: true,
//               title: "LOGIN_PAGE.HINT_QRCODE_HR24".tr,
//               menuItems: <FocusedMenuItem>[
//                 FocusedMenuItem(
//                   title: Text(
//                     'LOGIN_PAGE.IMPORT_QR'.tr,
//                     textAlign: TextAlign.left,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   trailingIcon: Icon(Icons.library_add, color: Colors.white),
//                   backgroundColor: ThemePrimary.primaryColor,
//                   onPressed: () async {
//                     await controller.importQRImage(showDialog: true);
//                   },
//                 ),
//                 FocusedMenuItem(
//                   title: Text(
//                     'LOGIN_PAGE.SCAN_QR'.tr,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   trailingIcon: Icon(Icons.camera, color: Colors.white),
//                   backgroundColor: ThemePrimary.primaryColor,
//                   onPressed: () async {
//                     await controller.cameraScanQR(showDialog: true);
//                   },
//                 ),
//               ],
//               child: Obx(
//                 () => Container(
//                   height: 50,
//                   width: Platform.isIOS ? widthButton : widthButton,
//                   decoration: BoxDecoration(
//                     color: controller.colorButtonSignInWithHr24.value,
//                     borderRadius: BorderRadius.circular(4.0),
//                     // boxShadow: __initBoxShadow(),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       SizedBox(width: 10),
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(32.0),
//                         child: Image.asset(
//                           "assets/images/logo_hr24staff.png",
//                           width: 30,
//                           height: 30,
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Text(
//                         "LOGIN_PAGE.HR24".tr,
//                         style: GoogleFonts.roboto(
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff808483),
//                         ),
//                       ),
//                       SizedBox(width: 15),
//                     ],
//                   ),
//                 ),
//               ),
//               // Center(
//               //   child: QrImage(
//               //     // backgroundColor: colorBackGroundImage,
//               //     data: "safetysigning",
//               //     version: QrVersions.auto,
//               //     gapless: false,
//               //     size: 60,
//               //     // backgroundColor: Colors.white,
//               //     foregroundColor: ThemePrimary.primaryColor,
//               //   ),
//               // ),
//             );
//           }
//
//           Widget _loginMicrosoft() {
//             return Container(
//               height: 50,
//               width: Platform.isIOS ? widthButton : widthButton,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(4.0),
//                 // boxShadow: __initBoxShadow(),
//               ),
//               child: Material(
//                 color: Colors.white,
//                 elevation: 1.0,
//                 borderRadius: BorderRadius.circular(4.0),
//                 child: InkWell(
//                   onTap: controller.microsoftLogin,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       SizedBox(width: 10),
//                       Image.asset(
//                         "assets/images/microsoft_logo.png",
//                         width: 28,
//                         height: 28,
//                       ),
//                       SizedBox(width: 10),
//                       Text(
//                         "LOGIN_PAGE.MICROSOFT".tr,
//                         style: GoogleFonts.roboto(
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff808483),
//                         ),
//                       ),
//                       SizedBox(width: 15),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//             // return Platform.isIOS
//             //     ? Container(
//             //         width: 50,
//             //         height: 50,
//             //         decoration: BoxDecoration(
//             //           color: Color(0xffDC4E41),
//             //           //shape: BoxShape.circle,
//             //           borderRadius: BorderRadius.circular(10),
//             //           boxShadow: __initBoxShadow(),
//             //         ),
//             //         child: Material(
//             //           color: Colors.transparent,
//             //           child: InkWell(
//             //             borderRadius: BorderRadius.circular(24.0),
//             //             onTap: controller.googleLogin,
//             //             child: Center(
//             //               child: Icon(
//             //                 FontAwesomeIcons.google,
//             //                 color: Colors.white,
//             //               ),
//             //             ),
//             //           ),
//             //         ),
//             //       )
//             //     : Container(
//             //         height: 50,
//             //         decoration: BoxDecoration(
//             //             color: Colors.white,
//             //             borderRadius: BorderRadius.circular(4.0)
//             //             // boxShadow: __initBoxShadow(),
//             //             ),
//             //         child: Material(
//             //           color: Colors.white,
//             //           elevation: 1.0,
//             //           borderRadius: BorderRadius.circular(4.0),
//             //           child: InkWell(
//             //             onTap: controller.googleLogin,
//             //             child: Row(
//             //               children: [
//             //                 SizedBox(
//             //                   width: 10,
//             //                 ),
//             //                 Image.asset("assets/icons/icon-google.png",
//             //                     width: 30, height: 30),
//             //                 SizedBox(
//             //                   width: 10,
//             //                 ),
//             //                 Text(
//             //                   "LOGIN_PAGE.GOOGLE".tr,
//             //                   style: GoogleFonts.roboto(
//             //                       fontWeight: FontWeight.bold,
//             //                       color: Colors.grey),
//             //                 ),
//             //                 SizedBox(
//             //                   width: 15,
//             //                 ),
//             //               ],
//             //             ),
//             //           ),
//             //         ),
//             //       );
//           }
//
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               // SizedBox(
//               //   height: 5,
//               // ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     'LOGIN_PAGE.SOCIAL_LOGIN'.tr,
//                     //                    'Hoặc đăng nhập bằng tài khoản',
//                     style: TextStyle(
//                       //fontWeight: FontWeight.w700,
//                       fontSize: 16,
//                       color: Colors.grey[400],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   // _loginFacebook(),
//                   // SizedBox(
//                   //   width: 10,
//                   // ),
//                   _loginGoogle(),
//                   if (Platform.isIOS) SizedBox(height: 10),
//                   _loginApple(),
//                   SizedBox(height: 10),
//                   _loginMicrosoft(),
//                   // SizedBox(
//                   //   height: 10,
//                   // ),
//                   // _loginHr24(),
//                 ],
//               ),
//               // SizedBox(
//               //   height: 5,
//               // ),
//             ],
//           );
//         }
//
//         Widget ___buildLanguageSwitcher() {
//           var currentLanguage = TranslationService.fallbackLocale.languageCode;
//           var isLeftSelected =
//               currentLanguage.toUpperCase() == 'vi'.toUpperCase();
//           return CustomSwitcher(
//             leftSelectedOnInit: isLeftSelected,
//             valueOne: 'Vi',
//             valueTwo: 'En',
//             onChange: (isLeft) {
//               var selectedLanguage = isLeft ? true : false;
//               print(selectedLanguage);
//               controller.onChangeLang(selectedLanguage);
//             },
//           );
//         }
//
//         Widget ___formLogin() {
//           Widget ___scanQrCode() {
//             return FocusedMenuHolder(
//               key: GuideLineManager()
//                   .loginPageGuideLine
//                   .listGuideLineModel
//                   .first
//                   .key,
//               canScroll: false,
//               onPressed: () {},
//               menuWidth: MediaQuery.of(context).size.width * 0.5,
//               blurSize: 0.0,
//               menuItemExtent: 40,
//               menuAlignment: Alignment.topCenter,
//               menuBoxDecoration: BoxDecoration(
//                 color: ThemePrimary.primaryColor,
//                 borderRadius: BorderRadius.all(Radius.circular(5.0)),
//               ),
//               duration: Duration(milliseconds: 500),
//               animateMenuItems: true,
//               blurBackgroundColor: Colors.black26,
//               menuOffset: 0,
//               menuItems: <FocusedMenuItem>[
//                 FocusedMenuItem(
//                   title: Text(
//                     'LOGIN_PAGE.IMPORT_QR'.tr,
//                     textAlign: TextAlign.left,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   trailingIcon: Icon(Icons.library_add, color: Colors.white),
//                   backgroundColor: ThemePrimary.primaryColor,
//                   onPressed: () async {
//                     await controller.importQRImage();
//                   },
//                 ),
//                 FocusedMenuItem(
//                   title: Text(
//                     'LOGIN_PAGE.SCAN_QR'.tr,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   trailingIcon: Icon(Icons.camera, color: Colors.white),
//                   backgroundColor: ThemePrimary.primaryColor,
//                   onPressed: () async {
//                     await controller.cameraScanQR();
//                   },
//                 ),
//               ],
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(0),
//                   // color: ThemePrimary.primaryColor,
//                   boxShadow: __initBoxShadow(),
//                 ),
//                 child: QrImageView(
//                   padding: EdgeInsets.all(4.12),
//                   backgroundColor: ThemePrimary.primaryColor,
//                   // backgroundColor: colorBackGroundImage,
//                   data: "safetysigning",
//                   version: QrVersions.auto,
//                   gapless: false,
//                   size: 50,
//                   foregroundColor: Colors.white,
//                 ),
//               ),
//               // Center(
//               //   child: QrImage(
//               //     // backgroundColor: colorBackGroundImage,
//               //     data: "safetysigning",
//               //     version: QrVersions.auto,
//               //     gapless: false,
//               //     size: 60,
//               //     // backgroundColor: Colors.white,
//               //     foregroundColor: ThemePrimary.primaryColor,
//               //   ),
//               // ),
//             );
//           }
//
//           Widget ____textField({
//             String? text,
//             required bool obscure,
//             Icon? icon,
//             TextEditingController? controller,
//             FocusNode? focusNode,
//             String? errorText,
//             Function? onSubmit,
//             TextInputType? textInputType,
//             Widget? suffixIcon,
//             List<String>? autofillHints,
//             TextInputAction? textInputAction,
//           }) => Padding(
//             padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//             child: TextField(
//               autofillHints: autofillHints,
//               focusNode: focusNode,
//               style: TextStyle(color: Colors.grey[600]),
//               textAlign: TextAlign.left,
//               obscureText: obscure,
//               autocorrect: false,
//               cursorColor: ThemePrimary.primaryColor,
//               maxLines: 1,
//               controller: controller,
//               keyboardType: textInputType,
//               textInputAction: textInputAction,
//               decoration: InputDecoration(
//                 border: UnderlineInputBorder(),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: ThemePrimary.primaryColor),
//                 ),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//                 errorBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.red),
//                 ),
//                 focusedErrorBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.red),
//                 ),
//                 prefixIcon: icon,
//                 hintText: text,
//                 hintStyle: TextStyle(color: Colors.grey),
//                 errorText: errorText != "" ? errorText : null,
//                 errorMaxLines: 3,
//                 suffixIcon: suffixIcon != null ? suffixIcon : null,
//               ),
//               onSubmitted: onSubmit as void Function(String)?,
//             ),
//           );
//
//           return Column(
//             children: <Widget>[
//               SizedBox(height: 5.0),
//               Container(
//                 margin: EdgeInsets.only(left: 30, right: 30),
//                 child: AutofillGroup(
//                   child: Column(
//                     children: [
//                       Obx(
//                         () => Container(
//                           padding: EdgeInsets.symmetric(vertical: 5.0),
//                           child: ____textField(
//                             autofillHints: [
//                               AutofillHints.username,
//                               AutofillHints.email,
//                             ],
//                             text: "LOGIN_PAGE.EMAIL".tr,
//                             obscure: false,
//                             icon: Icon(
//                               Icons.person,
//                               color: ThemePrimary.iconPrimaryColor,
//                             ),
//                             controller: controller.emailController,
//                             focusNode: controller.emailFocusNode,
//                             errorText: controller.errorEmail.value,
//                             textInputType: TextInputType.emailAddress,
//                             textInputAction: TextInputAction.next,
//                             onSubmit: (_) {
//                               controller.fieldFocusChange(
//                                 context,
//                                 controller.emailFocusNode,
//                                 controller.passwordFocusNode,
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       Obx(
//                         () => Container(
//                           padding: EdgeInsets.symmetric(vertical: 5.0),
//                           child: Stack(
//                             children: <Widget>[
//                               ____textField(
//                                 autofillHints: [AutofillHints.password],
//                                 text: "LOGIN_PAGE.PASSWORD".tr,
//                                 obscure: controller.isSecurePass.value,
//                                 icon: Icon(
//                                   Icons.lock_outline,
//                                   color: ThemePrimary.iconPrimaryColor,
//                                 ),
//                                 controller: controller.passController,
//                                 focusNode: controller.passwordFocusNode,
//                                 errorText: controller.errorPass.value,
//                                 textInputType: TextInputType.visiblePassword,
//                                 textInputAction: TextInputAction.done,
//                                 onSubmit: (_) {
//                                   controller.onLoginButtonClicked();
//                                 },
//                               ),
//                               Align(
//                                 alignment: Alignment.centerRight,
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     controller.onShowPasswordClicked();
//                                   },
//                                   child: Container(
//                                     padding: EdgeInsets.all(5.0),
//                                     margin: EdgeInsets.only(
//                                       right: 25,
//                                       bottom: controller.errorPass != null
//                                           ? 20
//                                           : 0,
//                                     ),
//                                     child: Icon(
//                                       controller.isSecurePass.value
//                                           ? Icons.visibility
//                                           : Icons.visibility_off,
//                                       color: Colors.grey,
//                                       size: 22,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 15),
//                       Text(
//                         "LOGIN_PAGE.CAN_LOGIN_TS24ID".tr,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontStyle: FontStyle.italic,
//                           fontSize: 10,
//                           color: ThemePrimary.textSubColor,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       ___loginButton(),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 8.0),
//               Container(
//                 height: 50,
//                 margin: EdgeInsets.only(left: 30, right: 30),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Expanded(
//                       child: Stack(
//                         alignment: Alignment.centerLeft,
//                         children: [
//                           SizedBox(),
//                           InkWell(
//                             child: Container(
//                               width: 150,
//                               alignment: Alignment.centerLeft,
//                               padding: EdgeInsets.symmetric(vertical: 10),
//                               child: Text(
//                                 'LOGIN_PAGE.FORGOT_PASSWORD'.tr,
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: ThemePrimary.primaryColor,
//                                 ),
//                               ),
//                             ),
//                             onTap: () {
//                               controller.onForgetPasswordClicked();
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     // ___scanQrCode(),
//                     Expanded(
//                       child: Stack(
//                         alignment: Alignment.centerRight,
//                         children: [___buildLanguageSwitcher()],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // SizedBox(height: 10),
//               ___socialLogin(),
//             ],
//           );
//         }
//
//         return Container(color: Colors.white, child: ___formLogin());
//       }
//
//       return OrientationBuilder(
//         builder: (context, orientation) {
//           return LayoutBuilder(
//             builder: (context, constraint) {
//               return SingleChildScrollView(
//                 child: Container(
//                   color: Colors.white,
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(
//                       minHeight: constraint.maxHeight,
//                     ),
//                     child: IntrinsicHeight(
//                       child: Column(
//                         children: <Widget>[
//                           CustomPaint(
//                             painter: CurvePainter(),
//                             child: Container(
//                               alignment: Alignment.center,
//                               width: MediaQuery.of(context).size.width,
//                               height: orientation == Orientation.portrait
//                                   ? MediaQuery.of(context).size.height * 0.25 +
//                                         40
//                                   : MediaQuery.of(context).size.width * 0.25 +
//                                         40,
//                               child: Center(
//                                 child: Padding(
//                                   padding: EdgeInsets.all(10.0),
//                                   child: Image.asset('assets/images/logo.png'),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           // Container(
//                           //   color:
//                           //   // Colors.white,
//                           //   ThemePrimary.primaryColor.withValues(alpha: 0.9),
//                           //   height: orientation == Orientation.portrait
//                           //       ? MediaQuery.of(context).size.height * 0.25 + 40
//                           //       : MediaQuery.of(context).size.width * 0.25,
//                           //   width: MediaQuery.of(context).size.width,
//                           //   child: Column(
//                           //     mainAxisAlignment: MainAxisAlignment.center,
//                           //     children: [
//                           //       Expanded(
//                           //           child: Image.asset('assets/images/logo.png')),
//                           //       Padding(
//                           //         padding: EdgeInsets.symmetric(vertical: 10),
//                           //         child: Text(
//                           //             translation.text('LOGIN_PAGE.WELCOME'),
//                           //             style: TextStyle(
//                           //                 color: Colors.white, fontSize: 22)),
//                           //       ),
//                           //     ],
//                           //   ),
//                           // ),
//                           Expanded(child: __content()),
//                           SizedBox(height: 5),
//                           Align(
//                             alignment: Alignment.bottomCenter,
//                             child: Container(
//                               padding: EdgeInsets.only(bottom: 10),
//                               width: double.infinity,
//                               color: Colors.transparent,
//                               child: Column(
//                                 children: [
//                                   Obx(
//                                     () => Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           controller.urlDomain.value != null &&
//                                                   controller.urlDomain.value !=
//                                                       ''
//                                               ? "${'LOGIN_PAGE.YOU_ACCESSING'.tr}\n${controller.urlDomain.value}"
//                                               : '',
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                             color: Colors.grey,
//                                             fontSize: 15,
//                                           ),
//                                         ),
//                                         controller.urlDomain.value != null &&
//                                                 controller.urlDomain.value != ''
//                                             ? IconButton(
//                                                 onPressed: () {
//                                                   controller
//                                                       .resetToDefaultDomain();
//                                                 },
//                                                 icon: Transform(
//                                                   alignment: Alignment(0, 0),
//                                                   transform: Matrix4.rotationY(
//                                                     math.pi,
//                                                   ), //flip the icon
//                                                   child: Icon(
//                                                     Icons.refresh,
//                                                     color: ThemePrimary
//                                                         .primaryColor,
//                                                   ),
//                                                 ),
//                                               )
//                                             : SizedBox(),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(height: 10),
//                                   Container(
//                                     // height: 50,
//                                     child: Center(
//                                       child: Text(
//                                         "${"VERSION".tr} $version",
//                                         style: TextStyle(color: Colors.grey),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(height: 10),
//                                   RichText(
//                                     textAlign: TextAlign.center,
//                                     text: new TextSpan(
//                                       children: [
//                                         new TextSpan(
//                                           text: 'DIEU_KHOAN_DICH_VU'.tr,
//                                           style: new TextStyle(
//                                             color: ThemePrimary.primaryColor,
//                                           ),
//                                           recognizer: new TapGestureRecognizer()
//                                             ..onTap = () {
//                                               controller.onTapLicenses();
//                                             },
//                                         ),
//                                         new TextSpan(
//                                           text: ' & ',
//                                           style: new TextStyle(
//                                             color: Colors.grey,
//                                           ),
//                                         ),
//                                         new TextSpan(
//                                           text: 'CHINH_SACH_BAO_MAT'.tr,
//                                           style: new TextStyle(
//                                             color: ThemePrimary.primaryColor,
//                                           ),
//                                           recognizer: new TapGestureRecognizer()
//                                             ..onTap = () {
//                                               controller.onTapPolicy();
//                                             },
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       );
//     }
//
//     return Scaffold(resizeToAvoidBottomInset: false, body: _body());
//   }
// }
//
// // class _LoginPageState extends State<LoginPage> {
// //   LoginViewModel viewModel = LoginViewModel();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
// //   }
// //
// //   @override
// //   void dispose() {
// //     SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
// //     super.dispose();
// //   }
// //
// //   @override
// //   void deactivate() {
// //     SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
// //     super.deactivate();
// //   }
// // }
//
// class CurvePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = new Paint()..color = Colors.white;
//     // create a path
//     var path = Path();
//     path.moveTo(0, size.height - 10);
//     path.quadraticBezierTo(
//       size.width * 0.25,
//       size.height * 0.82,
//       size.width * 0.5,
//       size.height * 0.94,
//     );
//     path.quadraticBezierTo(
//       size.width * 0.75,
//       size.height + 8,
//       size.width * 1,
//       size.height * 0.940,
//     );
//     path.lineTo(size.width, 0);
//     path.lineTo(0, 0);
//     canvas.drawShadow(path, Colors.grey.withAlpha(50), 3.0, false);
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }
