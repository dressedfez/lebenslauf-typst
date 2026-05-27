// cv-template.typ
// Zweispaltiges Lebenslauf-Template mit stabiler Sidebar auf der ersten Seite.

#let cv-accent = rgb("#26428b")
#let cv-text = rgb("#222222")
#let cv-muted = rgb("#a7aba9")
#let cv-line = rgb("#cfcfcf")
#let cv-light = rgb("#e8e8e8")
#let cv-background = rgb("#ffffff")
#let cv-brand-icons-enabled = state("cv-brand-icons-enabled", false)

#let cv-page(body) = {
  set page(
    paper: "a4",
    margin: (x: 1.0cm, y: 0.8cm),
    fill: cv-background,
  )

  set text(
    font: "New Computer Modern",
    size: 8.8pt,
    fill: cv-text,
  )

  show heading: it => block[
    #set text(size: 10.7pt, weight: "semibold", tracking: 0pt)
    #upper(it.body)
  ]

  body
}

#let cv-rule(width: 100%) = line(length: width, stroke: 0.5pt + cv-line)

#let cv-section(title) = [
  #v(0.2em)
  #heading[#title]
  #v(0.18em)
  #cv-rule()
  #v(0.46em)
]

#let cv-dots(filled: 4, total: 5) = {
  let dot-size = 4.3pt
  let gap = 0.18em

  box(width: 1.25cm)[
    #grid(
      columns: (auto,) * total,
      column-gutter: gap,
      ..range(total).map(i => circle(
        radius: dot-size / 2,
        fill: if i < filled { cv-text } else { cv-light },
      )),
    )
  ]
}

#let cv-rating-row(label, filled, total: 5) = [
  #grid(
    columns: (1fr, auto),
    gutter: 0.3em,
    align: (left, center),
    [#label],
    [#align(right)[#cv-dots(filled: filled, total: total)]],
  )
  #v(0.12em)
]

#let cv-fa-icon(name, size: 0.82em) = box(width: 1em, height: 1em)[
  #align(center + horizon)[
    #image("assets/fa/" + name + ".svg", width: size)
  ]
]

#let cv-icon(name) = context {
  let suffix = if cv-brand-icons-enabled.get() { "-brand" } else { "" }

  if name == "pin" {
    cv-fa-icon("location-dot")
  } else if name == "home" {
    cv-fa-icon("house")
  } else if name == "mail" {
    cv-fa-icon("envelope")
  } else if name == "phone" {
    cv-fa-icon("phone")
  } else if name == "github" {
    cv-fa-icon("github")
  } else if name == "linkedin" {
    cv-fa-icon("linkedin" + suffix)
  } else if name == "orcid" {
    cv-fa-icon("orcid" + suffix)
  } else if name == "web" {
    cv-fa-icon("globe")
  } else {
    text(size: 8pt)[•]
  }
}

#let cv-sidebar-item(symbol, body) = [
  #grid(
    columns: (1.05em, 0.35em, 1fr),
    gutter: 0.22em,
    align: (left, horizon),
    [#symbol],
    [#line(length: 0.9em, angle: 90deg, stroke: 0.35pt + cv-line)],
    [#body],
  )
  #v(0.24em)
]

#let cv-contact-row(kind, body) = [
  #cv-sidebar-item(cv-icon(kind), body)
]

#let cv-subgroup(title) = [
  #set text(fill: cv-accent, weight: "semibold", tracking: 0pt, size: 8.4pt)
  #upper(title)
  #v(0.2em)
]

#let cv-entry(title, org, dates, bullets: ()) = [
  #grid(
    columns: (1fr, 2.6cm),
    gutter: 0.42em,
    align: (left, top),
    [
      #set text(size: 9.7pt, weight: "semibold", fill: cv-accent, tracking: 0pt)
      #upper(title)

      #v(0.12em)
      #set text(size: 9pt, style: "normal", weight: "semibold", fill: cv-text)
      #org

      #v(0.22em)
      #set text(size: 8.7pt, style: "normal", weight: "regular", fill: cv-text)
      #for item in bullets [
        - #item
        #v(0.06em)
      ]
    ],
    [
      #align(right)[
        #set text(size: 8.8pt, style: "normal", weight: "semibold", fill: cv-text)
        #dates
      ]
    ],
  )
  #v(0.3em)
]

#let cv-entry-from-dict(entry) = {
  cv-entry(
    entry.at("title"),
    entry.at("org"),
    entry.at("dates"),
    bullets: entry.at("bullets", default: ()),
  )
}

