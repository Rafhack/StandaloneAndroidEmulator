# Emulador do Android _Standalone_ no Windows

Tabela de conteúdos
1. [Objetivo](#objetivo)
2. [Instalação de dependências](#instalação-de-dependências)
3. [Configuração do ambiente](#configuração-do-ambiente)
4. [Instalação do emulador](#instalação-do-emulador)
5. [Configurações adicionais](#configurações-adicionais)


## Objetivo
Este repositório tem como objetivo realizar a instalação e confuguração automatizada do emulador do Android de forma _standalone_, ou seja, sem a necessidade da instalação do Android Studio.<br>O emulador do Android pode ser considerado como uma instalação limpa do sistema, logo, oferece maior confiabilidade em comparação com instalações de emuladores de terceiros.<br><br>

### Instalação de dependências
1. **JDK**

    É necessário ter uma instalação do JDK (Java Development Kit) na máquina para o funcionamento das ferramentas de linha de comando do Android. Para isso [faça o download do JDK](https://www.oracle.com/java/technologies/javase-jdk16-downloads.html){:target="_blank"} e siga os passos de instalação normalmente.

2. **Android SDK Command Line Tools**

    Para realizar a instalação do emulador, as ferramentas de linha de comando do Android são necessárias. [Faça o download aqui](https://developer.android.com/studio#cmdline-tools){:target="_blank"} e siga para os próximos passos.
    
3. **Intel HAXM**

    Em alguns sistemas, é necessária a instalação do motor de virtualização da Intel. [Faça o download aqui](https://github.com/intel/haxm/releases/tag/v7.7.0){:target="_blank"} e siga para os próximos passos.

3. **Script de automação e ferramentas**

    O script de automação irá realizar todos os passos necessários para a instalação e configuração do emulador. [Faça o download aqui](https://github.com/Rafhack/StandaloneAndroidEmulator/archive/refs/heads/master.zip){:target="_blank"} ou se preferir, use o `git` para clonar este repositório na máquina local.<br><br>

## Configuração do ambiente
Após o download e instalalção das dependências citadas acima, é necessário configurar o ambiente para as ferramentas e emulador do Android
* Crie uma pasta com um nome e local de escolha e extraia para dentro dela a pasta `cmdline-tools` contida no _Command Line Tools_ baixado anteriormente.
* Mova ou extraia os arquivos baixados deste repositório para a pasta criada.

Ao realizar estes passos, a estrutura da pasta criada deve estar como a seguir:
> * Pasta
>    + cmdline-tools
>    + android-emulator.bat
>    + fake-package.xml
>    + unzip.exe

<br>

## Instalação do emulador
Com o ambiente configurado, basta apenas executar o script de instalação. Para isso execute o arquivo `android-emulator.bat`. O script irá fazer download e instalação dos arquivos necessários, e ao final do processo, irá executar o emulador do Android.
<br>
Para executar o emulador daqui em diante, basta executar o arquivo `android-emulator.bat`<br><br>

## Configurações adicionais
É possível alterar configurações como versão do Android e nome do emulador. Para alterar tais configurações, basta editar o arquivo `android-emulator.bat` em qualquer editor de textos.<br><br>

* Para alterar a versão do Android, altere a variável `API` para a versão desejada. Por exemplo, para instalar a versão _Marshmallow_, altere a variável da seguinte maneira:
```bat
SET API=23
```
##### Consulte as [referência de versões e níveis de API](https://source.android.com/setup/start/build-numbers#platform-code-names-versions-api-levels-and-ndk-releases){:target="_blank"}<br><br>

* Para alterar o nome do emulador, altere a variável `AVD_NAME` para o nome desejado. Assim é possível manter diversos emuladores com configurações específicas.
