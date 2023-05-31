import 'package:flutter/material.dart';
import 'package:tpmproject169/view/kesan_saran.dart';
import 'package:tpmproject169/view/profil.dart';

import 'login_page.dart';
import 'menu.dart';

class KonversiMataUang extends StatefulWidget {
  const KonversiMataUang({super.key});

  @override
  State<KonversiMataUang> createState() => _KonversiMataUangState();
}

class _KonversiMataUangState extends State<KonversiMataUang> {
  late double input;
  late double output;
  late String currencyInput;
  late String currencyOutput;
  late String result;
  TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    input = 0;
    currencyInput = 'IDR';
    currencyOutput = 'IDR';
    result = '';
  }

  void onInputChanged(String value) {
    setState(() {
      input = double.tryParse(value) ?? 0;
    });
  }

  void onCurrencyInputChanged(String? value) {
    setState(() {
      currencyInput = value ?? 'IDR';
    });
  }

  void onCurrencyOutputChanged(String? value) {
    setState(() {
      currencyOutput = value ?? 'IDR';
    });
  }

  void convert() {
    setState(() {
      switch (currencyInput) {
        case 'IDR':
          switch (currencyOutput) {
            case 'IDR':
              output = input;
              break;
            case 'USD':
              output = input / 14200;
              break;
            case 'JPY':
              output = input / 109;
              break;
          }
          break;
        case 'USD':
          switch (currencyOutput) {
            case 'IDR':
              output = input * 14200;
              break;
            case 'USD':
              output = input;
              break;
            case 'JPY':
              output = input * 137;
              break;
          }
          break;
        case 'JPY':
          switch (currencyOutput) {
            case 'IDR':
              output = input * 109;
              break;
            case 'USD':
              output = input * 0.0073;
              break;
            case 'JPY':
              output = input;
              break;
          }
          break;
      }
      result = output.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Konversi Uang'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(18),
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              SizedBox(height: 150),
              const Text(
                'Masukkan Jumlah Uang',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 150),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: TextField(
                      onChanged: onInputChanged,
                      controller: inputController,
                      decoration: const InputDecoration(
                        filled: true,
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          ), //<-- SEE HERE
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade400,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton(
                      value: currencyInput,
                      items: const <String>['IDR', 'USD', 'JPY']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 20),
                          ),
                        );
                      }).toList(),
                      onChanged: onCurrencyInputChanged,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.lightBlueAccent,
                    ),
                    width: MediaQuery.of(context).size.width / 1.4,
                    height: 55,
                    child: Text(
                      result,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade400,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton(
                      value: currencyOutput,
                      items: const <String>['IDR', 'USD', 'JPY']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 20),
                          ),
                        );
                      }).toList(),
                      onChanged: onCurrencyOutputChanged,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: convert,
                child: const Text(
                  'Convert',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.lightBlueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Kesan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        onTap: (value) {
          if (value == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => mainMenu()),
              (Route<dynamic> route) => false,
            );
          }
          if (value == 1) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Profil()));
          }
          if (value == 2) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PesanKesan()));
          }
          if (value == 3) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
              (Route<dynamic> route) => false,
            );
          }
        },
      ),
    );
  }
}
