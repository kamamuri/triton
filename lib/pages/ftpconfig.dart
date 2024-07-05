import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FtpConfigPage extends StatefulWidget {
  @override
  _FtpConfigPageState createState() => _FtpConfigPageState();
}

class _FtpConfigPageState extends State<FtpConfigPage> {
  final _formKey = GlobalKey<FormState>();
  final _serverController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _folderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFtpConfig();
  }

  _loadFtpConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _serverController.text = prefs.getString('ftp_server') ?? '';
    _usernameController.text = prefs.getString('ftp_username') ?? '';
    _passwordController.text = prefs.getString('ftp_password') ?? '';
    _folderController.text = prefs.getString('ftp_folder') ?? '';
  }

  _saveFtpConfig() async {
    if (_formKey.currentState?.validate() ?? false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('ftp_server', _serverController.text);
      await prefs.setString('ftp_username', _usernameController.text);
      await prefs.setString('ftp_password', _passwordController.text);
      await prefs.setString('ftp_folder', _folderController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('FTP Configuracion Grabada')),
      );
      Navigator.pop(context); // Volver a la página anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración de FTP'),
      ),
      body: Column(
        children: <Widget>[
          Image.asset('assets/ftp.jpeg'),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _serverController,
                      decoration: InputDecoration(labelText: 'Servidor FTP'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Dirección del servidor FTP';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(labelText: 'Usuario'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Nombre del Usuario';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Clave'),
                      obscureText: true,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Clave de Acceso';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _folderController,
                      decoration: InputDecoration(labelText: 'Carpeta'),
                      obscureText: false,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Carpeta de destino';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _saveFtpConfig,
                      child: Text('Guardar la Configuración'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
