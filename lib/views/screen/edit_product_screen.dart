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
  var _id = '';

  var _isInit = false;
  var _isLoading = false;

  @override
  void initState() {
    _imageUrlController.addListener(_onImageUrlUpdate);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInit) {
      _isInit = true;

      var args = ModalRoute.of(context)!.settings.arguments;

      if (args is EditProductScreenArgs) {
        var id = args.id;

        if (id.isNotEmpty) {
          var products = context.getProvidedAndForget<Products>();
          var product = products.getById(id);

          if (product != null) {
            _id = product.id;
            _title = product.title;
            _description = product.description;
            _price = product.price;
            _imageUrl = product.imageUrl;

            _imageUrlController.text = _imageUrl;
          }
        }
      }
    }
  }

  @override
  void dispose() {
    _imageUrlController.removeListener(_onImageUrlUpdate);

    super.dispose();
  }

  void _onImageUrlUpdate() {
    setState(() {});
  }

  void _save() async{
    _formKey.currentState?.save();

    if (!_fullEmpty) {
      setState(() {_isLoading = true;});

      var products = context.getProvidedAndForget<Products>();
      var newProduct = Product(
        id: _id,
        title: _title,
        description: _description,
        price: _price,
        imageUrl: _imageUrl,
      );

      try{
        if (_id.isEmpty) {
          await products.add(newProduct);
        } else {
          await products.update(newProduct);
        }
      }catch(e){
        showDialog(
          context: context,
          builder: (c) => AlertDialog(
            title: const Text('error!'),
            content: const Text('error occurred'),
            actions: [
              TextButton(
                onPressed: () {Navigator.of(context).pop();},
                child: const Text('ok'),
              ),
            ],
          ),
        );
      }
      setState(() {_isLoading = true;});

      Navigator.of(context).pop();
    }
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.red,
            ))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _title,
                        decoration: const InputDecoration(labelText: 'Title'),
                        textInputAction: TextInputAction.next,
                        onSaved: _setTitle,
                      ),
                      TextFormField(
                        initialValue: _price.toString(),
                        decoration: const InputDecoration(labelText: 'Price'),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        textInputAction: TextInputAction.next,
                        onSaved: _setPrice,
                      ),
                      TextFormField(
                        initialValue: _description,
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        onSaved: _setDescription,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 8,
                                  right: 10,
                                ),
                                child: Container(
                                  child: _isUrlValid(_imageUrlController.text)
                                      ? Image.network(_imageUrlController.text)
                                      : const Icon(
                                          Icons.image,
                                          size: 100,
                                        ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Image Url'),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                controller: _imageUrlController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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

  bool get _fullEmpty =>
      _title.isEmpty && _description.isEmpty && _imageUrl.isEmpty;
}

class EditProductScreenArgs {
  String id;

  EditProductScreenArgs({this.id = ''});
}
