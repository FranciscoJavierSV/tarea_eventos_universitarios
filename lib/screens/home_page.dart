import 'package:flutter/material.dart';

import '../data/event_data.dart';
import '../widgets/category_chip.dart';
import '../widgets/event_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String categoriaSeleccionada = 'Todos';

  @override
  Widget build(BuildContext context) {
    // Filtrado de eventos según la categoría seleccionada.
    // Si la categoría es 'Todos' se devuelven todos los eventos,
    // en otro caso se filtran por el campo 'categoria'.
    final eventosMostrados = categoriaSeleccionada == 'Todos'
        ? eventos
        : eventos.where((e) => e['categoria'] == categoriaSeleccionada).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Eventos'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              // Hero header: imagen + descripción. Responsive: en pantallas pequeñas se apilan en columna.
              LayoutBuilder(builder: (context, headerConstraints) {
                final isNarrow = headerConstraints.maxWidth < 700;
                return Card(
                  elevation: 2,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.04),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: isNarrow
                        ? Column(
                            children: [
                              // Limitar la altura del hero en pantallas estrechas para evitar overflow
                              Hero(
                                tag: 'hero-image',
                                child: SizedBox(
                                  height: 140,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset('assets/images/hero_eventos.jpg', fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '¡Feria Campus Eventos!',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '12 - 14 Octubre • Conoce, aprende y conéctate con las mejores actividades del campus.',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Hero(
                                  tag: 'hero-image',
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset('assets/images/hero_eventos.jpg', fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Título con fuente personalizada y mayor énfasis
                                    Text(
                                      '¡Feria Campus Eventos! — Vive la experiencia',
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.w800,
                                            color: Theme.of(context).colorScheme.primary,
                                            fontSize: 22,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Descripción extendida (mínimo 8 renglones) — se usa texto con saltos de línea para garantizar varias líneas de información
                                    Text(
                                      'Ven a la Feria Campus Eventos y descubre una selección diversa de actividades pensadas para ti.\nExplora proyectos estudiantiles, talleres prácticos, conferencias con expertos, muestras artísticas y competencias deportivas.\nAprende nuevas habilidades en talleres técnicos y creativos, participa en sesiones de networking y conoce a organizaciones estudiantiles.\nHabrá presentaciones, exhibiciones y oportunidades para inscribirse en actividades y colaborar con otros estudiantes.\nTrae a tus amigos y aprovecha las charlas sobre emprendimiento, innovación y bienestar estudiantil.\nHabrá espacio para preguntas, demostraciones en vivo y stands informativos de facultades.\nLa entrada es libre y las actividades tendrán cupos limitados; revisa los eventos y regístrate en los que te interesen.\n¡No te pierdas la oportunidad de conectar, aprender y divertirte en la Feria Campus Eventos!',
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            fontSize: 13,
                                            color: Theme.of(context).textTheme.bodyLarge?.color,
                                            height: 1.3,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                );
              }),

              const SizedBox(height: 16),

              // Filtros (chips) y icono al inicio
              LayoutBuilder(builder: (context, chipConstraints) {
                final isNarrow = chipConstraints.maxWidth < 420;

                // Área de filtros responsive: columna en estrecho, ListView horizontal en anchos grandes, Wrap en intermedios.
                final isWide = chipConstraints.maxWidth >= 700;

                if (isNarrow) {
                  // icon arriba seguido de chips en columna
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Icon(Icons.filter_list, color: Theme.of(context).colorScheme.primary),
                      ),
                      ...categorias.map(
                        (categoria) => CategoryChip(
                          texto: categoria,
                          seleccionado: categoriaSeleccionada == categoria,
                          onTap: () {
                            setState(() {
                              categoriaSeleccionada = categoria;
                            });
                          },
                        ),
                      ),
                    ],
                  );
                }

                if (isWide) {
                  // ListView horizontal en pantallas grandes para dar estilo más cercano al diseño original pero con scroll
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(Icons.filter_list, color: Theme.of(context).colorScheme.primary),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: categorias.length,
                            padding: const EdgeInsets.only(left: 4),
                            separatorBuilder: (_, __) => const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              final categoria = categorias[index];
                              return CategoryChip(
                                texto: categoria,
                                seleccionado: categoriaSeleccionada == categoria,
                                onTap: () {
                                  setState(() {
                                    categoriaSeleccionada = categoria;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }

                // Tamaños intermedios: usar Wrap para que bajen a la siguiente línea si no caben
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(Icons.filter_list, color: Theme.of(context).colorScheme.primary),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          alignment: WrapAlignment.start,
                          children: categorias.map((categoria) {
                            return CategoryChip(
                              texto: categoria,
                              seleccionado: categoriaSeleccionada == categoria,
                              onTap: () {
                                setState(() {
                                  categoriaSeleccionada = categoria;
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                );
              }),

              const SizedBox(height: 16),

              Text(
                'Eventos encontrados: ${eventosMostrados.length}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              // Grid de eventos: usamos GridView pero sin su propio scroll (se delega al SingleChildScrollView padre)
              LayoutBuilder(builder: (context, constraints) {
                final width = constraints.maxWidth;
                final columnas = width >= 900
                    ? 4
                    : width >= 600
                        ? 3
                        : width >= 380
                            ? 2
                            : 1;

                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: eventosMostrados.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columnas,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    final evento = eventosMostrados[index];

                    return EventCard(
                      evento: evento,
                      onPressed: () {
                        final titulo = evento['titulo'];
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Te interesa: $titulo')),
                        );
                      },
                    );
                  },
                );
              }),

              const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
