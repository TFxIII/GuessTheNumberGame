//
//  ViewController.swift
//  QuessTheNumberGame
//
//  Created by Trynus Fedir on 02.04.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!
    
    var targetValue: Int = 0
    var score = 0
    var round = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImagePresssed = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImagePresssed, for: .highlighted)
        
        let insest = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let resizableLeft = trackLeftImage?.resizableImage(withCapInsets: insest)
        slider.setMinimumTrackImage(resizableLeft, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")
        let resizableRight = trackRightImage?.resizableImage(withCapInsets: insest)
        slider.setMaximumTrackImage(resizableRight, for: .normal)
    }
    
    @IBAction func restart() {
        score = 0
        round = 1
        newRound()
    }
    
    func newRound() {
        targetValue = Int.random(in: 1...100)
        targetLabel.text = "\(targetValue)"
        roundLabel.text = "\(round)"
        scoreLabel.text = "\(score)"
    }
    
    @IBAction func showAlert() {
        
        let currentValue = lroundf(slider.value)
        let difference: Int = abs(currentValue - targetValue)
        var currentScore: Int = 100 - difference
        
        let title: String
        
        if difference == 0 {
            title = "Відмінно!"
            currentScore += 100
        } else if difference < 5 {
            title = "Майже в ціль!"
            if difference < 3 {
                currentScore += 50
            }
        } else if difference < 20 {
            title = "Непогано!"
        } else {
            title = "Мимо 🥴"
        }
        
        let message = "Ваш результат: \(currentValue)\nНабрані очки: \(currentScore)"
        let alertWindow = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default) { _ in self.newRound() }
        
        alertWindow.addAction(action)
        present(alertWindow, animated: true)
        
        score += currentScore
        round += 1
    }
    
}
