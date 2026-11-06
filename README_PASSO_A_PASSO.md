# DryTech Flutter — como executar no VS Code

Este pacote contém um protótipo Flutter navegável baseado nas 17 telas SVG enviadas. O código recria as interfaces em widgets Flutter; os SVGs originais foram preservados em `assets/referencias_svg/` como referência visual.

## 1. Instalar ferramentas
1. Instale o Flutter SDK: https://docs.flutter.dev/get-started/install
2. Instale o Visual Studio Code.
3. No VS Code, instale as extensões **Flutter** e **Dart**.
4. Abra o terminal e execute `flutter doctor`. Resolva os itens necessários para o dispositivo escolhido.

## 2. Abrir o projeto
1. Extraia o ZIP em uma pasta.
2. No VS Code, vá em **File > Open Folder** e selecione `DryTech_Flutter`.
3. Abra o terminal integrado: **Terminal > New Terminal**.
4. Execute:
   ```bash
   flutter pub get
   ```

## 3. Executar
- Para listar dispositivos: `flutter devices`
- Para executar no celular Android com depuração USB: habilite Opções do desenvolvedor e Depuração USB no aparelho, conecte-o e rode `flutter run`.
- Para emulador Android: abra um emulador pelo Android Studio e rode `flutter run`.
- Para web (se habilitado): `flutter run -d chrome`.

## 4. Testar o fluxo
O app inicia em Splash > Onboarding > Login. Na tela de login, preencha usuário e senha para entrar no protótipo. O cadastro valida campos obrigatórios e confirmação de senha. Na página inicial, use os atalhos ou a barra inferior para navegar. Em Nova secagem, selecione alimento, ajuste temperatura/tempo e inicie; pause/retome ou cancele.

## 5. Onde editar
- `lib/main.dart`: telas, componentes, navegação e cores.
- `assets/referencias_svg/`: desenhos originais enviados como referência.
- `pubspec.yaml`: configuração do projeto.

## Importante sobre o TCC
Este é um **protótipo de interface e navegação**, não a integração com a secadora física. Login/cadastro são demonstrativos, histórico e estatísticas usam dados fictícios, QR Code é ilustrativo, e a temperatura/tempo são estados locais do app. Para controlar hardware real será necessário integrar o protocolo definido pelo projeto (por exemplo, API/Bluetooth/Wi-Fi), backend, autenticação e geração real de QR/link. Não use valores fictícios para comandar equipamento real.

## Se der erro
- Rode `flutter doctor` e `flutter pub get`.
- Confira se abriu a pasta que contém `pubspec.yaml`.
- Se o VS Code não reconhecer Flutter, reinicie-o após instalar as extensões.
