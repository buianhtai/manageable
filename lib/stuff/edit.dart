import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/input_tags.dart';
import 'package:intl/intl.dart';
import 'package:manageable/common/constants.dart';
import 'package:manageable/common/image_file.dart';
import 'package:manageable/core/image_compressor.dart';
import 'package:manageable/stuff/constants.dart';
import 'package:manageable/stuff/stuff.dart';
import 'package:flutter/foundation.dart';
import 'package:manageable/stuff/service.dart' as service;

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class StuffEdit extends StatefulWidget {
  final Stuff stuff;

  const StuffEdit({Key key, this.stuff}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StuffEditState(stuff);
  }
}

class StuffEditState extends State<StuffEdit> {
  final _formKey = GlobalKey<FormState>();

  bool isSaving = false;

  Stuff stuff;

  final _titleTextController = TextEditingController();
  final _priceTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();

  String _currency = 'VND';
  String _category = 'Clothing';

  DateTime _boughtDate = DateTime.now();
  DateTime _lastUsed = DateTime.now();
  List<String> _tags = [];

  List<ImageFile> images = [];

  StuffEditState(this.stuff);

  @override
  void initState() {
    super.initState();

    if(this.stuff != null) {
      _titleTextController.text = this.stuff.title;
      _descriptionTextController.text = this.stuff.description;
      _priceTextController.text = this.stuff.price.toString();
      _currency = this.stuff.currency;
      _category = this.stuff.category;
      _boughtDate = DateTime.fromMillisecondsSinceEpoch(this.stuff.boughtDate);
      _tags = this.stuff.tags;

      if(this.stuff.picture != null) {
        ImageFile f = ImageFile();
        f.downloadUrl = this.stuff.picture;
        f.thumbnailDownloadUrl = this.stuff.thumbnail;
        images.add(f);
      }
    }
  }

  Future _pickImageFromGallery() async {
    File f = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(f != null) {
      _setImage(f);
    }
  }

  Future _takePicture() async {
    File f = await ImagePicker.pickImage(source: ImageSource.camera);
    if(f != null) {
      _setImage(f);
    }
  }

