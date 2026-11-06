import 'package:flutter/material.dart';

void main() => runApp(const DryTechApp());

const orange = Color(0xFFFF650A);
const orangeLight = Color(0xFFFF8A50);
const ink = Color(0xFF252525);
const muted = Color(0xFF777777);
const pageBg = Color(0xFFF7F7F7);
const lineColor = Color(0xFFE5E5E5);

class DryTechApp extends StatelessWidget {
  const DryTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DryTech',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: pageBg,
        colorScheme: ColorScheme.fromSeed(seedColor: orange, primary: orange),
        fontFamily: 'Roboto',
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: lineColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: lineColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: orange, width: 1.5),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

void go(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

void replace(BuildContext context, Widget page) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  const PrimaryButton(
    this.label, {
    super.key,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: orange,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        onPressed: onPressed,
        icon: icon == null ? const SizedBox.shrink() : Icon(icon, size: 18),
        label: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class AppField extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscure;
  final TextEditingController? controller;
  final TextInputType? keyboard;

  const AppField(
    this.label,
    this.hint, {
    super.key,
    this.obscure = false,
    this.controller,
    this.keyboard,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: ink,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboard,
          decoration: InputDecoration(hintText: hint),
        ),
      ],
    );
  }
}

class AppPage extends StatelessWidget {
  final String title;
  final Widget child;
  final int selected;

  const AppPage({
    super.key,
    required this.title,
    required this.child,
    this.selected = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: orange,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      body: SafeArea(child: child),
      bottomNavigationBar: NavigationBar(
        height: 68,
        selectedIndex: selected,
        onDestinationSelected: (i) {
          final pages = [
            const HomeScreen(),
            const SavedFoodsScreen(),
            const SelectFoodScreen(),
            const NotificationsScreen(),
            const ProfileScreen(),
          ];
          replace(context, pages[i]);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            label: 'Salvos',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            label: 'Secar',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_none),
            label: 'Avisos',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class Panel extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const Panel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: lineColor),
      ),
      child: child,
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? trailing;
  final Color trailingColor;

  const InfoRow(
    this.title,
    this.subtitle, {
    super.key,
    this.trailing,
    this.trailingColor = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return Panel(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 11, color: muted),
                ),
              ],
            ),
          ),
          if (trailing != null)
            Text(
              trailing!,
              style: TextStyle(
                color: trailingColor,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
        ],
      ),
    );
  }
}

Widget section(String text) => Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: ink,
        ),
      ),
    );

