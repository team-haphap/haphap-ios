import '../../../../core/util/result.dart';
import '../../../../presentation/register/type/register_result_type.dart';
import '../../../model/register/register_dropdown_item_model.dart';
import '../../../model/register/register_model.dart';
import '../../../model/register/register_process_model.dart';
import '../../../model/register/registration_check_type.dart';
import '../../../model/register/registration_model.dart';

abstract class RegisterRepository {
  Future<Result<List<RegisterDropDownItemModel>>> getRegisterPostNames();

  Future<Result<List<RegisterProcessModel>>> getRegisterPostStages(
    int postingId,
  );

  Future<Result<RegistrationModel>> postRegister(RegisterModel registerInfo);

  Future<Result<RegistrationCheckType>> postCheckRegistration(
    int postingId,
    int stageId,
    RegisterResultType result,
  );
}
