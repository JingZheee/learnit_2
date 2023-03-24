import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:learnit_2/tools/resource_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../tools/SizeConfig.dart';

class Notes extends StatefulWidget {
   Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {

  final CollectionReference _notes = FirebaseFirestore.instance.collection('/maths/category/notes');
  final CollectionReference _pyq = FirebaseFirestore.instance.collection('/maths/category/pyq');
  final CollectionReference _videos = FirebaseFirestore.instance.collection('/maths/category/videos');
  bool click = false;
  String selectedButton = 'Notes';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
        padding:  EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal! * 10),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.safeBlockVertical! * 1),
              Text(
                'Resources',
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal! * 7.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: SizeConfig.safeBlockVertical! * 3),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF4F3FD),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none
                  ),
                  hintText: "Thermochemistry",
                  prefixIcon: Icon(Icons.search)
                
                ),
              ),
              SizedBox(height: SizeConfig.safeBlockVertical! * 2.5),
              Container(
                height: SizeConfig.safeBlockVertical! * 3.5,
                      child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              SizedBox(width: SizeConfig.safeBlockHorizontal! * 2.5),
                              OutlinedButton(
                                  onPressed: (){
                                    setState(() {
                                      click = true;
                                      selectedButton = "Notes";
                                    });
                                  }, 
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: (selectedButton == 'Notes') ? Color(0XFFCDCDDF) : Color(0XFFE9E9F1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                    )
                                  ),
                                  child: const Text(
                                    'Notes',
                                    style:  TextStyle(
                                      color: Colors.black
                                    ),
                                  )
                                ),
                              SizedBox(width: SizeConfig.safeBlockHorizontal! * 3.5),
                              OutlinedButton(
                                onPressed: (){
                                  setState(() {
                                      click = true;
                                      selectedButton = "Past Year Questions";
                                    });
                                }, 
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: (selectedButton == 'Past Year Questions') ? Color(0XFFCDCDDF) : Color(0XFFE9E9F1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  )
                                ),
                                child: const Text(
                                  'Past Year Questions', 
                                   style: TextStyle(
                                    color: Colors.black
                                   ), 
                                )
                              ),
                              SizedBox(width: SizeConfig.safeBlockHorizontal! * 3.5),
                              OutlinedButton(
                                onPressed: (){
                                  setState(() {
                                      click = true;
                                      selectedButton = "Videos";
                                    });
                                }, 
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: (selectedButton == 'Videos') ? Color(0XFFCDCDDF) : Color(0XFFE9E9F1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                    )
                                  ),
                                child: const Text(
                                  'Videos',
                                  style: TextStyle(
                                    color: Colors.black
                                  ),
                                )
                              ),
                            ],
                          ),
                    
              ),
              SizedBox(height: SizeConfig.safeBlockVertical! * 2.5),

            
              
              StreamBuilder(
                stream: (selectedButton == 'Notes') ? _notes.snapshots() : (selectedButton == 'Past Year Questions') ? _pyq.snapshots() : _videos.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
                  if(streamSnapshot.hasData){
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index){
                        final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                        return ResourcesCard(title: documentSnapshot['title'], tutor: documentSnapshot['tutor'], likes: documentSnapshot['likes'], downloads: documentSnapshot['download']);
                          
                      }
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ],
          )
        ),
      ),
    );
  }
}
