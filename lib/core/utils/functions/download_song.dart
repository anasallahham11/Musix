import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:musix/core/utils/color_manager.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> saveFileToDownloads(
    String fileUrl, String fileName, context) async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    status = await Permission.storage.request();
  }

  if (status.isGranted) {
    Directory? downloadsDirectory = Directory('/storage/emulated/0/Download');

    String savePath = '${downloadsDirectory.path}/$fileName.mp3';

    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Downloading Started...'),
          backgroundColor: ColorManager.success,
        ),
      );
      Dio dio = Dio();
      await dio.download(
        fileUrl,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print("Progress: ${(received / total * 100).toStringAsFixed(0)}%");
          }
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Download complete! File saved to $savePath'),
          backgroundColor: ColorManager.success,
        ),
      );
    } catch (e) {
      // Show error message if download fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error while downloading: $e'),
          backgroundColor: ColorManager.error,
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Storage permission denied'),
        backgroundColor: ColorManager.pending,
      ),
    );
  }
}
