import 'package:flutter/material.dart';
import 'package:pedulee/widgets/drawer.dart';
import 'package:pedulee/apps/blood/models/blood_models.dart';

class BloodDonationPage extends StatefulWidget {
  const BloodDonationPage({super.key});

  @override
  State<BloodDonationPage> createState() => _BloodDonationPageState();
}
class _BloodDonationPageState extends State<BloodDonationPage>{
  final _formKey = GlobalKey<FormState>();
  String? _golonganDarah;
  String? _rhesus;
  String _penyakitBawaan = "";
  String? _lokasiDonor;
  final _controllerPenyakitBawaan = TextEditingController();

  void clearText() {
    _controllerPenyakitBawaan.clear();

    setState(() {
      _golonganDarah = null;
      _rhesus = null;
      _lokasiDonor = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donasi (Donor) Darah"),
      ),
      drawer: drawerBuild(context),
      body: Form(
        key: _formKey,
        child:
        Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/bg.jpg'),fit:BoxFit.cover),
            ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
             SizedBox(
               width: 150,
               child: DropdownButtonFormField(
                 decoration: InputDecoration(
                     border: OutlineInputBorder(borderRadius:BorderRadius.circular(15.0))
                 ),
                 hint: const Text("Golongan Darah"),
                 value:_golonganDarah,
                 validator: (value)=>
                 value == null ? "Golongan Darah" : null,
                 items:const <DropdownMenuItem<String>>[
                   DropdownMenuItem<String>(
                     value: "A",
                     child: Text("A"),
                   ),
                   DropdownMenuItem<String>(
                     value:"B",
                     child: Text("B"),
                   ),
                   DropdownMenuItem<String>(
                     value:"AB",
                     child: Text("AB"),
                   ),
                   DropdownMenuItem<String>(
                     value:"O",
                     child: Text("O"),
                   ),
                 ],
                 onChanged: (String? value){
                   setState(() {
                     _golonganDarah = value!;
                   });
                 },
               ),
             ),
             const SizedBox(
               height: 10,
             ),
             SizedBox(
               width: 150,
               child: DropdownButtonFormField(
                 decoration: InputDecoration(
                   border: OutlineInputBorder(borderRadius:BorderRadius.circular(15.0)),
                 ),
                 hint: const Text("Rhesus"),
                 value: _rhesus,
                 validator: (value) =>
                 value == null ? "Rhesus" : null,
                 items: const<DropdownMenuItem<String>>[
                   DropdownMenuItem<String>(
                     value : "+",
                     child: Text("+"),
                   ),
                   DropdownMenuItem<String>(
                     value : "-",
                     child: Text("-"),
                   ),
                 ],
                 onChanged: (String? value){
                   setState(() {
                     _rhesus = value!;
                   });
                 },
               ),
             ),
             const SizedBox(
               height: 10,
             ),
             SizedBox(
               width: 150,
               child: DropdownButtonFormField(
                 decoration: InputDecoration(
                     border: OutlineInputBorder(borderRadius:BorderRadius.circular(15.0))
                 ),
               hint: const Text ("Lokasi Donor"),
               value: _lokasiDonor,
               validator: (value) =>
               value == null ? "Lokasi Donor":null,
               items: const <DropdownMenuItem<String>>[
                   DropdownMenuItem<String>(
                     value : "Jakarta",
                     child: Text("Jakarta"),
                   ),
                   DropdownMenuItem<String>(
                     value : "Depok",
                     child : Text("Depok"),
                   ),
                   DropdownMenuItem<String>(
                     value : "Bogor",
                     child : Text("Bogor"),
                   ),
                   DropdownMenuItem<String>(
                     value : "Bandung",
                     child : Text("Bandung"),
                   ),
                 ],
                 onChanged: (String? value){
                   setState(() {
                     _lokasiDonor = value!;
                   });
                 },
               ),
             ),
             const SizedBox(
               height: 10,
             ),
             TextFormField(
               controller: _controllerPenyakitBawaan,
               decoration: InputDecoration(
                 hintText: "Contoh : Jantung",
                 labelText: "Penyakit Bawaan (jika ada)",
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(5.0),
                 ),
               ),
               onChanged: (String? value){
                 setState(() {
                   _penyakitBawaan = value!;
                 });
               },
               validator: (String? value){
                 if (value == null || value.isEmpty){
                   return "Tidak boleh kosong";
                 }
                 return null;
               },
             ),
             const SizedBox(
               height: 30,
             ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.blueAccent,
                   shadowColor: Colors.blueAccent,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: Size(300,50)
                 ),
                 onPressed: (){
                   if(_formKey.currentState!.validate()){
                     ListBlood.data.add(Blood(_golonganDarah!, _rhesus!, _penyakitBawaan, _lokasiDonor!));
                     clearText();
                   }
                 },
                 child: const Text("Simpan",
                 style: TextStyle(color: Colors.black),
                 ),
               ),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                onPressed: clearText,
                style: ElevatedButton.styleFrom(
               backgroundColor: Colors.redAccent,
               shadowColor: Colors.redAccent,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(32.0)),
               minimumSize: Size(300,50)
               ),
              child: const Text("Discard",
              style: TextStyle(color:Colors.black),),
             ),
             ]),

           ],
          )
        ),
      ),
    );
  }
}