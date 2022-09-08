import 'dart:io'; // مهم جدا الباكدج ديه 
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TestCamera extends StatefulWidget {
  const TestCamera({Key? key}) : super(key: key);

  @override
  State<TestCamera> createState() => _TestCameraState();
}

class _TestCameraState extends State<TestCamera> {
  
PlatformFile ? platformFile;
  Future selectFile()async{
    final result = await FilePicker.platform.pickFiles();
    if(result==null)return;
    setState(() {
      platformFile = result.files.first;
    });
  }
Future UploadFile()async{
  final path = 'files/${platformFile?.name}';
  final file = File(platformFile!.path!);
  
  

  final ref = FirebaseStorage.instance.ref().child(path);
  ref.putFile(file);
}
   
  @override
  
  Widget build(BuildContext context) {
 
    return Scaffold(
      floatingActionButton:FloatingActionButton(
        
        onPressed: () async
        {
            await uploadImage();
        },
        child: Icon(Icons.add),
        ) ,
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(platformFile!=null)
            Expanded(
              child: Container(
                color: Colors.blue[100],
              child: Center(
                child: Image.file(File(platformFile!.path!),
                width: double.infinity,
                fit: BoxFit.cover,
                ),  
                ),
            )
            ),
          const  SizedBox(height: 30,), 
            ElevatedButton(
              onPressed: () 
              {
                selectFile();
              }, 
            child: const Text('Select File'),
            ),
             ElevatedButton(
              onPressed: () 
              {
                UploadFile();
              }, 
            child: const Text('Upload File'),
            ),
          ],
        ) ,

        
      ) ;

           
  }
 // لازم تحميل باكدج اللى هي  
 // ImagePicker   
  File? imgPath; 
  uploadImage() async {
    final pickedImg = await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        setState(() {imgPath = File(pickedImg.path);});
    } else {print("NO img selected");}
    } catch (e) {print("Error => $e");}
}







}