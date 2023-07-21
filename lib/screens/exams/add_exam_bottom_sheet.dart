import 'package:flutter/material.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/date_utils.dart';
import 'package:omar_mostafa/helpers/dialogs.dart';
import 'package:omar_mostafa/main.dart';
import 'package:omar_mostafa/models/exam.dart';

class AddExamBottomSheet extends StatefulWidget {
  int level;

  AddExamBottomSheet(this.level);

  @override
  State<AddExamBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddExamBottomSheet> {
  var notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'أضف امتحاناً',
            style: TextStyle(fontFamily: 'MyArabicFont'),
            textAlign: TextAlign.center,
          ),
          TextFormField(
            controller: notesController,
            decoration: InputDecoration(
                labelText: 'ملاحظات',
                labelStyle: TextStyle(fontFamily: 'MyArabicFont')),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'اختر تاريخا',
            style: TextStyle(fontFamily: 'MyArabicFont'),
          ),
          InkWell(
            onTap: () {
              showDateDialoge();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                addExam();
              },
              child: Text(
                'أضف',
                style: TextStyle(fontFamily: 'MyArabicFont'),
              ))
        ],
      ),
    );
  }

  DateTime selectedDate = DateTime.now();

  void showDateDialoge() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365 * 10 + 3)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: myTheme,
          child: child ?? SizedBox.shrink(),
        );
      },
    );
    if (date != null) {
      selectedDate = date;
      setState(() {});
      print(selectedDate.toString());
    }
  }

  void addExam() {
    String notes = notesController.text;
    Exam exam = Exam(
        notes: notes, dateTime: dateOnly(selectedDate), level: widget.level);
    showLoading(context, 'جارٍ التحميل..', isCancelable: false);
    APIs.insertExam(exam).then((value) {
      showMessage(context, 'تم إدراج الامتحان بنجاح', posActionName: 'موافق',
          posAction: () {
        Navigator.pop(context);
      });
    }).onError((error, stackTrace) {
      showMessage(context, 'حدث خطأ ما، حاول لاحقا.', posActionName: 'موافق',
          posAction: () {
        Navigator.pop(context);
      });
    }).timeout(Duration(seconds: 5), onTimeout: () {
      showMessage(context, 'تم إدراج الامتحان', posActionName: 'موافق',
          posAction: () {
        Navigator.pop(context);
      });
    });
  }
}
