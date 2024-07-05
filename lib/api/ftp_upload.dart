import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ftpconnect/ftpconnect.dart';

class FTPUpload {
  static Future<bool> uploadFile(File file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ftpServer = prefs.getString('ftp_server');
    String? ftpUsername = prefs.getString('ftp_username');
    String? ftpPassword = prefs.getString('ftp_password');
    String? ftpFolder = prefs.getString('ftp_folder');

    if (ftpServer == null || ftpUsername == null || ftpPassword == null) {
      return false;
    }

    FTPConnect ftpConnect =
        FTPConnect(ftpServer, user: ftpUsername, pass: ftpPassword);

    try {
      await ftpConnect.connect();
      await ftpConnect.changeDirectory(ftpFolder);
      bool result = await ftpConnect.uploadFile(file);
      await ftpConnect.disconnect();
      return result;
    } catch (e) {
      print('Error enviando el fichero: $e');
      return false;
    }
  }
}
