import 'package:cpf_cnpj_validator/cpf_validator.dart';

///classe de validação
class Validators {
  ///metodo que tornar um determinado valor obrigatorio
  static String? isRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'O preenchimento do campo é obrigatorio';
    }
    return null;
  }

  ///metodo que tornar um determinado valor obrigatorio
  static String? isDropdownRequired(dynamic value) {
    if (value == null) {
      return 'O preenchimento do campo é obrigatorio';
    }
    return null;
  }

  ///metodo que faz a verificação de Email
  static String? isEmail(String? value, bool isRequired) {
    if (isRequired) {
      String? mensagem = Validators.isRequired(value);
      if (mensagem != null) {
        return mensagem;
      }
    }

    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!)) {
      return 'O e-mail informado não é válido';
    }

    return null;
  }

  ///Metódo que faz a verificação de numero de telefone
  static String? isPhoneNumber(String? value, bool isRequired) {
    if (isRequired) {
      String? mensagem = Validators.isRequired(value);
      if (mensagem != null) {
        return mensagem;
      }
    }

    if (!RegExp(r"(\(\d{2}\))(\d{5}\-\d{4})").hasMatch(value!)) {
      return 'O telefone informado não é válido';
    }

    return null;
  }

  ///Metódo que faz a verificação de CPF
  static String? isCPF(String? value, bool isRequired) {
    if (isRequired) {
      String? mensagem = Validators.isRequired(value);
      if (mensagem != null) {
        return mensagem;
      }
    }

    if (!CPFValidator.isValid(value)) {
      return 'O CPF informado não é válido';
    }

    return null;
  }

  ///metodo que obriga um determinado campo a conter uma CNH válida
  static String? isCNH(String? value, bool isRequired) {
    if (isRequired) {
      String? mensagem = Validators.isRequired(value);
      if (mensagem != null) {
        return mensagem;
      }
    }

    if (!RegExp(r"\d{11}").hasMatch(value!)) {
      return 'A CNH informada não é válida';
    }

    return null;
  }

  ///metodo que obriga um determinado campo a conter uma RENAVAM válido
  static String? isRENAVAM(String? value, bool isRequired) {
    if (isRequired) {
      String? mensagem = Validators.isRequired(value);
      if (mensagem != null) {
        return mensagem;
      }
    }

    if (!RegExp(r"\d{11}").hasMatch(value!)) {
      return 'O RENAVAM informado não é válido';
    }

    return null;
  }

  ///metodo que obriga um determinado campo a conter uma placa válida
  static String? isPlate(String? value, bool isRequired) {
    if (isRequired) {
      String? mensagem = Validators.isRequired(value);
      if (mensagem != null) {
        return mensagem;
      }
    }

    if (!RegExp(r"^[a-zA-Z]{3}[0-9][A-Za-z0-9][0-9]{2}$").hasMatch(value!)) {
      return 'A placa informado não é válida';
    }

    return null;
  }

  ///metodo que obriga um determinado campo ser alfanumerico, ou seja, conter apenas números e letras
  static String? isAlphaNumeric(String? value, isRequired) {
    if (isRequired) {
      String? mensagem = Validators.isRequired(value);
      if (mensagem != null) {
        return mensagem;
      }
    }

    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value!)) {
      return 'O campo deve conter apenas números e letras';
    }

    return null;
  }

  ///metodo que obriga dois determinados campos a serem iguais
  static String? isEquals(String field1, String value1, String field2, String? value2, bool isRequired) {
    if (isRequired) {
      String? mensagem = Validators.isRequired(value2);
      if (mensagem != null) {
        return mensagem;
      }
    }

    if (value1 != value2) {
      return 'Os campos "$field1" e "$field2" não são iguais';
    }

    return null;
  }
}
