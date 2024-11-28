//
//  RulesViewModel.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 14/10/24.
//

import Foundation

extension RulesView {
    class RulesViewModel {
        
        let descriptionRules = "I punti associati a ciascuna cacca si otterranno nel seguente modo: il punteggio base verrà calcolato sulla base della località dichiarata, a cui verrà sommato un eventuale bonus dovuto all'evento e infine detratto un malus, nel caso si siano verificate le condizioni qui sotto descritte. \nCiascun evento o luogo non previsto dal regolamento varrà solo 1 punto."
        
        let rules: [Rule] = [Rule(name: "Nottambulo", description: "Ciascuna cacca notturna (ovvero rilasciata dalle 2 alle 6 di mattina) verrà premiata con un punto aggiuntivo", image: "moon.stars.fill", points: 1, ruleType: .events), Rule(name: "Spara Lesto", description: "Il primo concorrente ad inaugurare la gara riceverà un punto aggiuntivo.", image: "hare.fill", points: 1, ruleType: .events), Rule(name: "Timidone", description: "Il concorrente che farà la sua prima cacca l'ultimo giorno di vacanza riceverà quattro punti aggiuntivi.", image: "tortoise.fill", points: 4, ruleType: .events), Rule(name: "Esotico", description: "Il concorrente che verrà eletto con il premio \"Cacca Esotica\" verrà premiato con due punti in più sulla classifica finale.", image: "01.circle.fill", points: 2, ruleType: .locations), Rule(name: "Mile-High-Shit Club", description: "Una cacca rilasciata nel bagno di un grattacielo (valgono solo gli ultimi due piani visitabili) oppure durante un volo riceverà due punti aggiuntivi.", image: "airplane", points: 2, ruleType: .locations), Rule(name: "The Brave", description: "Una cacca rilasciata in natura riceverà tre punti aggiuntivi.", image: "tree.fill", points: 3, ruleType: .locations), Rule(name: "Cacca Che Risate", description: "Il Concorrente che farà cacca in un luogo valutato all'unanimità come \"Piccolo così\" verrà premiato con un punto aggiuntivo. Valgono solo bagni con almeno tre sanitari (es: water, lavandino, doccia).", image: "figure.2", points: 1, ruleType: .locations), Rule(name: "Intasatore di Cesso", description: "La persona che intaserà il cesso riceverà un meno tre punti e tutta la nostra ira.", image: "toilet.fill", points: -3, ruleType: .malus), Rule(name: "Cacatore Seriale", description: "Per più di quattro cacche al giorno si verrà puniti con meno due punti.", image: "hourglass.and.lock", points: -2, ruleType: .malus)]
        
        
        func getMalusRules() -> [Rule] {
            return rules.filter({ $0.ruleType == .malus })
            
        }
        
        func getLocationsRules() -> [Rule] {
            return rules.filter({ $0.ruleType == .locations })
        }
        
        func getEventsRules() -> [Rule] {
            return rules.filter({ $0.ruleType == .events })
        }
        
        func getRule(for name: String) -> Rule? {
            return rules.first(where: { $0.name == name })
        }
        
        func getPoints(for rule: Rule) -> Int? {
            return rules.firstIndex(of: rule)
        }
        
    }
}
