import 'package:dartz/dartz.dart';
import 'package:labour/src/app/data/model/order_model.dart';
import 'package:labour/src/app/domain/entity/order.dart';
import 'package:labour/src/app/domain/repository/base_app_repository.dart';
import 'package:labour/src/core/error/failure.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

class SaveOrderUseCase extends BaseUseCase<void, OrderModel> {
  final BaseAppRepository baseAppRepository;

  SaveOrderUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, void>> call(OrderModel parameters) async {
    return await baseAppRepository.saveOrderToFireStore(parameters);
  }
}
