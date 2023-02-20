import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class DateOfBirth extends StatefulWidget {
  
  // When clicking on day or month or year
  final Function(DateTime datetime)? onDateTimeChanged;

  // Day box Size
  final Size? daySize;

  // Month box Size
  final Size? monthSize;

  // Year box Size
  final Size? yearSize;

  // Color of all box background
  final Color? backgroundColor;

  // Color of the Dropdownmenu 
  final Color? backgroundDropdownColor;

  // Radius of all the boxes
  final double? radius;

  // Color of border for all boxes
  final Color? borderColor;

  // Size of the chosen item
  final double? textsSize;

  // Color of the chosen item
  final Color? itemColor;

  // Color of items inside Dropdownmenu
  final Color? itemsColor;

  // where to start counting the year
  final int? startingYear;

  const DateOfBirth(
      {super.key,
      this.daySize,
      this.monthSize,
      this.yearSize,
      this.backgroundColor,
      this.radius,
      this.borderColor,
      this.textsSize,
      this.itemColor,
      this.itemsColor,
      this.backgroundDropdownColor,
      this.startingYear,
    required  this.onDateTimeChanged});

  @override
  State<DateOfBirth> createState() => _DateOfBirthState();
}

class _DateOfBirthState extends State<DateOfBirth> {
  
   //List<String> days = DateFormat.EEEE(Platform.localeName).dateSymbols.DATEFORMATS;
   List<String> months = DateFormat.EEEE(Platform.localeName).dateSymbols.MONTHS;

  int _currentyear = 0;
  int _currentmonth = 0;
 
  DateTime _selectedDate = DateTime.utc(2000,1,1);
  final DateTime _currentDate = DateTime.now();
  late List<int> listyears ;
      
@override
  void initState() {
    listyears =  Iterable<int>.generate((DateTime.now().year + 1))
      .skip(widget.startingYear ?? 1940)
      .toList()
      .reversed
      .toList();
   
    super.initState();
  }

    int daysInMonth(int year,int month) {
     
      return DateTime(year == 0 ? _currentDate.year: year, month == 0 ? _currentDate.month+1: month+1, 0).day;
    } 
  
    

  changeSelectedDate(DateTime datetime) {
    _selectedDate = datetime;
    setState(() { });

  }

  changecurrentYear(int value) {
    _currentyear = value;
setState(() { });
  }

