import 'package:shelf_router/shelf_router.dart';
import 'package:webserver/controllers/codes_data_controllers/loinc_controller.dart';
import 'package:webserver/goodies/api_extension.dart';

class LoincView {
  Router router;

  LoincView(this.router) {
    router.post('/api/${NetWorkConfig.instance.apiVersion}/loinc/search', LoincController.instance.searchItem);
    router.get('/api/${NetWorkConfig.instance.apiVersion}/loinc/<loincNum>', LoincController.instance.getLoincItem);
  }
}