#let cv-project-url-icon(url) = {
  let icon = if url.contains("github.com") {
    "github"
  } else if url.contains("gitlab.com") {
    "gitlab"
  } else if url.contains("linkedin.com") {
    "linkedin"
  } else {
    "globe"
  }

  link(url)[#cv-fa-icon(icon, size: 0.9em)]
}

#let cv-project-url-label(url, max-length: 50) = [
  #if url.len() <= max-length [
    #v(0.1em)
    #set text(size: 8.6pt, fill: cv-text, weight: "semibold")
    #link(url)[#url]
  ]
]

#let cv-tech-list(tech) = {
  if tech == () {
    none
  } else {
    tech.join(", ")
  }
}

#let cv-project(title, description, url: none, type: none, tech: (), artifacts: (), url-max-length: 50) = [
  #grid(
    columns: (1fr, auto),
    gutter: 0.42em,
    align: (left, top),
    [
      #set text(size: 9.7pt, weight: "semibold", fill: cv-accent, tracking: 0pt)
      #upper(title)

      #if url != none [
        #cv-project-url-label(url, max-length: url-max-length)
      ]

      #v(0.18em)
      #set text(size: 8.7pt, weight: "regular", fill: cv-text)
      #description

      #if tech != () [
        #v(0.12em)
        #set text(size: 8.5pt, weight: "semibold", fill: cv-text)
        #cv-tech-list(tech)
      ]

      #if artifacts != () [
        #v(0.14em)
        #set text(size: 8.5pt, fill: cv-text)
        #for artifact in artifacts [
          - #artifact
          #v(0.04em)
        ]
      ]
    ],
    [
      #if url != none [
        #align(right)[#cv-project-url-icon(url)]
      ] else if type != none [
        #align(right)[
          #set text(size: 8.8pt, weight: "semibold", fill: cv-text)
          #type
        ]
      ]
    ],
  )
  #v(0.3em)
]

#let cv-project-from-dict(project) = {
  cv-project(
    project.at("title"),
    project.at("description"),
    url: project.at("url", default: none),
    type: project.at("type", default: none),
    tech: project.at("tech", default: ()),
    artifacts: project.at("artifacts", default: ()),
    url-max-length: project.at("url-max-length", default: 50),
  )
}

#let cv-rating-group(title, items) = [
  #cv-subgroup(title)
  #for item in items [
    #cv-rating-row(item.at("label"), item.at("value"), total: item.at("total", default: 5))
  ]
]

#let cv-sidebar-section(title, body) = [
  #cv-section(title)
  #body
  #v(0.1cm)
]

#let cv-circle-image(path, size: 4.3cm, background: cv-background) = [
  #box(width: size, height: size, clip: true, inset: 0pt, radius: 50%, fill: background)[
    #image(path, width: size, height: size, fit: "cover")
  ]
]

#let cv-profile(name, role, image-path: none, image-size: 4.3cm) = [
  #align(center)[
    #set text(size: 15pt, weight: "bold", tracking: 0pt, fill: cv-text)
    #upper(name)

    #v(0.14em)
    #set text(size: 10pt, style: "italic", fill: cv-muted)
    #role
  ]

  #if image-path != none [
    #v(0.7cm)
    #align(center)[
      #cv-circle-image(image-path, size: image-size)
    ]
  ]
]

#let cv-layout-first-page(
  sidebar-width: 28%,
  sidebar: [],
  main: [],
  title: none,
) = {
  cv-page[
    #if title != none [
      #align(center)[
        #set text(size: 11pt, weight: "semibold", fill: cv-text)
        #upper(title)
      ]
      #v(0.45cm)
    ]
    #grid(
      columns: (sidebar-width, 1fr),
      column-gutter: 1.0cm,
      align: (left, top),
      [#sidebar],
      [#main],
    )
  ]
}

#let cv-doc(
  sidebar-width: 28%,
  profile: none,
  personal: none,
  languages: none,
  knowledge: none,
  main: [],
  title: none,
  brand-icons: false,
) = {
  cv-brand-icons-enabled.update(brand-icons)

  cv-layout-first-page(
    sidebar-width: sidebar-width,
    title: title,
    sidebar: [
      #v(0.42cm)
      #if profile != none [#profile]
      #v(0.52cm)
      #if personal != none [#cv-sidebar-section([Persönliche Daten], personal)]
      #if languages != none [#cv-sidebar-section([Sprachen], languages)]
      #if knowledge != none [#cv-sidebar-section([Kenntnisse], knowledge)]
    ],
    main: [
      #v(0.42cm)
      #main
    ],
  )
}
