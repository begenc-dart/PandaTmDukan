import 'package:flutter/material.dart';

class AddPhoto{
  addPhoto(String add) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 25),
          height: 35,
          width: 190,
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromRGBO(255, 20, 29, 1)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.add,
                color: const Color.fromRGBO(39, 39, 39, 1),
                size: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  add,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}