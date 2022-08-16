# Caronapp
> Aplicativo de caronas compartilhadas

Caronapp é um aplicativo mobile de caronas compartilhadas. O objetivo principal é que ele apresente uma plataforma que centralize em um ambiente pessoas que têm interesse em compartilhar caronas, seja por questões de praticidade, ou por questões econômicas (contribuição para o combustível da viagem). O aplicativo permite ao usuário que ele ofereça ou participe de caronas, além de poder estar presente em grupos de caronas específicas (localidade, pessoas conhecidas, grupos de confiança). 

![Login](https://github.com/henrickbart/caronapp-flutter/blob/main/docs/images/login.png?raw=true)
![Home](https://github.com/henrickbart/caronapp-flutter/blob/main/docs/images/home.png?raw=true)
![Search](https://github.com/henrickbart/caronapp-flutter/blob/main/docs/images/search.png?raw=true)
![Groups](https://github.com/henrickbart/caronapp-flutter/blob/main/docs/images/groups.png?raw=true)
![Group](https://github.com/henrickbart/caronapp-flutter/blob/main/docs/images/group.png?raw=true)
![Caronas](https://github.com/henrickbart/caronapp-flutter/blob/main/docs/images/caronas.png?raw=true)
![Profile](https://github.com/henrickbart/caronapp-flutter/blob/main/docs/images/profile.png?raw=true)
![Vehicles](https://github.com/henrickbart/caronapp-flutter/blob/main/docs/images/vehicles.png?raw=true)

## Instalação

Frontend:

O frontend da aplicação foi desenvolvido em Flutter. Portanto, para executar a aplicação e realizar chamadas na API, você deve possuir o ambiente de desenvolvimento do Flutter instalado em sua máquina. Para tal, consulte a seguinte página:

https://docs.flutter.dev/get-started/install

Lembre-se que você deve possuir um emulador Android configurado e selecionado para executar o programa.

Baixe o repositório, entre no repositório e execute o seguinte comando para instalar as dependências:

```sh
flutter pub get
```

Altere o endereço do servidor em */lib/repository/base.repository.dart*, mudando o valor de *serverURL* (linha 9), para que seja possível enviar as requests para a API. Salve o arquivo.

Para executar, execute o seguinte comando:

```sh
flutter run
```

## Exemplos de uso

O seguinte vídeo apresenta a maioria dos casos de uso dentro do aplicativo: 

https://www.youtube.com/watch?v=fDtEl6FDpg0


## Meta

henrickbart – henrickbart@gmail.com
Lorenzuou –  lorenzoscaramussa@hotmail.com
Distribuido sobre a licença MIT . Veja ``LICENSE`` para mais informações.
