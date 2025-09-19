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

#let ddot = math.dot.double

#content_slide(title: "Introduction", outline: false)[
  #block(width: 60%, height: auto, [
    - Modelisation de robots avec des chaines cinematiques bouclees
      $ M(q) ddot(q) + b(q, dot(q)) = tau(u) + J_c (q)^T lambda $
    - Calcul des dérivees de la dynamique
      $ (d ddot(q))/(d z); (d lambda)/(d z) #h(1cm) z in {q, dot(q), u} $
    - Application dans le cadre d'un probleme de control optimal
      $
        & min_(U in cal(U), X in cal(X)) && sum_(k = 0)^(N-1) l(x_k, u_k; k) + V_f (x_N)          \
        & s.t.                           && x_0 = x(t_0)                                          \
        &                                && x_(k+1) = f_k (x_k, u_k) #h(1cm) forall k in [0, N-1] \
      $
  ])
  #place(top + right, image(width: 40%, "Images/bipetto.jpg"))
  - Implementation de la dynamique et de ses derivees dans une librairie de control optimal (Crocoddyl)
  - Comparaison des performances de cette modelisation avec celles d'un modele plus simple
  - Ecriture et soumission d'un papier ICRA 2025
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
  #align(center)[=== Continuation des travaux de 1ere annee]
  ==== Reprise du papier ICRA en vue d'une resoumission a IROS 2025
  - Ajout de comparaison
  - Reformulation de certaines parties
  - Mise en avant des limites de la methode
    - Le solveur semble avoir des difficultes pour converger
    - Ceci rend la resolution assez lente et incertaine

  ==== Test de la modelisation sur le robot réel (avec Virgile Batto)
  - Calcul d'une trajectoire de squat pour une jambe du Bipetto
  - Passage sur le robot réel en suivi de trajectoire
  // Ajouter les derniers travaux sur les chaines fermees: Fin des travaux de 1ere annee sur le papier IROS, fin des travaux avec Victor sur les modeles d'actionnement et papier ICRA, mention du passage sur le robot de Virgile.
]

#content_slide(title: "Dynamique en chaîne fermée")[
  #align(center)[=== Modele d'actionnement]
  #block(width: 70%, height: auto, [
    ==== Une alternative moins complexe
    - Modelisation des actionnements non-lineaires dans les robots avec une architecture serie-parallele
    - Utilisation du modele serie du robot (chaine fermees negligees)
      $ x = [q_s, dot(q)_s] $
  ])
  #only("-2")[
    #place(top + right, dx: 0%, dy: 0%, image(width: 20%, "Images/battobot_leg_side.png"))
  ]
  #only(2)[
    #place(top + right, dx: 0%, dy: 0%, image(width: 20%, "Images/battobot_leg_side_serial.png"))
  ]
  #only("3-")[
    #block(width: 70%, height: auto, [
      - Expression des couples aux articulations a travers l'actionnement
        $
          & dot(q)_m = J_a (q_s) dot(q)_s                 \
          & tau_s = J_a (q_s)^(T) tau_m = J_a (q_s)^(T) u
        $
    ])
    #place(top + right, dx: -5%, dy: 0%, image(width: 20%, "Images/4bar_bipetto.png"))
    #place(top + right, dx: -2%, dy: 50%, image(width: 25%, "Images/4bar.png"))
  ]
  #only("4-")[
    - Expression des derivees de l'actionnement $ (d J_A)/(d q_s) $
  ]
  #only("5-")[
    - Application en MPC et en Apprentissage par Renforcement
  ]
]

#content_slide(title: "Optimisation des séquences de contact")[
  #align(center)[
    #text(size: big, weight: "bold")[
      #underline[=== Problématique]
    ]
  ]
  $
    & min_(U in cal(U), X in cal(X)) && sum_(k = 0)^(N-1) l(x_k, u_k; k) + V_f (x_N)          \
    & s.t.                           && x_0 = x(t_0)                                          \
    &                                && x_(k+1) = f_k (x_k, u_k) #h(1cm) forall k in [0, N-1] \
  $
  Jusqu'a maintenant, les instants de contacts etaient fixes
  - Complexifie l'ecriture des problemes
  - Limites les applications
  - Rend le passage au reel plus complexe
  #only("2-")[
    On souhaiterais optimiser directement les instants de contact
    - Utiliser une dynamique unique
    - Obtenir une derivee de la dynamique
  ]
  #only("3-")[
    #place(bottom + right, dx: 8%, dy: -5%, figure(
      image(width: 35%, "Images/signorini.png"),
      caption: [Signorini condition],
    ))
  ]
  #only("4-")[
    #align(center)[
      #text(size: big, weight: "bold", fill: red)[
        La dérivée n'existe pas en tout point
      ]
    ]
  ]
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
