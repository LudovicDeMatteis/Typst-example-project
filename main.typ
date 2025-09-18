#import "Templates/slides/laas.typ": *
#import "@preview/polylux:0.4.0": *

#show: slides.with(
  title: "Contrôle prédictif pour la locomotion de robot à actionnement complexe",
  subtitle: "Présentation CSI 2eme année",
  authors: (
    (
      name: "Ludovic De Matteis",
      affiliation: "LAAS-CNRS",
      email: "ldematteis@laas.fr",
    ),
  ),
  footer: "Ludovic De Matteis - CSI 2A",
)

#set table(
  stroke: none,
  gutter: 0.2em,
  fill: (x, y) => if x == 0 or y == 0 { gray },
  inset: (right: 0.5em),
)

#show table.cell: it => {
  if it.x == 0 or it.y == 0 {
    set text(white, size: small)
    // strong(it)
    it
  } else if it.body == [] {
    // Replace empty cells with 'N/A'
    pad(..it.inset)[_N/A_]
  } else {
    it
  }
}
#let cgrey(body) = {
  table.cell(fill: gray.lighten(60%))[#body]
}
#let cgreen(body) = {
  table.cell(fill: green.lighten(60%))[#body]
}

#title_slide(
  title: "Introduction",
  subtitle: "Rappel de première année",
  outline: true,
)

#content_slide(title: "Introduction")[
  On on s'est arrete en 1ere annee
]

#content_slide(title: "Table des matières", outline: false)[
  #set par(leading: 1em)
  #set text(size: normal, weight: "bold")
  #outline(title: [], indent: 5%, depth: 2)
]

#title_slide(
  title: "Présentation scientifique",
  subtitle: "Travaux personnels",
)

#content_slide(title: "Dynamique en chaîne fermée")[
  Ajouter les derniers travaux sur les chaines fermees: Fin des travaux de 1ere annee sur le papier IROS, fin des travaux avec Victor sur les modeles d'actionnement et papier ICRA, mention du passage sur le robot de Virgile.
]

#content_slide(title: "Optimisation des sequences de contact")[
  #align(center)[
    #text(size: big, weight: "bold")[
      #underline[Problématique]
    ]
  ]
  Expliquer la problematique sur la non differentiabilite
]

#content_slide(title: "Optimisation des sequences de contact", outline: false)[
  #align(center)[
    #text(size: big, weight: "bold")[
      #underline[Utiliser les derivees du simulateur]
    ]
  ]
  Ajouter les travaux (qui n'ont pas aboutis) sur les derivees du simulateur en utilisant Simple.
]

#content_slide(title: "Optimisation des sequences de contact", outline: false)[
  #align(center)[
    #text(size: big, weight: "bold")[
      #underline[Optimisation sans gradient]
    ]
  ]
  Ajouter des descriptions des differents algorithmes sans gradient et de leurs avantages
  - MPPI
  - CMA-ES
  - Randomized Smoothing
]


#content_slide(title: "Optimisation des sequences de contact", outline: false)[
  #align(center)[
    #text(size: big, weight: "bold")[
      #underline[Model Predictive Path Integral]
    ]
  ]
  Decrire rapidement l'algo de MPPI pour avoir une bonne comprehension
  Presenter les resultats de Adam et expliquer le debut du passage sur le robot
]

#content_slide(title: "Optimisation des sequences de contact", outline: false)[
  #align(center)[
    #text(size: big, weight: "bold")[
      #underline[MPPI with multiple shooting]
    ]
  ]
  Expliquer la problematique, montrer la difference avec le single shooting
  Lien avec le randomized smoothing
]

#title_slide(
  title: "Présentation scientifique",
  subtitle: "Collaborations et perspectives",
  outline: false,
)

