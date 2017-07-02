//
//  GameVC.swift
//  FactCheck
//
//  Created by Oisín Byrne on 21/04/2017.
//  Copyright © 2017 Computer Science. All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var totalQuestions: UILabel!
    @IBOutlet weak var timeRemaining: UILabel!
    
    var score = 0
    var time = 5
    var questionCount = 1
    var questions = [Question]()
    struct Question {
        var question: String
        var answer: Bool
        init(_ question: String, _ answer: Bool) {
            self.question = question
            self.answer = answer
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let requestURL = URL(string: "http://google.ie")
        let request = URLRequest(url: requestURL!)
        webView.loadRequest(request)
        webView.isHidden = true
        
        questions = []
        setQuestions()
        questionText.text = questions.first?.question
        
        questionNumber.text = "\(questionCount)"
        totalQuestions.text = "/\(questions.count)"
        
        timeRemaining.text = "\(time) seconds"
        var _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
        searchButton.isHidden = true
        webView.isHidden = false
        time = 61
        updateTimer()
    }
    
    @IBAction func falsePressed(_ sender: Any) {
        nextQuestion(false, timeOut: false)
    }
    
    @IBAction func truePressed(_ sender: Any) {
        nextQuestion(true, timeOut: false)
    }
    
    private func nextQuestion(_ truth: Bool, timeOut: Bool) {
        let currentQuestion = questions.removeFirst()
        
        if(!timeOut) {
            //If the user pressed the search button
            if(searchButton.isHidden) {
                //Answer is correct
                if(currentQuestion.answer == truth) {
                    score += 7
                }
                else {
                    score += 3
                }
            }
            else {
                //Answer is correct
                if(currentQuestion.answer == truth) {
                    score += 10
                }
            }
        }
        
        if(questions.isEmpty) {
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpID") as! PopUpVC
            popOverVC.passedScore = score
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
        }
        else {
            time = 6
            updateTimer()
            searchButton.isHidden = false
            webView.isHidden = true
            questionText.text = questions.first?.question
            questionCount += 1
            questionNumber.text = "\(questionCount)"
        }
    }
    
    private func setQuestions() {
        self.questions = [
            Question("US President Gerald Ford survived two assassination attempts in the same month", true),
            Question("A blue whale can weigh upwards of 400 tons", false),
            Question("Kim Jong-un has announced a military partnership with Syria", true),
            Question("Cherophobia is the fear of fun", true),
            Question("The next iPhone will feature two headphones ports", false),
            Question("The planned National Maternity Hospital will cost €300 million", true),
            Question("\"an bhfuil cead agam dul go dtí an leithreas\" is the latin for \"You're eyes look beautiful in the moonlight\"", true),
            Question("A Filly is a female horse under the age of 5", true),
            Question("HBO have produced more tv series than AMC", false),
            Question("The national colour of Ireland is Blue", true),
        ]
    }
    
    func updateTimer() {
        if(time > 0) {
            time = time - 1
        }
        else {
            nextQuestion(true, timeOut: true)
            time = 5
        }
        timeRemaining.text = "\(time)"
    }
}
