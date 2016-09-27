library(DiagrammeR)

# Неориентированный граф
grViz("
      graph mygraph {
        a -- b -- c;
        b -- d;
      }
")

# Ориентированный граф
grViz("
      digraph mydigraph {
        a -> b -> c;
        b -> d;
      }
")

# Пример настройки стилей оформления вершин и рёбер
grViz("
      digraph mydigraph {
        // label - видимое название вершины
        a [label='Foo'];
        // shape - форма отображения вершины
        b [shape=box];
        // color - цвет ребра
        a -> b -> c [color=blue];
        // style - стиль линии ребра
        b -> d [style=dotted];
      }
")

# граф элементов HTML файла sample.html
grViz("
      digraph xpath {
      html -> head ->title;
      html -> body;
      body -> {h1 'p' 'p[@class=abstract]' 'div[@class=abstract]' div}
      'div[@class=abstract]' -> {'p[1]' 'p[2]' 'p[@id=date]'}
      }
")
