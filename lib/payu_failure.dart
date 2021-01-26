import 'package:flutter/cupertino.dart';

class PayuFailure {
  Map payuResponse;
  Map merchantResponse;

  PayuFailure({@required this.payuResponse, @required this.merchantResponse});
}
