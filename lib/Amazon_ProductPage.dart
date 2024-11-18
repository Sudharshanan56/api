import 'dart:convert';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:like_button/like_button.dart';
import 'package:http/http.dart' as http;
class Productpage extends StatefulWidget {
  const Productpage({super.key});

  @override
  State<Productpage> createState() => _ProductpageState();
}

class _ProductpageState extends State<Productpage> {
  String dropdownvalue = 'Item 1';
  var items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
  // List img=[
  //   "Assets/s1.jpg",
  //   "Assets/s2.jpg",
  //   "Assets/s3.jpg",
  //   "Assets/s4.jpg",
  //   "Assets/s5.jpg",
  // ];
var a={};
  Future<void> getData() async
  {
    final apiResponse=await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if(apiResponse.statusCode==200||apiResponse.statusCode==201)
    {
      setState(() {
        a=json.decode(apiResponse.body);
        print(a);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    String dropdownValue;
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 80,
        leading: Icon(Icons.arrow_back,size: 30,),
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(35),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search_sharp),
                      hintText: "Watches",
                      hintStyle: TextStyle(fontSize: 20),
                      fillColor: Colors.black,
                      suffixIcon: Icon(Icons.document_scanner),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.qr_code_scanner,size: 30,),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  // child: Container(
                  //   height: 50,
                  //   width: 50,
                  //   decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //           image: AssetImage("Assets/sylvi.jpg")
                  //       )
                  //   ),
                  // ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text("Sylvi",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                      Text("\t Visit the store",style: TextStyle(fontSize: 20,color: Colors.blue),),

                    ],
                  ),

                ),
                AnimatedRatingStars(
                  initialRating: 3.5,
                  minRating: 0.0,
                  maxRating: 5.0,
                  filledColor: Colors.amber,
                  emptyColor: Colors.grey,
                  filledIcon: Icons.star,
                  halfFilledIcon: Icons.star_half,
                  emptyIcon: Icons.star_border,
                  onChanged: (double rating) {
                    // Handle the rating change here
                    print('Rating: $rating');
                  },
                  displayRatingValue: true,
                  interactiveTooltips: true,
                  customFilledIcon: Icons.star,
                  customHalfFilledIcon: Icons.star_half,
                  customEmptyIcon: Icons.star_border,
                  starSize: 30.0,
                  animationDuration: Duration(milliseconds: 300),
                  animationCurve: Curves.easeInOut,
                  readOnly: false,
                ),
              ],
            ),
            Row(
              children: [
                Text("Sylvi iconic Leather Strap Watches for men with analog \n Digital DisplayAlarm Stopwatch water Resistant watch "),
              ],
            ),

            Stack(
                children: [
                  Container(
                    height: 400,
                    width: 400,
                    child: CarouselSlider.builder(itemCount:5 ,
                      options: CarouselOptions(
                        height: 380.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        scrollDirection: Axis.horizontal,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 1,


                      ),
                      itemBuilder: (BuildContext context, int index, int realIndex)
                      {
                        return Container(
                          height: 398,
                          width: 398,
                          decoration: BoxDecoration(

                          ),
                          child:Image.network(a['image']),
                        );
                      },
                    ),
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //     //image: AssetImage("Assets/s1.jpg"),fit: BoxFit.fill,
                    //   )
                    // ),

                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 350,top:10),
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(90),
                          color: Colors.white70,
                        ),
                        child: Icon(Icons.share)),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 402),
                      child: DotsIndicator(dotsCount: 5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 400,
                        left: 300
                    ),
                    child: LikeButton(),
                  ),

                ]
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.currency_rupee),
                      Text("28,000",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)

                    ],
                  ),
                  Row(
                    children: [

                      Text("EMI",style: TextStyle(fontWeight: FontWeight.bold),),
                      Text("from "),
                      Icon(Icons.currency_rupee),
                      Text("1,357.No Cost EMI available."),
                      Text("EMI options",style: TextStyle(color: Colors.blue),),

                    ],
                  ),
                  Row(
                    children: [
                      Text("Inclusive of all taxes"),
                    ],
                  ),

                ],
              ),

            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all()
              ),
              child: Row(
                children: [
                  // Container(
                  //   height: 50,
                  //   width: 50,
                  //
                  //   decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //         image: AssetImage("Assets/offer.png"),
                  //       )
                  //   ),
                  // ),
                  Text("All offers & discounts"),
                  Padding(
                    padding: const EdgeInsets.only(left: 170),
                    child: Icon(Icons.keyboard_arrow_right),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 4),
                  child: RichText(text: TextSpan(
                      children: [
                        TextSpan(text: "FREE delivery ",style: TextStyle(color: Colors.blue)),
                        TextSpan(text: "Thursday, 26 September. ",style: TextStyle(fontWeight: FontWeight.bold,)),
                        TextSpan(text: "Order\n within "),
                        TextSpan(text: "23 hrs 17 mins. ",style: TextStyle(color: Colors.green)),
                        TextSpan(text: "Details",style: TextStyle(color: Colors.blue))
                      ]
                  )),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.location_on_outlined),
                Text("Delivering to Madurai 625016- Update location",style: TextStyle(color: Colors.blue),)
              ],
            ),
            Row(
              children: [
                Text("Only 1 left in stock",style: TextStyle(color: Colors.brown),),
              ],
            ),
            Container(
              height: 50,
              width: 350,
              decoration: BoxDecoration(
                border:Border.all(),
              ),

              child:  Center(

                child: DropdownButton(
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
            ),



            // DropdownButton(
            //   value: dropdownvalue,
            //   icon: const Icon(Icons.keyboard_arrow_down),
            //   items: items.map((String item) {
            //     return DropdownMenuItem(
            //       value: item,
            //       child: Text(item),
            //     );
            //   }).toList(),
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       dropdownvalue = newValue!;
            //     });
            //   },
            // ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 50,
                  width: 370,

                  decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(35)
                  ),
                  child: ElevatedButton(onPressed: (){},
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.yellowAccent),
                    ),
                    child: Text("Add to Cart",style: TextStyle( fontSize: 20),),
                  )
              ),
            ),
            SizedBox(height: 10,),
            Container(
                height: 50,
                width: 370,

                decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(35)
                ),
                child: ElevatedButton(onPressed: (){},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange
                  ),
                  child: Text("Buy Now",style: TextStyle( fontSize: 20),),
                )
            ),


          ],

        ),
      ),
    );
  }
}