Widget gap([double height = 14]) => SizedBox(height: height);

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) replace(context, const OnboardingScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [orange, orangeLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_laundry_service_outlined,
              size: 76,
              color: Colors.white,
            ),
            SizedBox(height: 14),
            Text(
              'DryTech',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            Text(
              'SECAGEM INTELIGENTE',
              style: TextStyle(
                letterSpacing: 2,
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(28),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [orange, orangeLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.local_laundry_service_outlined,
              size: 72,
              color: Colors.white,
            ),
            gap(28),
            const Text(
              'Sua secagem,\nmais inteligente.',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            gap(12),
            const Text(
              'Acompanhe seus alimentos, personalize ciclos e compartilhe sua DryTech.',
              style: TextStyle(color: Colors.white, fontSize: 15, height: 1.5),
            ),
            gap(38),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: orange,
                ),
                onPressed: () => go(context, const LoginScreen()),
                child: const Text('Começar'),
              ),
            ),
            TextButton(
              onPressed: () => go(context, const RegisterScreen()),
              child: const Text(
                'Criar uma conta',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final user = TextEditingController();
  final pass = TextEditingController();

  @override
  void dispose() {
    user.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 50, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const Text(
                      'DRY',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Text(
                      'TECH',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: orange,
                      ),
                    ),
                    gap(22),
                    const Text(
                      'Bem-vindo de volta!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Text(
                      'Entre na sua conta para continuar.',
                      style: TextStyle(color: muted, fontSize: 12),
                    ),
                  ],
                ),
              ),
              gap(38),
              AppField(
                'Nome de usuário ou e-mail',
                '@seuusuario ou e-mail',
                controller: user,
              ),
              gap(18),
              AppField(
                'Senha',
                'Digite sua senha',
                controller: pass,
                obscure: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Fluxo de recuperação será conectado depois.',
                        ),
                      ),
                    );
                  },
                  child: const Text('Esqueci minha senha'),
                ),
              ),
              gap(14),
              PrimaryButton(
                'Entrar',
                onPressed: () {
                  if (user.text.trim().isEmpty || pass.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Preencha usuário e senha.'),
                      ),
                    );
                  } else {
                    replace(context, const HomeScreen());
                  }
                },
              ),
              gap(24),
              Center(
                child: TextButton(
                  onPressed: () => go(context, const RegisterScreen()),
                  child: const Text(
                    'Ainda não tem conta? Criar conta',
                    style: TextStyle(
                      color: orange,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final name = TextEditingController();
  final handle = TextEditingController();
  final email = TextEditingController();
  final pwd = TextEditingController();
  final confirm = TextEditingController();

  @override
  void dispose() {
    for (final controller in [name, handle, email, pwd, confirm]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
        backgroundColor: orange,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Vamos começar!',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
                ),
              ),
              gap(18),
              AppField('Nome completo', 'Como gostaria de ser chamado(a)?',
                  controller: name),
              gap(14),
              AppField('Nome de usuário', 'Escolha seu @usuário',
                  controller: handle),
              gap(14),
              AppField('E-mail', 'seuemail@email.com',
                  controller: email, keyboard: TextInputType.emailAddress),
              gap(14),
              AppField('Senha', 'Crie uma senha',
                  controller: pwd, obscure: true),
              gap(14),
              AppField('Confirmar senha', 'Digite novamente',
                  controller: confirm, obscure: true),
              gap(22),
              PrimaryButton(
                'Criar minha conta',
                onPressed: () {
                  final fields = [name, handle, email, pwd, confirm];
                  if (fields.any((c) => c.text.trim().isEmpty)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Preencha todos os campos.'),
                      ),
                    );
                  } else if (pwd.text != confirm.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('As senhas não coincidem.'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Cadastro demonstrativo concluído! Conecte ao backend para salvar os dados.',
                        ),
                      ),
                    );
                    replace(context, const HomeScreen());
                  }
                },
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Já tem conta? Fazer login',
                  style: TextStyle(color: orange),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'DryTech',
      selected: 0,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Olá, Thaís!',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
          ),
          const Text(
            'Sua secadora está pronta para usar.',
            style: TextStyle(color: muted),
          ),
          gap(18),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                colors: [orange, orangeLight],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'STATUS DA SECADORA',
                  style: TextStyle(color: Colors.white70, fontSize: 10),
                ),
                SizedBox(height: 8),
                Text(
                  'Em espera',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Nenhum ciclo em andamento',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          section('Acesso rápido'),
          Row(
            children: [
              Expanded(
                child: _quick(
                  context,
                  'Nova secagem',
                  Icons.add_circle,
                  const SelectFoodScreen(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _quick(
                  context,
                  'Histórico',
                  Icons.history,
                  const HistoryScreen(),
                ),
              ),
            ],
          ),
          section('Últimas atividades'),
          const InfoRow(
            'Maçãs',
            'Secagem concluída • Hoje, 09:18',
            trailing: 'Concluída',
          ),
          gap(10),
          const InfoRow(
            'Alecrim',
            'Ciclo salvo • Ontem',
            trailing: 'Salvo',
            trailingColor: orange,
          ),
          section('Compartilhamento'),
          PrimaryButton(
            'Adicionar amigo',
            icon: Icons.person_add_alt_1,
            onPressed: () => go(context, const AddFriendScreen()),
          ),
        ],
      ),
    );
  }
}

