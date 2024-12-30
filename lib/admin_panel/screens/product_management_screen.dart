import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductManagementScreen extends StatefulWidget {
  final String business;
  const ProductManagementScreen({super.key, required this.business});

  @override
  _ProductManagementScreenState createState() =>
      _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final productImageController = TextEditingController();
  final quantityController = TextEditingController();

  // Function to add a product
  void _addProduct() async {
    if (_formKey.currentState!.validate()) {
      final String name = nameController.text.trim();
      final String price = priceController.text.trim();
      final String description = descriptionController.text.trim();
      final String image = _imageUrl!;
      final String quantity = quantityController.text.trim();
      int product_id = (10000000 + Random().nextInt(90000000));

      try {
        await Supabase.instance.client.from('products').insert({
          'name': name,
          'price': price,
          'description': description,
          'product_image': image,
          'business_id': widget.business,
          'product_id': product_id
        });

        await Supabase.instance.client.from('inventory').insert({
          'product_id': product_id,
          'business_id': widget.business,
          'product_name': name,
          'quantity': quantity
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added successfully!')),
        );

        // Clear the input fields
        setState(() {
          nameController.clear();
          priceController.clear();
          descriptionController.clear();
          productImageController.clear();
          quantityController.clear();
        });
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add product: $error')),
        );
      }
    }
  }

  File? _selectedImage;
  String? _imageUrl;
  bool _isUploading = false;
  final SupabaseClient supabase = Supabase.instance.client;
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) return;

    try {
      setState(() {
        _isUploading = true;
      });

      // Create a unique file name
      final fileName =
          "images/" + DateTime.now().millisecondsSinceEpoch.toString();

      // Upload to the 'images' bucket
      final response = await supabase.storage
          .from('images') // Replace 'images' with your bucket name
          .upload(fileName, _selectedImage!);

      /*if (response.error != null) {
        throw response.error!;
      }*/

      // Get the public URL of the uploaded image
      final publicUrl = supabase.storage.from('images').getPublicUrl(fileName);

      setState(() {
        _imageUrl = publicUrl;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Stream<List<Map<String, dynamic>>> get productStream =>
      Supabase.instance.client
          .from('products')
          .stream(primaryKey: ['id']).eq('business_id', widget.business);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Management'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: productStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No products added yet!',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }
                final products = snapshot.data!;
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Card(
                      color: Colors.green[400],
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        leading: (product['product_image'] != null &&
                                product['product_image'].isNotEmpty)
                            ? Image.network(
                                product['product_image'],
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image, size: 50),
                              )
                            : const Icon(Icons.image, size: 50),
                        title: Text(product['name']),
                        subtitle: Text(
                            'Price: ₹${product['price']}\n${product['description']}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration:
                        const InputDecoration(labelText: 'Product Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the product name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: priceController,
                    decoration:
                        const InputDecoration(labelText: 'Product Price'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the product price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: descriptionController,
                    decoration:
                        const InputDecoration(labelText: 'Product Description'),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the product description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: quantityController,
                    decoration:
                        const InputDecoration(labelText: 'Product Quantity'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the product quantity';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child:
                          const Center(child: Text('Tap to select an image')),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _addProduct,
                    child: const Text('Add Product'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
