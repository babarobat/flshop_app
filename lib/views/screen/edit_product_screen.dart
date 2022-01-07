import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/ext/build_context_extensions.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var _title = '';
  var _price = 0.0;
  var _description = '';
  var _imageUrl = '';

  @override
  void initState() {
    _imageUrlController.addListener(_onImageUrlUpdate);

    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.removeListener(_onImageUrlUpdate);

    super.dispose();
  }

  void _onImageUrlUpdate() {
    setState(() {});
  }

  void _save() {
    _formKey.currentState?.save();

    if(!_fullEmpty){
      var products = context.getProvidedAndForget<Products>();

      products.add(Product(
        id: DateTime.now().toString(),
        title: _title,
        description: _description,
        price: _price,
        imageUrl: _imageUrl,
      ));
    }

    Navigator.of(context).pop();
  }

  void _setTitle(String? value) {
    if (value is String) {
      _title = value;
    }
  }

  void _setDescription(String? value) {
    if (value is String) {
      _description = value;
    }
  }

  void _setPrice(String? value) {
    if (value is String) {
      var d = double.tryParse(value);
      if (d is double) {
        _price = d;
      }
    }
  }

  void _setImageUrl(String? value) {
    if (value is String) {
      if (_isUrlValid(value)) {
        _imageUrl = value;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit your products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: _save,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onSaved: _setTitle,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.next,
                  onSaved: _setPrice,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  onSaved: _setDescription,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(
                          top: 8,
                          right: 10,
                        ),
                        child: Container(
                          child: _isUrlValid(_imageUrlController.text)
                              ? FittedBox(
                                  fit: BoxFit.cover,
                                  child:
                                      Image.network(_imageUrlController.text),
                                )
                              : const FittedBox(
                                  fit: BoxFit.cover,
                                  child: Icon(Icons.image),
                                ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Image Url'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: _validateUrl,
                          onSaved: _setImageUrl,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateUrl(String? value) {
    if (value!.isNotEmpty &&
        (value.startsWith('http') || value.startsWith('https')) &&
        (value.endsWith('png') ||
            value.endsWith('jpg') ||
            value.endsWith('jpeg'))) {
      return null;
    }

    return 'Invalid image url';
  }

  bool _isUrlValid(String? value) => _validateUrl(value) == null;
  bool get _fullEmpty => _title.isEmpty && _description.isEmpty && _imageUrl.isEmpty;
}
