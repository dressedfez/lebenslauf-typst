#import "@preview/lebenslauf:0.1.0": *

#let contacts = (
  (kind: "pin", body: [Geb. 22.08.1992 in Leipzig]),
  (kind: "home", body: [Ahornweg 18 \
04109 Leipzig]),
  (kind: "mail", body: [mira.beispiel\@email.de]),
  (kind: "phone", body: [+49 171 234 56 78]),
  (kind: "linkedin", body: [linkedin.com/in/mirabeispiel]),
  (kind: "web", body: [mira-beispiel.dev]),
)

#let languages-data = (
  (label: "Deutsch", value: 5),
  (label: "Englisch", value: 4),
  (label: "Französisch", value: 2),
)

#let edv-data = (
  (label: "MS Excel", value: 5),
  (label: "Power BI", value: 4),
  (label: "SAP S/4HANA", value: 3),
  (label: "MS PowerPoint", value: 4),
)

#let domain-data = (
  (label: "Projektkoordination", value: 5),
  (label: "Reporting", value: 4),
  (label: "Stakeholder-Management", value: 4),
)

#let experience = (
  (
    title: "Projektkoordinatorin Operations",
    org: [Nordstadt Services GmbH, Leipzig],
    dates: [04/2021-aktuell],
    bullets: (
      [Koordination bereichsübergreifender Verbesserungsprojekte mit Vertrieb, Service und IT],
      [Aufbau eines monatlichen Kennzahlenberichts für Durchlaufzeiten, Rückfragen und Servicequalität],
      [Begleitung der Einführung eines digitalen Aufgabenboards für 24 Mitarbeitende],
      [Vorbereitung kompakter Entscheidungsvorlagen für die Bereichsleitung],
    ),
  ),
  (
    title: "Teamassistenz Prozessmanagement",
    org: [Hafenblick Logistik KG, Rostock],
    dates: [07/2018-03/2021],
    bullets: (
      [Pflege und Auswertung von Prozesskennzahlen für Lager- und Transportabläufe],
      [Unterstützung der Projektleitung bei Terminplanung, Protokollen und Statusberichten],
      [Organisation von Regelterminen für bis zu sechs Projektteams],
      [Erstellung kurzer Schulungsunterlagen für neue interne Abläufe],
    ),
  ),
  (
    title: "Sachbearbeiterin Kundenservice",
    org: [Mittelpunkt Energie AG, Dresden],
    dates: [09/2015-06/2018],
    bullets: (
      [Bearbeitung schriftlicher Kundenanfragen zu Vertragsdaten und Abrechnungen],
      [Dokumentation wiederkehrender Anliegen zur Weitergabe an Produkt- und Serviceteams],
    ),
  ),
)

#let education = (
  (
    title: "Bachelor of Arts in Business Administration",
    org: [Hochschule Elbtal, Dresden],
    dates: [10/2012-08/2015],
    bullets: (
      [Schwerpunkte: Organisation, Controlling und Informationsmanagement],
      [Praxisprojekt zur Digitalisierung eines internen Serviceprozesses],
    ),
  ),
  (
    title: "Allgemeine Hochschulreife",
    org: [Lessing-Gymnasium, Leipzig],
    dates: [08/2004-07/2012],
    bullets: (
      [Leistungskurse: Mathematik und Englisch],
      [Mitglied der Arbeitsgruppe Studien- und Berufsorientierung],
    ),
  ),
)

// Optional software/project entries. Add items here to render a "Projekte" section.
#let projects = (
  (
    title: "Service-Reporting-Dashboard",
    description: [Fiktives Dashboard zur Auswertung von Bearbeitungszeiten, Rückfragen und Servicequalität in internen Supportprozessen mit filterbaren Monatsansichten.],
    url: "https://github.com/mira-beispiel/service-reporting-dashboard",
    type: [GitHub],
    tech: ("Python", "Pandas", "Streamlit"),
    artifacts: (
      [Interaktiver Prototyp mit Beispieldaten],
      [Dokumentation der wichtigsten Kennzahlen und Filter],
    ),
  ),
)

#show: doc => cv-doc(
  profile: cv-profile(
    "Mira Beispiel",
    [Projektkoordinatorin Operations],
    image-path: "profile.jpg",
    image-size: 4.2cm,
  ),

  personal: [
    #for item in contacts [
      #cv-contact-row(item.kind, item.body)
    ]
  ],

  languages: [
    #for item in languages-data [
      #cv-rating-row(item.label, item.value)
    ]
  ],

  knowledge: [
    #cv-rating-group([IT-Kenntnisse], edv-data)
    #v(0.22cm)
    #cv-rating-group([Fachgebiete], domain-data)
    #v(0.22cm)
    #cv-subgroup([Weitere Kenntnisse])
    Führerschein Klasse B
  ],

  main: [
    #cv-section([Berufserfahrung])

    #for item in experience [
      #cv-entry-from-dict(item)
    ]

    #cv-section([Bildungsweg])

    #for item in education [
      #cv-entry-from-dict(item)
    ]

    #if projects != () [
      #cv-section([Projekte])

      #for item in projects [
        #cv-project-from-dict(item)
      ]
    ]
  ],
)
