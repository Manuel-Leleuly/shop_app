import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products_provider.dart';

class EditProduct {
  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  bool isFavorite;

  EditProduct({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });
}

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();

  final _imageUrlController = TextEditingController();

  final _form = GlobalKey<FormState>();

  var _editedProduct = EditProduct(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );
  var _initValues = EditProduct(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );
  var _isInit = true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        final selectedProduct =
            Provider.of<ProductsProvider>(context, listen: false)
                .findById(productId);
        _editedProduct = EditProduct(
          id: selectedProduct.id,
          title: selectedProduct.title,
          description: selectedProduct.description,
          price: selectedProduct.price,
          imageUrl: selectedProduct.imageUrl,
          isFavorite: selectedProduct.isFavorite,
        );
        _initValues = EditProduct(
          id: _editedProduct.id,
          title: _editedProduct.title,
          description: _editedProduct.description,
          price: _editedProduct.price,
          imageUrl: '',
        );
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();

    _imageUrlController.dispose();

    _imageUrlFocusNode.removeListener(_updateImageUrl);

    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          (!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final isValid = _form.currentState.validate();
    if (!isValid) return;
    _form.currentState.save();

    final newProduct = Product(
      id: _editedProduct.id,
      title: _editedProduct.title,
      description: _editedProduct.description,
      price: _editedProduct.price,
      imageUrl: _editedProduct.imageUrl,
      isFavorite: _editedProduct.isFavorite,
    );

    if (newProduct.id != null) {
      productProvider.updateProduct(newProduct.id, newProduct);
    } else {
      productProvider.addProduct(newProduct);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues.title,
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  setState(() {
                    _editedProduct.title = newValue;
                  });
                },
              ),
              TextFormField(
                initialValue: _initValues.price.toString(),
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) return 'Please enter a price';
                  if (double.tryParse(value) == null)
                    return 'Please enter a valid number';
                  if (double.parse(value) <= 0)
                    return 'Please enter a number greater than 0';
                  return null;
                },
                onSaved: (newValue) {
                  setState(() {
                    _editedProduct.price = double.parse(newValue);
                  });
                },
              ),
              TextFormField(
                initialValue: _initValues.description,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value.isEmpty) return 'Please enter a description';
                  if (value.length < 10)
                    return 'Should be at least 10 characters long';
                  return null;
                },
                onSaved: (newValue) {
                  setState(() {
                    _editedProduct.description = newValue;
                  });
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        setState(() {});

                        // below is a bit risky
                        _saveForm();
                      },
                      validator: (value) {
                        if (value.isEmpty) return 'Please enter and image URL.';
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'Please enter a valid URL.';
                        }
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('.jpeg')) {
                          return 'Please enter a valid image URL.';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        setState(() {
                          _editedProduct.imageUrl = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
