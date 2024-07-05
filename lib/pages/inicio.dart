import 'package:flutter/material.dart';
import 'package:Triton/pages/ftpconfig.dart';
import 'package:Triton/pages/tomafoto.dart';
import 'package:Triton/widgets/circulos.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              right: -size.width * 0.22,
              top: -size.width * 0.36,
              child: Circulos(radio: size.width * 0.45, colors: const [
                Color.fromARGB(255, 4, 50, 87),
                Colors.blueAccent
              ]),
            ),
            Positioned(
              left: -size.width * 0.15,
              top: -size.width * 0.34,
              child: Circulos(
                  radio: size.width * 0.35,
                  colors: const [Colors.white60, Colors.cyanAccent]),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 130),
                      child: GestureDetector(
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 9,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black,
                              image: const DecorationImage(
                                  image: AssetImage("assets/logo.jpeg"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          onTap: () {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (context) => FtpConfigPage()),
                            );
                          }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "INFORMÁTICA Y",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromARGB(255, 13, 78, 132)),
                ),
                const Text(
                  "TELECOMUNICACIONES",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromARGB(255, 13, 78, 132)),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Avda. Victoria Nº 6 Local G",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromARGB(255, 232, 47, 108)),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "29400 Ronda - Málaga",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromARGB(255, 232, 47, 108)),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "http://www.tritoncomputer.es",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color.fromARGB(255, 15, 118, 30)),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color.fromARGB(255, 13, 88, 150),
                        ),
                        onPressed: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                                builder: (context) => TomaFotoPage()),
                          );
                        },
                        icon: const Icon(Icons.photo_camera_outlined),
                        label: const Text("Fotografiar y enviar"))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
