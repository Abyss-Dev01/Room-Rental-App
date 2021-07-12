import 'package:flutter/material.dart';
import 'package:room_rental_app/components/customText.dart';
import 'package:room_rental_app/components/rooms.dart';

List<Room> roomList = [
  Room(
      location: "Balika-mod, Dharan-16",
      price: 4000,
      bookmarked: true,
      image: 'room1.jpg'),
  Room(
      location: "Zero-Point, Dahran-12",
      price: 3000,
      bookmarked: true,
      image: 'room2.jpg'),
  Room(
      location: "Dharan-16", price: 4500, bookmarked: true, image: 'room3.jpg'),
  Room(
      location: "Dharan-16", price: 2000, bookmarked: true, image: 'room4.jpg'),
  Room(
      location: "Dharan-16", price: 3500, bookmarked: true, image: 'room5.jpg'),
  Room(location: "Dharan-16", price: 2000, bookmarked: true, image: 'room6.jpg')
];

class RoomList extends StatefulWidget {
  @override
  _RoomListState createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.red[50],
        height: 600,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: roomList.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                height: 400,
                width: 280,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(1, 1),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      "assets/images/${roomList[index].image}",
                      height: 250,
                      width: 300,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(1, 1),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: roomList[index].bookmarked
                                  ? Icon(
                                      Icons.bookmark,
                                      size: 20,
                                      color: Colors.green[300],
                                    )
                                  : Icon(
                                      Icons.bookmark_border,
                                      size: 20,
                                      color: Colors.green[300],
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.location_on),
                          CustomText(text: "Location :-"),
                          SizedBox(
                            width: 10,
                          ),
                          CustomText(
                            text: roomList[index].location,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.monetization_on),
                          CustomText(text: "Price :-"),
                          SizedBox(
                            width: 10,
                          ),
                          CustomText(
                            text: "\Rs.${roomList[index].price}",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
