import 'package:flutter/material.dart';
import 'package:webview_windows/webview_windows.dart';
import '../constants/variables.dart';

class barcodePrint extends StatefulWidget {
  final int invoicePurchaseId;
  const barcodePrint({Key? key, required this.invoicePurchaseId})
      : super(key: key);

  @override
  State<barcodePrint> createState() => barcodePrintState();
}

class barcodePrintState extends State<barcodePrint> {
  final _controller = WebviewController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    await _controller.initialize();
    await _controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
    setState(() {
      _controller.loadUrl(
          '${Variables.apiUrl}barcode/print.php?invoicePurchasesId=${widget.invoicePurchaseId}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Webview(
        _controller,
      ),
    );
  }
}
