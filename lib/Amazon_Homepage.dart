// import 'package:api/category.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'amazon.dart';

class Amazonhomepage extends StatefulWidget {
  @override
  State<Amazonhomepage> createState() => _AmazonhomepageState();
}

class _AmazonhomepageState extends State<Amazonhomepage> {
  List<String> categories = [];
  String? dropdownvalue;
  List<dynamic> a = [];
  bool isLoading = true;

  // Fetch products based on category
  Future<void> getData(String category) async {
    final response = await http.get(Uri.parse("https://fakestoreapi.com/products/category/$category"));

    if (response.statusCode == 200) {
      setState(() {
        a = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = true;
        throw Exception("Failed to load products");
      });
    }
  }

  // Fetch available categories
  Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));

    if (response.statusCode == 200) {
      List<String> categories = List<String>.from(jsonDecode(response.body));
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Fetch all products
  Future<void> getdata() async {
    final response = await http.get(Uri.parse("https://fakestoreapi.com/products"));

    if (response.statusCode == 200) {
      setState(() {
        a = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = true;
        throw Exception("No data");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getdata();  // Fetch all products initially
    fetchCategories().then((data) {
      setState(() {
        categories = data;
        if (categories.isNotEmpty) {
          dropdownvalue = categories.first; // Set first category as default
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.blue.shade200,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            height: 50,
            width: 380,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, size: 40),
                hintText: "Search Amazon.in",
                hintStyle: TextStyle(fontSize: 20, color: Colors.black54),
                suffixIcon: Icon(Icons.qr_code_scanner),
              ),
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : SingleChildScrollView(
        child: Column(
          children: [
            // Location and delivery city with pincode
            Row(
              children: [
                SizedBox(height: 10),
                Container(
                  height: 60,
                  width: 412,
                  color: Colors.blue.shade100,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: Icon(Icons.location_on_outlined, size: 30),
                          title: Text("Delivering to Madurai 625016"),
                          trailing: DropdownButton<String>(
                            value: dropdownvalue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: categories.map((String category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: GestureDetector(
                                  onTap: () {
                                    // Fetch the data for the selected category
                                    getData(category).then((_) {
                                      // Navigate to the category page and pass the filtered products
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CategoryPage(
                                            category: category,
                                            products: a, // Pass the filtered products
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                  child: Text(category),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Horizontal product list (ListView)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: 120,
                width: 412,
                color: Colors.white,

                child: ListView.builder(
                    itemCount: a.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context,int index){
                      var user=a[index];
                      return a.isEmpty?CircularProgressIndicator():GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>   amazon(oneProduct: a[index],),
                              // x(index);

                            ),
                          );

                        },
                        child:  Container(
                          height: 100,
                          width: 100,

                          child:  Image.network(a[index]["image"]),


                        ),


                      );

                    }
                ),
              ),
            ),

            // Carousel Slider
            Container(
              height: 200,
              width: 412,
              child: CarouselSlider.builder(
                itemCount: a.length,
                options: CarouselOptions(
                  height: 180.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  scrollDirection: Axis.horizontal,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 1,


                ),
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return a.isEmpty?CircularProgressIndicator():GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>amazon(oneProduct: a[index])));
                    },

                    child:  Image.network(a[index]["image"]),
                  );





                },
              ),
            ),

            // GridView for products
            Container(
              height: 600,
              child: GridView.builder(
                itemCount:a.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context,int index)
                {
                  return a.isEmpty?CircularProgressIndicator():


                  Column(
                      children: [
                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child:  GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>amazon(oneProduct: a[index])));
                              },
                              child: Image.network(a[index]["image"])),
                        ),
                      ]
                  );
                },
              ),

            )
          ],
        ),
      ),
    );
  }
}

// Define the CategoryPage to display the filtered products for a category
class CategoryPage extends StatelessWidget {
  final String category;
  final List<dynamic> products;

  CategoryPage({required this.category, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$category Products")),
      body: GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          var product = products[index];
          return Column(
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => amazon(oneProduct: product)));
                  },
                  child: Image.network(product["image"]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}