Widget _quick(BuildContext context, String title, IconData icon, Widget page) {
  return InkWell(
    onTap: () => go(context, page),
    child: Panel(
      child: Column(
        children: [
          Icon(icon, color: orange, size: 28),
          gap(8),
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    ),
  );
}

class SelectFoodScreen extends StatelessWidget {
  const SelectFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final foods = [
      ['🍎', 'Maçãs', 'Frutas • 90°C'],
      ['🌿', 'Alecrim', 'Ervas • 45°C'],
      ['🥕', 'Cenouras', 'Vegetais • 75°C'],
      ['🍵', 'Chá', 'Ervas • 50°C'],
    ];

    return AppPage(
      title: 'Nova secagem',
      selected: 2,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'O que você quer desidratar?',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
          ),
          const Text(
            'Escolha um alimento para começar.',
            style: TextStyle(color: muted),
          ),
          gap(18),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Buscar alimento',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          section('Alimentos'),
          ...foods.map(
            (food) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () => go(
                  context,
                  ConfigureDryingScreen(food: food[1]),
                ),
                child: Panel(
                  child: Row(
                    children: [
                      Text(food[0], style: const TextStyle(fontSize: 25)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              food[1],
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              food[2],
                              style: const TextStyle(
                                color: muted,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: orange),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ConfigureDryingScreen extends StatefulWidget {
  final String food;

  const ConfigureDryingScreen({
    super.key,
    this.food = 'Maçãs',
  });

  @override
  State<ConfigureDryingScreen> createState() =>
      _ConfigureDryingScreenState();
}

class _ConfigureDryingScreenState extends State<ConfigureDryingScreen> {
  double temp = 90;
  double hours = 10;

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Configurar secagem',
      selected: 2,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Panel(
            child: Row(
              children: [
                const Text('🍎', style: TextStyle(fontSize: 28)),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.food,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    const Text(
                      'Alimento selecionado',
                      style: TextStyle(color: muted, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
          section('Temperatura: ${temp.round()} °C'),
          Slider(
            value: temp,
            min: 35,
            max: 100,
            divisions: 13,
            label: '${temp.round()} °C',
            activeColor: orange,
            onChanged: (value) => setState(() => temp = value),
          ),
          section('Tempo estimado: ${hours.round()} h'),
          Slider(
            value: hours,
            min: 1,
            max: 24,
            divisions: 23,
            label: '${hours.round()} h',
            activeColor: orange,
            onChanged: (value) => setState(() => hours = value),
          ),
          section('Observações'),
          const TextField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Adicione uma nota (opcional)',
            ),
          ),
          gap(22),
          PrimaryButton(
            'Iniciar secagem',
            onPressed: () => go(
              context,
              DryingScreen(
                food: widget.food,
                temp: temp,
                hours: hours,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DryingScreen extends StatefulWidget {
  final String food;
  final double temp;
  final double hours;

  const DryingScreen({
    super.key,
    this.food = 'Maçãs',
    this.temp = 90,
    this.hours = 10,
  });

  @override
  State<DryingScreen> createState() => _DryingScreenState();
}

class _DryingScreenState extends State<DryingScreen> {
  bool paused = false;

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: paused ? 'Secagem pausada' : 'Secagem em andamento',
      selected: 0,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Panel(
            child: Column(
              children: [
                Text(
                  widget.food.toUpperCase(),
                  style: const TextStyle(
                    color: muted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                gap(18),
                Text(
                  paused ? 'Pausada' : '06:42:18',
                  style: const TextStyle(
                    fontSize: 34,
                    color: orange,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  paused
                      ? 'Ciclo temporariamente interrompido'
                      : 'Tempo restante',
                  style: const TextStyle(color: muted),
                ),
                gap(14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const LinearProgressIndicator(
                    value: .38,
                    minHeight: 9,
                    color: orange,
                    backgroundColor: Color(0xFFF1E4DC),
                  ),
                ),
              ],
            ),
          ),
          section('Informações'),
          InfoRow(
            'Temperatura atual',
            '${widget.temp.round()} °C',
          ),
          gap(10),
          InfoRow(
            'Tempo programado',
            '${widget.hours.round()} horas',
          ),
          gap(10),
          InfoRow(
            'Status',
            paused ? 'Pausada' : 'Funcionando',
            trailing: paused ? 'Pausada' : 'Ativa',
            trailingColor: paused ? orange : Colors.green,
          ),
          gap(22),
          PrimaryButton(
            paused ? 'Retomar secagem' : 'Pausar secagem',
            icon: paused ? Icons.play_arrow : Icons.pause,
            onPressed: () => setState(() => paused = !paused),
          ),
          gap(8),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text('Cancelar secagem?'),
                  content: const Text('O ciclo será encerrado.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text('Voltar'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: const Text(
              'Cancelar secagem',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Notificações',
      selected: 3,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          section('Hoje'),
          const InfoRow(
            'Secagem concluída',
            'Maçãs • há 12 minutos',
            trailing: 'Concluída',
          ),
          gap(10),
          const InfoRow(
            'Secagem iniciada',
            'Cenouras • há 2 horas',
            trailing: 'Ativa',
            trailingColor: orange,
          ),
          section('Ontem'),
          const InfoRow(
            'Novo convite',
            'Pedro foi convidado para colaborar',
            trailing: 'Convite',
            trailingColor: orange,
          ),
        ],
      ),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Histórico',
      selected: 1,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const InfoRow(
            'Maçãs',
            'Hoje • 90 °C • 10 h',
            trailing: 'Concluída',
          ),
          gap(10),
          const InfoRow(
            'Cenouras',
            'Ontem • 75 °C • 8 h',
            trailing: 'Concluída',
          ),
          gap(10),
          const InfoRow(
            'Alecrim',
            'Ontem • 45 °C • 4 h',
            trailing: 'Concluída',
          ),
        ],
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Detalhes da secagem',
      selected: 1,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🍎  Maçãs',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Concluída • Hoje, 09:18',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
          section('Resumo'),
          const InfoRow('Temperatura média', '89 °C'),
          gap(8),
          const InfoRow('Duração', '10 horas'),
          gap(8),
          const InfoRow('Responsável', 'Thaís Soares'),
          gap(20),
          PrimaryButton(
            'Repetir secagem',
            onPressed: () => go(context, const SelectFoodScreen()),
          ),
        ],
      ),
    );
  }
}

class SavedFoodsScreen extends StatelessWidget {
  const SavedFoodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final saved = [
      'Maçãs • 90 °C • 10 h',
      'Alecrim • 45 °C • 4 h',
      'Cenouras • 75 °C • 8 h',
      'Chá • 50 °C • 3 h',
    ];

    return AppPage(
      title: 'Alimentos salvos',
      selected: 1,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ...saved.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InfoRow(
                item,
                'Receita salva',
                trailing: '♡',
                trailingColor: orange,
              ),
            ),
          ),
          PrimaryButton(
            'Adicionar alimento',
            onPressed: () => go(context, const SelectFoodScreen()),
          ),
        ],
      ),
    );
  }
}

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final handle = TextEditingController();

  @override
  void dispose() {
    handle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Adicionar amigo',
      selected: 4,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Conecte-se com pessoas que compartilham a secadora.',
            style: TextStyle(color: muted),
          ),
          section('Seu QR Code'),
          Panel(
            child: Column(
              children: [
                Container(
                  width: 180,
                  height: 180,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: lineColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const _FakeQr(),
                ),
                const Text(
                  'QR Code ilustrativo do protótipo',
                  style: TextStyle(fontSize: 10, color: muted),
                ),
              ],
            ),
          ),
          section('Compartilhar link'),
          const SelectableText('drytech.app/convite/THAIS24'),
          gap(8),
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Integre o compartilhamento para copiar um link real.',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.copy),
            label: const Text('Copiar link'),
          ),
          section('Buscar por @usuário'),
          TextField(
            controller: handle,
            decoration: const InputDecoration(
              hintText: '@nome de usuário',
            ),
          ),
          gap(12),
          PrimaryButton(
            'Buscar pessoa',
            onPressed: () {
              if (handle.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Digite um nome de usuário.'),
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: const Text('Busca demonstrativa'),
                    content: Text(
                      'A busca por ${handle.text} será conectada ao backend.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _FakeQr extends StatelessWidget {
  const _FakeQr();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _QrPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _QrPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = ink;
    const count = 21;
    final cell = size.width / count;

    for (int y = 0; y < count; y++) {
      for (int x = 0; x < count; x++) {
        final finder =
            (x < 7 && y < 7) ||
            (x > 13 && y < 7) ||
            (x < 7 && y > 13);

        final on = finder
            ? ((x % 14 < 7 && y % 14 < 7) &&
                (x % 14 == 0 ||
                    x % 14 == 6 ||
                    y % 14 == 0 ||
                    y % 14 == 6 ||
                    (x % 14 >= 2 &&
                        x % 14 <= 4 &&
                        y % 14 >= 2 &&
                        y % 14 <= 4)))
            : ((x * 7 + y * 11 + x * y) % 5 < 2);

        if (on) {
          canvas.drawRect(
            Rect.fromLTWH(
              x * cell,
              y * cell,
              cell * .9,
              cell * .9,
            ),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CollaboratorsScreen extends StatelessWidget {
  const CollaboratorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Colaboradores',
      selected: 4,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Convide pessoas para acompanhar sua secadora.',
            style: TextStyle(color: muted),
          ),
          section('Pessoas com acesso'),
          const InfoRow(
            'Thaís Soares',
            'Administradora',
            trailing: 'Você',
            trailingColor: orange,
          ),
          gap(10),
          const InfoRow(
            'Pedro Silva',
            'Acesso compartilhado',
            trailing: 'Ativo',
          ),
          gap(20),
          PrimaryButton(
            'Adicionar amigo',
            onPressed: () => go(context, const AddFriendScreen()),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const options = [
      'Sua conta',
      'Notificações',
      'Segurança',
      'Privacidade',
      'Aparelho DryTech',
      'Ajuda',
    ];

    return AppPage(
      title: 'Configurações',
      selected: 4,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ...options.map(
            (option) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InfoRow(
                option,
                'Configurações e preferências',
                trailing: '›',
                trailingColor: orange,
              ),
            ),
          ),
          TextButton(
            onPressed: () => replace(context, const LoginScreen()),
            child: const Text(
              'Sair da conta',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const heights = [40.0, 70.0, 55.0, 95.0, 62.0, 120.0, 80.0];

    return AppPage(
      title: 'Estatísticas',
      selected: 1,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Panel(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _Metric('24', 'Secagens'),
                _Metric('8', 'Alimentos'),
              ],
            ),
          ),
          section('Atividade semanal'),
          Panel(
            child: SizedBox(
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (final height in heights)
                    Container(
                      width: 22,
                      height: height,
                      decoration: BoxDecoration(
                        color: orangeLight,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                ],
              ),
            ),
          ),
          section('Alimentos mais secos'),
          const InfoRow(
            'Maçãs',
            '8 secagens',
            trailing: '33%',
            trailingColor: orange,
          ),
          gap(10),
          const InfoRow(
            'Cenouras',
            '6 secagens',
            trailing: '25%',
            trailingColor: orange,
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String value;
  final String label;

  const _Metric(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 28,
            color: orange,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: muted, fontSize: 11),
        ),
      ],
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Perfil',
      selected: 4,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 42,
              backgroundColor: Color(0xFFFFE3D5),
              child: Icon(Icons.person, color: orange, size: 42),
            ),
          ),
          gap(12),
          const Center(
            child: Text(
              'Thaís Soares',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ),
          const Center(
            child: Text('@thais', style: TextStyle(color: muted)),
          ),
          section('Minha conta'),
          const InfoRow(
            'Colaboradores',
            'Gerencie quem acompanha sua secadora',
            trailing: '›',
            trailingColor: orange,
          ),
          gap(10),
          const InfoRow(
            'Estatísticas',
            'Veja seu histórico de uso',
            trailing: '›',
            trailingColor: orange,
          ),
          gap(10),
          const InfoRow(
            'Configurações',
            'Preferências e segurança',
            trailing: '›',
            trailingColor: orange,
          ),
          gap(10),
          PrimaryButton(
            'Adicionar amigo',
            onPressed: () => go(context, const AddFriendScreen()),
          ),
        ],
      ),
    );
  }
}
