import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldAddProduct{
  addText(int text, String info, bool check, bool checkNum,List maglummat,String initVal,bool editCon,bool maxlines,String infonext,checkvalue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin:
          const EdgeInsets.only(top: 15, bottom: 10, right: 20, left: 20),
          child: Row(
            children: [
              Text(
                info,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ), Text(
          infonext,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),


            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            maxLength: maxlines==true?2:null,
            initialValue:editCon==true? initVal:"",
            keyboardType:
            checkNum == true ? TextInputType.text : TextInputType.number,
            minLines: 1,
            maxLines: check == true ? 1 : null,
            decoration: const InputDecoration(
              contentPadding: const EdgeInsets.all(12),
            ),
            onSaved: (result) {

              maglummat[text][0] = result!;
            },
            validator: (value){
            if(checkvalue==true){  if(value!.length==0){
                return "Maglumat girizmeginizi hayys edyaris";
              }
              else{
                return null;
              }
            }
            else{
              return null;
            }
            },
          ),
        ),
      ],
    );
  }
}