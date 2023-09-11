import '../../utils/utils.dart';
import '../services/api_exception.dart';

class ErrorController {
  void handleApiError(error) {

    switch (error) {
      case BadRequestException:
        Utils.hidePopup();
        Utils.showSnackBar("Error: ${error.errorName}",err: true);
        break;
      case ApiNotRespondingException:
        Utils.hidePopup();
        Utils.showSnackBar("Error: ${error.errorName}",err: true);
        break;
    // show error dialog
      case ProcessDataException:
        Utils.hidePopup();
        Utils.showSnackBar("Error: ${error.errorName}",err: true);
        break;
    // show error dialog
      default:
        Utils.hidePopup();
        Utils.showSnackBar("Error: ${error.errorName}",err: true);
        break;
    // show error dialog
    }
  }
}
