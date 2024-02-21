import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final double size;

  const LoadingWidget({Key? key, this.size = 36.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: kIsWeb
            ? const CircularProgressIndicator(
                strokeWidth: 2.0,
                color: Colors.blue,
              )
            : Platform.isIOS
                ? const CupertinoActivityIndicator(
                    color: Colors.blue,
                  )
                : const CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: Colors.blue,
                  ),
      ),
    );
  }
}
