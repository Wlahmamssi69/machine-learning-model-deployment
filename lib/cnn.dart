import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class cnn extends StatefulWidget {
  const cnn({super.key});

  @override
  _cnnState createState() => _cnnState();
}

class _cnnState extends State<cnn> {

final ImagePicker picker=ImagePicker();
XFile? _imageFile;


@override
void initState(){
  super.initState();

}

Future initModel() async {
  String? res = await Tflite.loadModel(
  model: "assets/model.tflite"
);
 return res;
}

Future<void> _pickImage(ImageSource source) async {
  XFile? pickedImage = await picker.pickImage(source: source);
  setState(() {
    _imageFile = pickedImage;

  });
}

Future predict() async{
    var recognitions = await Tflite.runModelOnImage(
      path: _imageFile!.path,   // required
      imageMean: 0.0,   // defaults to 117.0
      imageStd: 255.0,  // defaults to 1.0
      numResults: 1,    // defaults to 5
      threshold: 0.2,   // defaults to 0.1
      asynch: true      // defaults to true
    );

print(recognitions);
    return recognitions;
}

  
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar:AppBar(title: const Text('CNN ALGORITHM'),
      systemOverlayStyle: const SystemUiOverlayStyle(
        systemNavigationBarColor:Colors.blue,
        statusBarColor:Colors.blue
      ),
      ),
      body:
      Column(
        children:[
          Container(
            width:MediaQuery.of(context).size.width,
            height:300,
            color:Colors.grey

          ),

           Row(
             mainAxisAlignment:MainAxisAlignment.center,
             children: [
    ElevatedButton(onPressed: (){
       _pickImage(ImageSource.gallery);
    }, child: const Text('Load an image')),
    ElevatedButton(onPressed: (){
       
            _pickImage(ImageSource.camera);
    }, 
    child: const Text('Take a picture')),
    ElevatedButton(onPressed: (){
       
      predict();
    }, 
    child: const Text('Predict'))

    ],)
        ]


      )
,



    );
    
    
    
    
  }
}