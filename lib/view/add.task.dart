import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';
import 'package:delightful_toast/delight_toast.dart';

import '../controller/cubit.dart';
import '../controller/states.dart';
import '../shared/textfield.dart';

class AddTask extends StatelessWidget {
  AddTask({super.key});

  final titleController = TextEditingController();
  final timeController = TextEditingController();
  final dateController = TextEditingController();
  final desController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (BuildContext context, state) {
        if (state is InsertingIntoDBState) {
          Navigator.pop(context);
        }
      },
      builder: (BuildContext context, Object? state) {
        var cubit = TodoCubit.get(context);
        return Scaffold(
          appBar: AppBar(title: Text('Add your task'.tr())),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    customTextFormField(
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please add your title'.tr();
                          }
                          return null;
                        },
                        label: 'Title'.tr(),
                        hintText: 'Add your Title'.tr(),
                        prefixIcon: Icons.title),
                    const SizedBox(
                      height: 10.0,
                    ),
                    customTextFormField(
                        controller: timeController,
                        keyboardType: TextInputType.datetime,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please add your Time';
                          }
                          return null;
                        },
                        label: 'Time',
                        hintText: 'Add your Time',
                        prefixIcon: Icons.watch_later_outlined,
                        onTap: () {
                          showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then((value) {
                            timeController.text = value!.format(context);
                          }).catchError((error) {
                            timeController.clear();
                          });
                        }),
                    const Gap(10),
                    customTextFormField(
                        controller: dateController,
                        keyboardType: TextInputType.datetime,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please add your Date';
                          }
                          return null;
                        },
                        label: 'Date',
                        hintText: 'Add your Date',
                        prefixIcon: Icons.calendar_view_day,
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2040-12-30'))
                              .then((value) {
                            dateController.text =
                                DateFormat.yMMMd().format(value!);
                          }).catchError((error) {
                            dateController.clear();
                          });
                        }),
                    const Gap(10),
                    customTextFormField(
                        controller: desController,
                        lines: 5,
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please add your description';
                          }
                          return null;
                        },
                        label: 'Description',
                        hintText: 'Add your Description',
                        prefixIcon: Icons.note),
                    const Gap(10),
                    MaterialButton(
                      height: 40.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      minWidth: double.infinity,
                      color: Colors.deepOrange,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.insertDB(
                            title: titleController.text,
                            date: dateController.text,
                            time: timeController.text,
                            description: desController.text,
                          );
                          DelightToastBar(
                            builder: (context) => const ToastCard(
                              title: Text(
                                'Your task is successfully add !',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 7,
                                ),
                              ),
                              color: Colors.deepOrange,
                              leading: Icon(Icons.check_circle_rounded),
                            ),
                            animationDuration: Duration(seconds: 1),
                            autoDismiss: true,
                            position: DelightSnackbarPosition.bottom,
                            snackbarDuration: Duration(seconds: 3),
                            animationCurve: Curves.easeInOutBack,
                          ).show(context);
                        }
                      },
                      child: Text(
                        'Add Task'.tr(),
                        style: Theme.of(context).textTheme.bodySmall,
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
  }
}