#content_slide(
  title: "Collaborations",
)[
  - *Victor Lutz* - Modèles d'actionnements - Modelisation des actionnements non-linéaires dans les robots avec une architecture série-parallèle
  - *Constant Roux* - Analyse des trajectoires de marche obtenues sur le robot Bolt dans le but d'évaluer la qualité des mouvements obtenus (forces de contact avec le sol, fréquence des pas, robustesse aux perturbations...)
  - *Constant Roux* - Création de trajectoires dynamiquement faisables pour de l'apprentissage par renforcement sur le robot H1
  - *Pietro Noah-Crestaz* - Aide a l'ecriture d'un papier de journal sur l'utilisation de contraintes et d'une estimation de la fonction valeur dans le cadre d'optimisation d'ordre 0 (MPPI)
  - *Vincent Bonnet* - Ecriture et résolution d'un problème de contrôle optimal paramétré pour de l'identification de fonction de coût bioméchanique.
]

#content_slide(title: "Perspectives")[
  === Court terme
  #list(
    spacing: 1.5em,
    [Continuer l'integration du tir multiple dans MPPI],
    [Utiliser une methode d'estimation des derivees pour integrer dans des methodes d'ordre 1 (gradient descent) ou d'ordre 2 (DDP, SQP...) et comparer avec MPPI],
  )
  === Moyen terme
  #list(
    spacing: 1.5em,
    [
      Ajouter des approches de la litterature du MPC avec une methode d'ordre 0 (MPPI)
      - MPC Robust (Minmax / Tube MPC / Multi-stage MPC)
      - Template based (MPC centroidal, LIP, ...)
    ],
    [Collaboration avec Armand Jordana (Post-doc à partir d'octobre)],
  )

  - Integrer dans MPPI des methodes connues en MPC (Robust MPC, methodes en dimension reduites)
  - Collaboration future avec Armand Jordana
]

#content_slide(title: "Publications")[
  #set list(spacing: 1.5em)
  - _Optimal control of walkers with parallel actuation_ \ *L. De Matteis*, V. Batto, J. Carpentier & N. Mansard - Refusé ICRA 2025 puis accepté IROS 2025
  - _Extended URDF: Accounting for parallel mechanism in robot description_ \ *L. De Matteis*, V. Batto - Accepté RAAD 2025
  - _Control of humanoid robots with parallel mechanisms using kinematic actuation models_ \ V. Lutz, *L. De Matteis*, N. Mansard - Refusé IROS 2025, resoumis ICRA 2026
  - _Collision avoidance in model predictive control using velocity damper_ \ A. Haffemayer, A. Jordana, *L. De Matteis* et al. - Accepté ICRA 2025
  - _Constrained Reinforcement Learning for Unstable Point-Feet Bipedal Locomotion Applied to the Bolt Robot_ \ C. Roux, E. Chane-Sane, *L. De Matteis*, et al. - Accepté Humanoids 2025
  - _TD-CD-MPPI: Temporal-Difference Constraint-Discounted Model Predictive Path Integral Control_ \ P. Noah-Crestaz, *L. De Matteis*, E. Chane-Sane et al. - Soumis RA-L Special Issue on Legged Robots, révision resoumisse
]

#title_slide(title: "Administratif")

#content_slide(title: "Formations")[
  #align(center + horizon)[
    #table(
      columns: (auto,) * 7,
      align: horizon + center,
      table.header(
        [#v(1cm)],
        [*Ethique et integrite*],
        [*Anglais*],
        [*Pedagogie*],
        [*Scientifique*],
        [*Professionnalisant*],
        [*Total*],
      ),
      [#v(0.5cm)#emph("Requis")#v(0.5cm)],
      cgrey("6h"),
      cgrey("20h"),
      cgrey("20h"),
      cgrey("20h"),
      cgrey("20h"),
      cgrey("100h"),

      [#emph("Acquis")#linebreak()],
      cgreen([6h - Mooc integrité #linebreak() 12h - Workshop SIPRI (éthique)]),
      cgrey("/"),
      cgrey("/"),
      cgreen([30h - Winter School #linebreak() 3h - Methodologie de la thèse #linebreak() 6h - Biomimétisme #linebreak() 30h - Summer School (à valider)]),
      cgreen("20h - Enseignement"),
      cgreen("107h"),
    )
  ]
]

#content_slide(title: "Cours")[
  #align(horizon)[
    === Première année
    - 20h - Automatique (SupAero) #linebreak()
    - 20h - Robotique (IUT GEII)
    === Deuxième année
    - 64h - Robotique (IUT GEII)
    === Troisième année
    - 18h - Optimisation (Toulouse School of Economics)
  ]
]
