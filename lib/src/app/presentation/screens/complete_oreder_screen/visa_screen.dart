import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:labour/src/app/domain/entity/service_entity.dart';
import 'package:labour/src/core/api/api_constant.dart';
import 'package:labour/src/core/app_prefs/app_prefs.dart';
import 'package:labour/src/core/resources/flutter_toast.dart';
import 'package:labour/src/core/resources/routes_manager.dart';
import 'package:labour/src/core/services_locator/services_locator.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class VisaScreen extends StatefulWidget {
  final ServiceEntity serviceEntity;

  const VisaScreen({
    Key? key,
    required this.serviceEntity,
  }) : super(key: key);

  @override
  State<VisaScreen> createState() => _VisaScreenState();
}

class _VisaScreenState extends State<VisaScreen> {
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    _controller = WebViewController.fromPlatformCreationParams(params);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(
        const Color(0x00000000),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          print('onMessageReceived onMessageReceived');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            // debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) async {
/*
            debugPrint('Page finished loading: $url');
*/
            final userToken = sl<AppPreferences>().getUserToken();

            if (url.contains('success=false')) {
              showToast(
                  'Please Enter A valid Card ', ToastStates.ERROR, context);
              print('success=falsesuccess=falsesuccess=false');
            }

            if (url.contains('success=true')) {
              await FirebaseFirestore.instance
                  .collection('user')
                  .doc(userToken)
                  .collection('service')
                  .doc(widget.serviceEntity.serviceUid)
                  .update({
                'service_status': 'done',
                'payment_status': true,
              }).then((value) {
                showDialog(
                    context: context,
                    builder: (_) => Container(
                          width: 120,
                          height: 120,
                          color: Colors.black26,
                          child: TextButton(
                            onPressed: () {
                              context.goNamed(Routes.homeScreen);
                            },
                            child: Text('Go Home'),
                          ),
                        ));
              });
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.google.com/')) {
              debugPrint('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..loadRequest(Uri.parse(ApiPaymentConstant.visaUrl));

    if (_controller!.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (_controller!.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          actions: [
            IconButton(
              onPressed: () {
                paymentExitApp(context);
              },
              icon: const Icon(
                Icons.exit_to_app,
              ),
            )
          ],
        ),
        body: WebViewWidget(
          controller: _controller!,
        ),
      ),
    );
  }
}

void paymentExitApp(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text(
          'Are you sure  completed the pay',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // context.pop();
              context.goNamed(Routes.homeScreen);
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
        ],
      );
    },
  );
}
