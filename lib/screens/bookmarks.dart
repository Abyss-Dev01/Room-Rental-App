import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_rental_app/services/manageData.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [BookmarksData(context, 'myBookmarks')],
          ),
        ),
      ),
    );
  }

  Widget BookmarksData(BuildContext context, String collection) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height - 100,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(
          future: Provider.of<ManageData>(
            context,
            listen: false,
          ).fetchData(collection),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.lightBlue),
                ),
              );
            }
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Container(
                      height: 400.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.red[50],
                              blurRadius: 5,
                              spreadRadius: 3),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  height: 180.0,
                                  width: 300.0,
                                  child: Image.network(
                                    snapshot.data[index].data()['thumbnailUrl'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                  left: 235.0,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.bookmark,
                                      color: Colors.green[700],
                                      size: 42,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Username: ${snapshot.data[index].data()['username']}",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Address: ${snapshot.data[index].data()['address']}",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Phone: ${snapshot.data[index].data()['phone']}",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Price: ${snapshot.data[index].data()['price']}",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
