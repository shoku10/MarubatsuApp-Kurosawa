//
//  ViewController.swift
//  MarubatsuApp
//
//  Created by USER on 2023/09/02.
//

import UIKit

struct Question {
    let questionText: String
    let isCorrectAnswer: Bool
}

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    
    var currentQuestionNum: Int = 0
    var questions: [Question] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
    }

    func updateUI() {
        if questions.isEmpty {
            questionLabel.text = "問題がありません。問題を作りましょう！"
        } else {
            let question = questions[currentQuestionNum]
            questionLabel.text = question.questionText
        }
    }

    @IBAction func creationQuetionButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let createQuestionVC = storyboard.instantiateViewController(withIdentifier: "CreateQuestionViewController") as? CreateQuestionViewController {
            createQuestionVC.onQuestionCreated = { [weak self] questionText, isCorrectAnswer in
                let newQuestion = Question(questionText: questionText, isCorrectAnswer: isCorrectAnswer)
                self?.questions.append(newQuestion)
                self?.updateUI()
                self?.dismiss(animated: true, completion: nil)
            }
            createQuestionVC.onAllQuestionsDeleted = { [weak self] in
                self?.questions.removeAll()
                self?.updateUI()
                self?.dismiss(animated: true, completion: nil)
            }
            self.present(createQuestionVC, animated: true, completion: nil)
        }
    }

    func checkAnswer(yourAnswer: Bool) {
        if questions.isEmpty {
            showAlert(message: "問題がありません")
            return
        }

        let question = questions[currentQuestionNum]
        questionLabel.text = question.questionText

        if yourAnswer == question.isCorrectAnswer {
            currentQuestionNum += 1
            showAlert(message: "正解！")
        } else {
            showAlert(message: "不正解…")
        }

        if currentQuestionNum >= questions.count {
            currentQuestionNum = 0
        }

        showQuestion()
    }

    func showQuestion() {
        if questions.isEmpty {
            return
        }

        let question = questions[currentQuestionNum]
        questionLabel.text = question.questionText
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
    
    // funcは関数
    @IBAction func tappedNoButton(_ sender: UIButton) {
        checkAnswer(yourAnswer: false)
    }
    
    
    @IBAction func tappedYesButton(_ sender: UIButton) {
        checkAnswer(yourAnswer: true)
    }
    
}

