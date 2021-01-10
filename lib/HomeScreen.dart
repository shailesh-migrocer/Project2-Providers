import 'package:flutter/material.dart';
import 'item.dart';
import 'AddItemScreen.dart';
import 'ItemAddNotifier.dart';
import 'package:provider/provider.dart';
import 'ItemDetails.dart';

class HomeScreen extends StatefulWidget {
  //  Item item;
  //HomeScreen(this.item);
  HomeScreen() : super();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> templist=[];
  _HomeScreenState() {
    // setState(() {
      // templist=(List<Item>())itemList;
    //  filterList(itemList.cast<Item>());
          // });
          // callfilter();
                    templist=itemList.cast<Item>();
                    print("length in constructor${templist.length}");
                    print("length in constructor of itemList${itemList.length}");
                  }
                  
                  @override
                  Widget build(BuildContext context) {
                    return Scaffold(
                      body: Container(
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Consumer<ItemAddNotifier>(
                                builder: (context, itemAddNotifier, _) {
                                  return ListView.builder(
                                      itemCount: templist.length,
                                      itemBuilder: (context, index) {
                                        //  if(!templist[index].status){
                                          return GestureDetector(
                                          onTap: () async {
                                            print("on Fullfill tap");
                                            print("length before:${templist.length}");
                                            Scaffold.of(context).showSnackBar(
                                                SnackBar(content: Text('Processing Data')));
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    itemDetails(itemList[index]),
                                              ),
                                            );
                                            
                                            // print("${itemAddNotifier.itemList[index].title}");
                                            // print("${itemAddNotifier.itemList[index].discription}");
                                            setState(() {
                                                templist = itemList.cast<Item>();
                                              //  filterList(itemList.cast<Item>());
                                              // callfilter();

                                            });
                                            print("length after:${templist.length}");
                                          },
                                          child: Card(
                                            child: Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Text(
                                                itemList[index].title,
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                        //  }
                                        // else{
                                          //  return SizedBox(height:1);
                                        // }
                                        
                                      });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      floatingActionButton: new FloatingActionButton(
                        elevation: 0.0,
                        child: new Icon(Icons.add),
                        backgroundColor: Colors.red,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) {
                                return AddItemsScreen(true);
                              },
                            ),
                          );
                        // filterList(templist);
                        },
          
                      ),
                      // )
                    );
                  }
                
            //       Future<void> filterList(List<Item> list) {
            //         List<Item> t=[];
            //         list.forEach((element) {
            //           if(element.status==false) {
            //             // setState((){
            //               t.add(element);
            //             // });
                        
            //           }
            //         });
            //         setState((){
            //           templist=t;
            //         });
            //       }
          
            // void callfilter() async {
            //   await filterList(itemList.cast<Item>());
            // }
}
