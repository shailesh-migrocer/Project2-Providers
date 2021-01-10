import 'package:providers/WishItem.dart';
import 'package:flutter/material.dart';
import 'Item.dart';
import 'ItemAddNotifier.dart';
import 'HomeScreen.dart';

List<WishItem> itemList2 = [];
int index = 0;

class itemDetails extends StatefulWidget {
  Item item;

  itemDetails(this.item);

  @override
  _itemDetailsState createState() => _itemDetailsState();
}

class _itemDetailsState extends State<itemDetails> {
  WishItem wishItem;
  String newTitle;
  String newDesciption;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Item details")),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Text("Title"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              "${widget.item.title}",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Text("Discription"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              "${widget.item.discription}",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                  color: Colors.blue.withOpacity(0.6),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: const Text('Enter title and discription'),
                              content: new Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      decoration:
                                          InputDecoration(hintText: 'Title'),
                                      onChanged: (value) {
                                        setState(() {
                                          widget.item.title = value.trim();
                                        });
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Discription'),
                                      onChanged: (value) {
                                        setState(() {
                                          widget.item.discription =
                                              value.trim();
                                        });
                                      },
                                    ),
                                  ),
                                  // Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceAround,
                                  //     children: [
                                  //       RaisedButton(
                                  //         color: Theme.of(context).accentColor,
                                  //         child: Text('Yes'),
                                  //         onPressed: () {
                                  //           setState(() {
                                  //             widget.item.title = newTitle;
                                  //           widget.item.discription =
                                  //               newDesciption;
                                  //           });

                                  //         },
                                  //       ),
                                  //       RaisedButton(
                                  //         color: Theme.of(context).accentColor,
                                  //         child: Text('No'),
                                  //         onPressed: () {

                                  //         },
                                  //       )
                                  //     ])
                                ],
                              ),
                              actions: <Widget>[
                                new FlatButton(
                                  onPressed: ()  {
                                    // setState(() {
                                    //   Navigator.of(context).pop(widget.item.title);
                                    // Navigator.of(context).pop(widget.item.discription);
                                    // });
                                    // Navigator.pop(context);
                                    // Navigator.of(context).pop();
                                    // Future.delayed(Duration(seconds: 5), () {
                                      Navigator.of(context, rootNavigator: true).pop();
                                    // });
                                  },
                                  textColor: Theme.of(context).primaryColor,
                                  child: const Text('Close'),
                                ),
                              ],
                            ));

                     Navigator.pop(context);
                  },
                  child: Text("Edit")),
              FlatButton(
                color: Colors.blue.withOpacity(0.6),
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () async {
                  // Scaffold.of(context)
                  //     .showSnackBar(SnackBar(content: Text('Processing Data')));
                  itemList.remove(widget.item);
                  itemList2.add(
                      WishItem(widget.item.title, widget.item.discription));
                  // print("${itemList2[index].title}");
                  // print("$index");
                  // print("${itemList2.length}");
                  index++;
                  Navigator.pop(context);
                },
                child: Text("FULLFILL"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
