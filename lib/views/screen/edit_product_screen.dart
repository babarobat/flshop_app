import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit your products'),
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
