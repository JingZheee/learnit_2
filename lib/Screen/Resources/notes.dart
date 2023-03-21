import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:learnit_2/tools/resource_card.dart';

import '../../tools/SizeConfig.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
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
              const ResourcesCard(
                title: "SPM A++ Chemistry Notes",
                tutor: "Cikgu Zemin",
                likes: 200,
                downloads: 200
              ),
            ],
          )
        ),
      ),
    );
  }
}