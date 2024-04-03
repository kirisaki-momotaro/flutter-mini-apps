import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _ConverterState extends State<MaterialHomePage>{
  double result = 0;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
 Widget build(BuildContext context) {

    return  Scaffold(
      
        backgroundColor: const Color.fromRGBO(23, 23, 23, 1),
        appBar: AppBar(
          title: const Text('Currency Converter'),          
          backgroundColor: const Color.fromRGBO(82, 82, 82, 1),
          foregroundColor: Colors.white,
        ),
        body: 
         Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${result!=0 ? result.toStringAsFixed(3):result.toStringAsFixed(0)}€',
              style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
             Padding(
              padding: const EdgeInsets.fromLTRB(20, 100, 20, 50),

              child: TextField(
                controller: textEditingController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(
                  color: Colors.black
                ),
                decoration: const InputDecoration(                               
                  hintText: "Enter amount in yen",
                  hintStyle: TextStyle(
                    color: Colors.grey
                  ),
                  suffixIcon: Icon(
                    Icons.currency_yen,
                    color: Colors.black,),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(40))
                  ),
                   
                ),
              ),
            ),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  result=double.parse(textEditingController.text)/163.28 ;
                });
                
               
              },
            style: const ButtonStyle(
              elevation: MaterialStatePropertyAll(15),
              backgroundColor: MaterialStatePropertyAll(Colors.purple),
              fixedSize: MaterialStatePropertyAll(Size(double.infinity, double.infinity)),
            ), 
              child: const Text(
              "Calculate",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255)),
              
            ),
            )
          ],
        )));
  }
}

class MaterialHomePage extends StatefulWidget {  
  const MaterialHomePage({super.key});
  @override
  State<MaterialHomePage> createState() {
     return _ConverterState();
  }
  
}
