import 'package:camera_app/pages/camera_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Just a camera app!!'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            //pick a fun image of your choise
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Lets take some cool photos!!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImageLibraryPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      const Size.fromHeight(60), // Doubles the height of the button
                ),
                child: const Text('Start'),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}