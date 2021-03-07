import 'package:flutter/material.dart';
import 'package:flutter_furniture_3/Custom_Icons.dart';
import 'package:flutter_furniture_3/PageIndicator.dart';
import 'package:flutter_furniture_3/data.dart';

class ProductDetail extends StatefulWidget {
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  AnimationController _controller;
  Animation<double> _titleAnim;
  Animation<double> _tagAnim;
  Animation<double> _priceAnim;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _titleAnim = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.3),
      ),
    );
    _tagAnim = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 0.5),
      ),
    );
    _priceAnim = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 0.8),
      ),
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();
    super.initState();
  }

  void _nextImage() {
    setState(() {
      if (currentIndex < productImage.length - 1) {
        currentIndex++;
        _controller.reset();
        _controller.forward();
      } else {
        currentIndex = currentIndex;
      }
    });
  }

  void _prevImage() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
        _controller.reset();
        _controller.forward();
      } else {
        currentIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60.0),
                ),
                child: SizedBox(
                  height: 500.0,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        productImage[currentIndex],
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 40.0,
                        left: 24.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            size: 30.0,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Positioned(
                        top: 150.0,
                        left: 35.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Transform.translate(
                              offset: Offset(0.0, 30 * (1 - _titleAnim.value)),
                              child: Opacity(
                                opacity: _titleAnim.value,
                                child: Text(
                                  productTile[currentIndex],
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    fontFamily: "Montserrat-Bold",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Transform.translate(
                              offset: Offset(0.0, 20 * (1 - _tagAnim.value)),
                              child: Opacity(
                                opacity: _tagAnim.value,
                                child: Text(
                                  "New Sell",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            Opacity(
                              opacity: _priceAnim.value,
                              child: Text(
                                price[currentIndex] + " \$",
                                style: TextStyle(
                                  fontSize: 35.0,
                                  fontFamily: "Montserrat-Bold",
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            SizedBox(
                              height: 70.0,
                              child: PageIndicator(
                                  currentIndex, productImage.length),
                            ),
                          ],
                        ),
                      ),
                      Positioned.fill(child: GestureDetector(
                        onHorizontalDragEnd: (DragEndDetails details) {
                          if (details.velocity.pixelsPerSecond.dx > 0) {
                            _prevImage();
                          } else if (details.velocity.pixelsPerSecond.dx < 0) {
                            _nextImage();
                          }
                        },
                      )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 25.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Wooden ArmChairs",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: "Montserrat-Bold",
                      ),
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, send "
                      "do eiusmod tempor incididunt ut labore et dolore magna",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            right: 0.0,
            bottom: 0.0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
              ),
              child: SizedBox(
                width: 160.0,
                height: 60.0,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Color(0xFFfa7b58),
                        child: Center(
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Color(0xFF2a2d3f),
                        child: Center(
                          child: Icon(
                            Icons.shopping_basket,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
