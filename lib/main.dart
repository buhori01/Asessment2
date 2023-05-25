import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class JenisKendaraan {
  String label;
  bool isSelected;

  JenisKendaraan({required this.label, required this.isSelected});

  @override
  String toString() {
    return label;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wireframe Layout',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: {
        '/second': (context) => SecondPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController namaMahasiswaController = TextEditingController();
  TextEditingController prodiController = TextEditingController();
  TextEditingController fakultasController = TextEditingController();
  TextEditingController pinjamController = TextEditingController();
  List<JenisKendaraan> jenisKendaraanList = [];
  bool pilihan1 = false;
  bool Pilihan2 = false;

  @override
  void initState() {
    super.initState();
    jenisKendaraanList = [];
  }

  void navigateToSecondPage() {
    final selectedJenisKendaraan = jenisKendaraanList.firstWhere(
        (jenisKendaraan) => jenisKendaraan.isSelected,
        orElse: () => jenisKendaraanList[10]);

    selectedJenisKendaraan.isSelected = true;

    Navigator.pushNamed(
      context,
      '/second',
      arguments: {
        'namaMahasiswa': namaMahasiswaController.text,
        'prodi': prodiController.text,
        'fakultas': fakultasController.text,
        'pinjam': pinjamController.text,
        'jenisKendaraan': selectedJenisKendaraan.isSelected,
        'pilihan1': pilihan1,
        'pilihan2': Pilihan2,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(top: 40.0, right: 20.0, left: 20.0, bottom: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: namaMahasiswaController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  labelText: "Nama ",
                  hintText: "Masukkan Nama ",
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: prodiController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  labelText: "Prodi",
                  hintText: "Masukkan Nama Prodi",
                ),
                maxLines: 1,
              ),
              SizedBox(height: 15),
              TextField(
                controller: fakultasController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  labelText: "Fakultas",
                  hintText: "Masukkan Nama Fakultas",
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: pinjamController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  labelText: "Keperluan",
                  hintText: "Masukkan Alasan",
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 10.0),
                child: Text(
                  'Jenis Kendaraan :',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: jenisKendaraanList
                    .map(
                      (jenisKendaraan) => RadioListTile(
                        title: Text(jenisKendaraanList.toString()),
                        value: jenisKendaraanList,
                        groupValue: jenisKendaraanList.firstWhere(
                          (jenis) => jenis.isSelected,
                          orElse: () => jenisKendaraanList[0],
                        ),
                        onChanged: (value) {
                          setState(() {
                            jenisKendaraanList
                                .forEach((item) => item.isSelected = false);
                            jenisKendaraan.isSelected = true;
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Avanza/Xenia'),
                  Checkbox(
                    value: pilihan1,
                    onChanged: (value) {
                      setState(() {
                        pilihan1 = value ?? false;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Elf'),
                  Checkbox(
                    value: Pilihan2,
                    onChanged: (value) {
                      setState(() {
                        Pilihan2 = value ?? false;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 100),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: navigateToSecondPage,
                  child: Text('KIRIM PERMINTAAN'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama : ${data['namaMahasiswa']}'),
              SizedBox(height: 10),
              Text('Prodi: ${data['prodi']}'),
              SizedBox(height: 10),
              Text('Fakultas: ${data['fakultas']}'),
              SizedBox(height: 10),
              Text('Jenis Kendaraan: ${data['jenisKendaraan'].toString()}'),
              SizedBox(height: 10),
              Text('Keperluan: ${data['pinjam']}'),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
