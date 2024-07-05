import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Triton/api/ftp_upload.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TomaFotoPage extends StatefulWidget {
  @override
  _TomaFotoPageState createState() => _TomaFotoPageState();
}

class _TomaFotoPageState extends State<TomaFotoPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    PermissionStatus cameraPermissionStatus = await Permission.camera.status;
    if (!cameraPermissionStatus.isGranted) {
      await Permission.camera.request();
    }

    PermissionStatus storagePermissionStatus = await Permission.storage.status;
    if (!storagePermissionStatus.isGranted) {
      await Permission.storage.request();
    }
  }

  Future<void> _takePicture() async {
    final size = MediaQuery.of(context).size;
    try {
      final XFile? picture = await _picker.pickImage(
          source: ImageSource.camera,
          maxWidth: size.width * 0.80,
          maxHeight: size.height * 0.70,
          imageQuality: 85);
      setState(() {
        _imageFile = picture;
      });
    } catch (e) {
      print('Error Haciendo fotografía: $e');
    }
  }

  Future<void> _uploadPhoto() async {
    if (_imageFile == null) return;

    setState(() {
      _isUploading = true;
    });

// Obtener el último número secuencial
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int sequenceNumber = (prefs.getInt('sequenceNumber') ?? 0) + 1;

    // Actualizar el número secuencial en SharedPreferences
    await prefs.setInt('sequenceNumber', sequenceNumber);

    // Generar el nombre del archivo
    String formattedDate =
        DateTime.now().toString().split(' ')[0].replaceAll('-', '');
    String fileName = 'foto_${formattedDate}_$sequenceNumber.jpg';

    // Renombrar el archivo con el nombre generado
    String newPath = _imageFile!.path.replaceFirst(RegExp(r'[^/]+$'), fileName);
    File renamedImage = File(_imageFile!.path).renameSync(newPath);

    bool result = await FTPUpload.uploadFile(renamedImage);

    setState(() {
      _isUploading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(result
              ? 'Fotografía enviada correctamente'
              : 'Fallo al enviar la fotografía')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fotografiar'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _imageFile == null
                  ? Text('No hay foto seleccionada')
                  : Image.file(File(_imageFile!.path)),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.photo_camera_outlined),
                onPressed: _takePicture,
                label: Text('Hacer Foto'),
              ),
              SizedBox(height: 0),
              ElevatedButton.icon(
                icon: Icon(Icons.send_and_archive_outlined),
                onPressed: _isUploading ? null : _uploadPhoto,
                label: Text('Enviar Fotografía'),
              ),
              if (_isUploading) CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
