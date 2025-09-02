#import "Templates/slides/laas.typ": *
#import "@preview/polylux:0.4.0": *

#show: slides.with(
  title: "An introduction to Model Predictive Path Integral",
  subtitle: "Workshop Gepetto 2025 - Toulouse",
  authors: (
    (
      name: "Ludovic De Matteis",
      affiliation: "LAAS-CNRS",
      email: "ldematteis@laas.fr",
    ),
    (
      name: "Pietro Noah-Crestaz",
      affiliation: "LAAS-CNRS & Trento university",
    ),
  ),
  footer: "Ludovic De Matteis - Workshop Gepetto 2025",
)

#content_slide(
  title: "Demonstration",
  subtitle: "Wow c'est beau",
)[
  Test
  #align(bottom + right)[
    Coucou c'est le nouveau contenu
  ]
]

#title_slide(
  title: "Introduction",
  subtitle: "Un super sous-titre",
)

#content_slide()[
  Test
  #align(bottom + right)[
    Coucou c'est le nouveau contenu
  ]
]
