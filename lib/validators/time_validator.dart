import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/util/folly_utils.dart';
import 'package:folly_fields/validators/abstract_validator.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';

///
///
///
class TimeValidator extends AbstractValidator<TimeOfDay>
    implements AbstractParser<TimeOfDay> {
  ///
  ///
  ///
  TimeValidator()
      : super(
          <TextInputFormatter>[
            MaskTextInputFormatter(
              mask: 'AB:CB',
              filter: <String, RegExp>{
                'A': RegExp(r'[0-2]'),
                'B': RegExp(r'[0-9]'),
                'C': RegExp(r'[0-5]'),
              },
            ),
          ],
        );

  ///
  ///
  ///
  @override
  String format(TimeOfDay time) => time == null
      ? ''
      : time.hour.toString().padLeft(2, '0') +
          ':' +
          time.minute.toString().padLeft(2, '0');

  ///
  ///
  ///
  @override
  String strip(String value) => value;

  ///
  ///
  ///
  @override
  bool isValid(String value) => valid(value) == null;

  ///
  ///
  ///
  @override
  TextInputType get keyboard => TextInputType.datetime;

  ///
  ///
  ///
  @override
  TimeOfDay parse(String value) {
    if (isValid(value)) {
      List<String> parts = value.split(':');
      return TimeOfDay(
        hour: int.tryParse(parts[0]),
        minute: int.tryParse(parts[1]),
      );
    }
    return null;
  }

  ///
  ///
  ///
  @override
  String valid(String value) => FollyUtils.validTime(value);

  ///
  ///
  ///
  String formatDateTime(DateTime dateTime) =>
      format(TimeOfDay.fromDateTime(dateTime));
}
