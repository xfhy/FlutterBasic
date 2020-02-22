import 'package:date_format/date_format.dart';

void main() {
  //02月22日07:46
  print(formatDate(DateTime.now(), [mm, '月', dd, '日', hh, ':', n]));
  print(formatDate(DateTime.now(), [m, '月第', w, '周']));
}