  changecurrentMonth(int value) {
    _currentmonth = value;
 setState(() { });
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: widget.daySize?.width,
                            height:widget.daySize?.height ??  width * 0.1,
                            decoration: BoxDecoration(
                              color: widget.backgroundColor ?? Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(widget.radius ?? 5),
                              border: Border.all(color:widget.borderColor ??  Colors.transparent),
                            ),
                            child: Center(
                              child: _buildDays(
                                daysinmonth: daysInMonth(
                                  _currentyear, _currentmonth),
                              onChanged: (newvalue) {
                                changeSelectedDate(DateTime(
                                    _selectedDate.year,
                                    _selectedDate.month,
                                    newvalue!));
                                 
                                    widget.onDateTimeChanged!(_selectedDate) ;
                              },
                              selectedDate: _selectedDate.day,
                              width: width,
                              ),
                            ),
                          ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Container(
                            width: widget.monthSize?.width,
                            height:widget.monthSize?.height ??  width * 0.1,
                            decoration: BoxDecoration(
                              color: widget.backgroundColor ?? Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(widget.radius ?? 5),
                              border: Border.all(color: widget.borderColor ??  Colors.transparent),
                            ),
                            child: Center(
                              child: _buildMonths(
                                width: width,
                                listMonths: months,
                                onChanged: (newvalue) {
                                  changecurrentMonth(newvalue!);
                                  changeSelectedDate(DateTime(
                                      _selectedDate.year,
                                      newvalue,
                                      _selectedDate.day));
                                      widget.onDateTimeChanged!(_selectedDate);
                                },
                                selectedDate: _selectedDate.month,
                              ),
                            ),
                          ),          
                       
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Container(
                            width:widget.yearSize?.width ,
                            height:widget.yearSize?.height ?? width * 0.1,
                            decoration: BoxDecoration(
                              color: widget.backgroundColor ?? Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(widget.radius ?? 5),
                              border: Border.all(color: widget.borderColor ??  Colors.transparent),
                            ),
                            child: Center(
                                child: _buildYears(
                                  
                               list: listyears,
                                selectedDate: _selectedDate.year,
                                onChanged: (newvalue) {
                                  changecurrentYear(newvalue!);
                                  changeSelectedDate(DateTime(
                                      newvalue,
                                      _selectedDate.month,
                                      _selectedDate.day));
                                      widget.onDateTimeChanged!(_selectedDate);
                                },
                                width: width,
                            )),
                          ),
                      
                      
                      ],
                    );
  }


  _buildYears({required double width, required int selectedDate,required Function(int?) onChanged,required List<int> list}){
    return DropdownButton<int>(
        dropdownColor: widget.backgroundDropdownColor,
        alignment: Alignment.center,
        icon:const Text(''),
        elevation: 0,
        underline: const Text(''),
        key:const Key("2"),
        items: list.map((item) {
          return DropdownMenuItem<int>(
            value: item,
            child: Center(
              child: Text(
                item.toString(),
                style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(
                      fontSize:widget.textsSize ??  0.045 * width,
                      color: widget.itemsColor ??  Colors.black,
                    ),
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        value: selectedDate,
        selectedItemBuilder: (context) => list.map((item) {
              return Center(
                child: Text(
                  item.toString(),
                  style:
                      Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(
                            fontSize: widget.textsSize ??  0.045 * width,
                            color: widget.itemColor ??Colors.white,
                          ),
                ),
              );
            }).toList());
  }

  _buildMonths({required double width, required int selectedDate,required Function(int?) onChanged,required List<String> listMonths}){
      return DropdownButton(
        dropdownColor: widget.backgroundDropdownColor,
      alignment: Alignment.center,
      icon:const Text(''),
      elevation: 0,
      underline:const Text(''),
      key:const Key("0"),
      items: List.generate(
          listMonths.length,
          (index) => DropdownMenuItem(
                value: index,
                child: Center(
                  child: Text(
                    listMonths[index],
                    style:
                        Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(
                              fontSize: widget.textsSize ??  0.035 * width,
                              color: widget.itemsColor ??  Colors.black,
                            ),
                  ),
                ),
                onTap: () {},
              )),
      onChanged: onChanged,
      value: selectedDate,
      selectedItemBuilder: (context) => List.generate(
          listMonths.length,
          (index) => Center(
                child: Text(
                  listMonths[index],
                  style:
                      Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(
                            fontSize: widget.textsSize ??  0.035 * width,
                            color: widget.itemColor ??Colors.white,
                          ),
                ),
              )),
    );
  }


 _buildDays({required double width, required int selectedDate,required Function(int?) onChanged,required int daysinmonth}){

    return DropdownButton<int>(
      dropdownColor: widget.backgroundDropdownColor,
      alignment: Alignment.center,
      icon:const Text(''),
      elevation: 0,
      underline:const Text(''),
      key:const Key("0"),
      items: List.generate(daysinmonth, (index) => index + 1)
          .map(
            (value) => DropdownMenuItem<int>(
              onTap: () {
            
              },
              value: value,
              child: Center(
                  child: Text(
                value.toString(),
                style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(
                      fontSize: widget.textsSize ??  0.045 * width,
                      color: widget.itemsColor ??  Colors.black,
                    ),
              )),
            ),
          )
          .toList(),
      onChanged: onChanged,
      value: selectedDate,
      selectedItemBuilder: (context) =>
          List.generate(daysinmonth, (index) => index + 1)
              .map(
                (value) => Center(
                    child: Text(
                  value.toString(),
                  style:
                      Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(
                            fontSize: widget.textsSize ??  0.045 * width,
                            color: widget.itemColor ??Colors.white,
                          ),
                )),
              )
              .toList(),
    );
  }

}

