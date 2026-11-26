#set document(title: "有机官能团反应速查")
#set page("a5", flipped: true, margin: (x: 6mm, y: 5mm))
#set text(font: ("Libertinus Serif", "PingFang SC"), size: 8.8pt, lang: "zh")
#set par(leading: 1pt)

#let arrow(condition, bottom: none, reversible: false) = {
  let w = if condition.len() > 4 { 34pt } else { 28pt }
  box(width: w, height: 18pt, baseline: 6pt)[
    #place(top + center, dy: 0pt, text(size: 6pt, condition))
    #place(left + top, dy: 8pt, line(end: (w, 0pt), stroke: 0.45pt))
    #place(right + top, dy: 6.3pt, line(start: (0pt, 0pt), end: (3.5pt, 1.7pt), stroke: 0.45pt))
    #if reversible {
      place(left + top, dy: 10.2pt, line(end: (w, 0pt), stroke: 0.45pt))
      place(left + top, dy: 10.2pt, line(end: (3.5pt, 1.7pt), stroke: 0.45pt))
    } else {
      place(right + top, dy: 8pt, line(start: (0pt, 1.7pt), end: (3.5pt, 0pt), stroke: 0.45pt))
    }
    #if bottom != none { place(top + center, dy: 11.4pt, text(size: 6pt, bottom)) }
  ]
}

#let group(title, ..rows) = block(above: 0pt, below: 5pt, breakable: false)[
  #block(below: 2pt, above: 0pt, text(size: 10pt, weight: "bold", title))
  #grid(columns: (11mm, 1fr), align: left + horizon, column-gutter: 2pt, row-gutter: 2.4pt,
    ..rows.pos().flatten().enumerate().map(((i, body)) => {
      if calc.rem(i, 2) == 0 { text(size: 7.6pt, body) } else { body }
    })
  )
]

#block(below: 5pt, text(size: 14pt, weight: "bold")[有机官能团反应速查])
#grid(columns: (91mm, 1fr), column-gutter: 4mm, [
  #group([1　碳碳双键 / 三键　C=C、C≡C],
    ([加成], [CH₂=CH₂ + H₂ #arrow("催化剂", bottom: "△") CH₃CH₃]),
    ([], [CH₂=CH₂ + H₂O #arrow("催化剂", bottom: "加热加压") CH₃CH₂OH]),
    ([], [CH₂=CH₂ + Br₂ → CH₂BrCH₂Br]),
    ([], [CH≡CH + HCl #arrow("催化剂", bottom: "△") CH₂=CHCl]),
    ([加聚], [#emph[n] CH₂=CH₂ #arrow("一定条件") \[–CH₂–CH₂–\]#sub[n]]),
    ([], [#emph[n] CH≡CH #arrow("一定条件") \[–CH=CH–\]#sub[n]]),
    ([氧化], [使酸性 KMnO₄ 溶液褪色]),
  )
  #group([2　碳卤键　–X],
    ([水解], [CH₃CH₂Br + NaOH #arrow("水溶液", bottom: "△") CH₃CH₂OH + NaBr]),
    ([消去], [CH₃CH₂Br + NaOH #arrow("醇溶液", bottom: "△") CH₂=CH₂↑ + NaBr + H₂O]),
  )
  #group([3　醇羟基　–OH],
    ([与钠], [2CH₃CH₂OH + 2Na → 2CH₃CH₂ONa + H₂↑]),
    ([氧化], [2CH₃CH₂OH + O₂ #arrow("Cu", bottom: "△") 2CH₃CHO + 2H₂O]),
    ([消去], [CH₃CH₂OH #arrow("浓硫酸", bottom: "170 ℃") CH₂=CH₂↑ + H₂O]),
    ([成醚], [2CH₃CH₂OH #arrow("浓硫酸", bottom: "140 ℃") CH₃CH₂OCH₂CH₃ + H₂O]),
    ([酯化], [CH₃CH₂OH + CH₃COOH #arrow("浓硫酸", bottom: "△", reversible: true) CH₃COOCH₂CH₃ + H₂O]),
    ([与 HX], [CH₃CH₂OH + HBr #arrow("△") CH₃CH₂Br + H₂O]),
  )
], [
  #group([4　酚羟基　Ar–OH],
    ([弱酸性], [C₆H₅OH + NaOH → C₆H₅ONa + H₂O]),
    ([], [C₆H₅OH + Na₂CO₃ → C₆H₅ONa + NaHCO₃]),
    ([], [C₆H₅ONa + CO₂ + H₂O → C₆H₅OH + NaHCO₃]),
    ([取代], [C₆H₅OH + 3Br₂（浓溴水）→ 2,4,6-Br₃C₆H₂OH↓ + 3HBr]),
    ([显色], [与 FeCl₃ 溶液显紫色]),
  )
  #group([5　醛基　–CHO],
    ([还原], [CH₃CHO + H₂ #arrow("催化剂", bottom: "△") CH₃CH₂OH]),
    ([氧化], [CH₃CHO + 2Cu(OH)₂ + NaOH #arrow("△") CH₃COONa + Cu₂O↓ + 3H₂O]),
    ([], [CH₃CHO + 2\[Ag(NH₃)₂\]OH #arrow("△") CH₃COONH₄ + 3NH₃ + 2Ag↓ + H₂O]),
    ([], [2CH₃CHO + O₂ #arrow("催化剂", bottom: "△") 2CH₃COOH]),
    ([], [使酸性 KMnO₄ 溶液褪色]),
  )
  #group([6　酮羰基　–C(=O)–],
    ([还原], [CH₃COCH₃ + H₂ #arrow("催化剂", bottom: "△") CH₃CH(OH)CH₃]),
  )
  #group([7　羧基　–COOH],
    ([酸性], [CH₃COOH + NaOH → CH₃COONa + H₂O]),
    ([酯化], [CH₃COOH + CH₃CH₂OH #arrow("浓硫酸", bottom: "△", reversible: true) CH₃COOCH₂CH₃ + H₂O]),
  )
  #group([8　酯基 / 酰胺基　–COO–、–CONH–],
    ([酯水解], [CH₃COOCH₂CH₃ + H₂O #arrow("稀硫酸", bottom: "△", reversible: true) CH₃COOH + CH₃CH₂OH]),
    ([], [CH₃COOCH₂CH₃ + NaOH #arrow("△") CH₃COONa + CH₃CH₂OH]),
    ([酰胺水解], [CH₃CONHCH₂CH₃ + H₂O + H⁺ #arrow("△") CH₃COOH + CH₃CH₂NH₃⁺]),
  )
])