  _setImage(File f) {
    setState(() {
      isSaving = true;
    });

    Uint8List imageData = compressImage(f.readAsBytesSync(), HD_SIZE);
    Uint8List thumbnailImageData = compressImage(imageData, THUMBNAIL_SIZE);

    setState(() {
      ImageFile imageFile = ImageFile();
      imageFile.data = imageData;
      imageFile.thumbnailData = thumbnailImageData;

      // TODO support one image by now
      if(images.isNotEmpty) {
        images.removeLast();
      }
      images.add(imageFile);

      setState(() {
        isSaving = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double image_width = width * 0.65;

    return Scaffold(
      appBar: AppBar(
        title: Text(stuff == null ? 'New stuff' : stuff.title),
        leading: CloseButton(),
        actions: <Widget>[
          IconButton(
            onPressed: _pickImageFromGallery,
            icon: Icon(Icons.image),
          ),
          IconButton(
            onPressed: _takePicture,
            icon: Icon(Icons.camera),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isSaving = true;
              });
              saveStuff().then((onValue) {
                setState(() {
                  isSaving = false;
                });

                Navigator.pop(context, null);
              });
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: ModalProgressHUD(
          inAsyncCall: isSaving,
          child: SingleChildScrollView(
            child: Padding(
          padding: new EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Title'
                  ),
                  controller: _titleTextController,
                ),
                DropdownButton<String>(
                  items: CATEGORIES.map((c) => DropdownMenuItem<String>(
                    value: '$c',
                    child: Text('$c'),
                  )).toList(),
                  value: _category,
                  onChanged: _onCategoryChange,
                ),
                DateTimePickerFormField(
                  format: DateFormat(DATE_FORMAT),
                  decoration: InputDecoration(
                    labelText: 'Bought date'
                  ),
                  initialValue: _boughtDate,
                  dateOnly: true,
                  onChanged: (d) {
                    _boughtDate = d;
                  },
                ),
                DateTimePickerFormField(
                  format: DateFormat(DATE_FORMAT),
                  decoration: InputDecoration(
                      labelText: 'Last used'
                  ),
                  initialValue: _lastUsed,
                  dateOnly: true,
                  onChanged: (d) {
                    _lastUsed = d;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: '0.00',
                      labelText: 'Price',
                  ),
                  keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                  controller: _priceTextController,
                ),
                DropdownButton<String>(
                  items: CURRENCIES.map((c) => DropdownMenuItem<String>(
                    value: '$c',
                    child: Text('$c'),
                  )).toList(),
                  value: _currency,
                  onChanged: _onCurrencyChange,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Notes'
                  ),
                  controller: _descriptionTextController,
                ),
                InputTags(
                  tags: _tags,
                  onDelete: (tag){
                    print(tag);
                  },
                  onInsert: (tag){
                    print(tag);
                  },
                ),
                images == null || images.isEmpty
                    ? Container()
                    : Column(
                  children: images.map(
                          (f) => Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    f.data != null
                                        ? Image.memory(f.data, width: image_width)
                                        : Image.network(f.downloadUrl, width: image_width,),
                                    IconButton(
                                      icon: Icon(Icons.remove_circle),
                                      color: Colors.red,
                                      onPressed: () {
                                        setState(() {
                                          images.remove(f);
                                        });
                                      },
                                    ),
                                  ],
                              )
                          )
                  ).toList(),
                )
              ],
            ),
          )
        ))
      )
    );
  }

  Future saveStuff() async {
    var data = {
      'title': _titleTextController.text,
      'description': _descriptionTextController.text,
      'category': _category,
      'price': _priceTextController.text.isEmpty ? double.parse('0.0') : double.parse(_priceTextController.text),
      'currency': _currency,
      'boughtDate': _boughtDate.millisecondsSinceEpoch,
      'picture': (images.isEmpty || this.stuff == null) ? null: stuff.picture,
      'thumbnail': (images.isEmpty || this.stuff == null) ? null: stuff.thumbnail,
      'tags': _tags,
    };

    DocumentReference documentReference;
    if(this.stuff == null) {
      documentReference = await service.createStuff(data);
    } else {
      print('updated stuff ' + stuff.reference.path);
      await service.updateStuff(stuff.reference.path, data);
      documentReference = stuff.reference;
    }

    if(images.isEmpty) {
      if(stuff == null || (stuff.picture == null || stuff.picture == '')) {
        return Future.value();
      }
      // remove image
      await FirebaseStorage.instance.ref().child(stuff.thumbnail).delete();
      return FirebaseStorage.instance.ref().child(stuff.picture).delete();
    }

    // stuff is updated but keep the picture
    if(!isNewImageUploaded()) {
      return Future.value(0);
    }

    // remove old image
    if(stuff != null && stuff.picture != null) {
      await FirebaseStorage.instance.ref().child(stuff.picture).delete();
      await FirebaseStorage.instance.ref().child(stuff.thumbnail).delete();
    }

    // upload new image
    return uploadImage(documentReference.documentID).then((iValue) {
      return uploadThumbnailImage(documentReference.documentID).then((tValue) {
        return documentReference.setData({
              'picture': iValue,
              'thumbnail': tValue}, merge: true);
      });
    });
  }

  isNewImageUploaded() {
    return images.isNotEmpty && images.elementAt(0).downloadUrl == null;
  }

  Future<dynamic> uploadImage(stuffId) {
    StorageReference reference = FirebaseStorage.instance.ref().child(stuffId);

    StorageUploadTask task = reference.putData(images.elementAt(0).data);
    return task.onComplete.then((taskSnapshot) {
      return taskSnapshot.ref.getDownloadURL();
    });
  }

  Future<dynamic> uploadThumbnailImage(stuffId) {
    StorageReference reference = FirebaseStorage.instance.ref().child('thumb_' + stuffId);

    StorageUploadTask task = reference.putData(images.elementAt(0).thumbnailData);
    return task.onComplete.then((taskSnapshot) {
      return taskSnapshot.ref.getDownloadURL();
    });
  }

  void _onCurrencyChange(String selectedCurrency) {
    setState(() {
      _currency = selectedCurrency;
    });
  }

  void _onCategoryChange(String selectedCategory) {
    setState(() {
      _category = selectedCategory;
    });
  }
}