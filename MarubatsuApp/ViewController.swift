//
//  ViewController.swift
//  MarubatsuApp
//
//  Created by USER on 2023/09/02.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    // varだから変数、変数は定義なので上の方に書く
    
    // 表示中の問題番号を格納
    var currentQuestionNum: Int = 0
    
    // 問題
    let questions: [[String: Any]] = [
        [
            "question": "iPhoneアプリを開発する統合環境はZcodeである",
            "answer": false
        ],
        [
            "question": "Xcode画面の右側にはユーティリティーズがある",
            "answer": true
        ],
        [
            "question": "UILabelは文字列を表示する際に利用する",
            "answer": true
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
    }
    // 回答チェックの関数。正解なら次の問題を表示
    func checkAnswer(yourAnswer: Bool) {
        
        let question = questions[currentQuestionNum]
        if let ans = question["answer"] as? Bool {
            if yourAnswer == ans {
                //正解の時の処理
                //currentQuetionNumに1を足して次の問題に進む
                currentQuestionNum += 1
                showAlert(message: "正解！")
            } else {
                // 不正解の時の処理
                showAlert(message: "不正解…")
            }
        } else { //答えがない時
            print("答えが入ってません")
            return
        }
        
        // currentQuestionNumの値が問題数以上だったら最初の問題に戻す
        if currentQuestionNum >= questions.count {
            currentQuestionNum = 0
        }
        
        showQuestion()
    }
    
    
    
    func showQuestion() {
        let question = questions[currentQuestionNum]
        
        /* 上記は以下を取り出している
         [
         "question": "iPhoneアプリを開発する統合環境はZcodeである",
         "answer": false
         ]
         */
        
        if let que = question["question"] as? String {
            questionLabel.text = que
        }
    }
    
    // アラートを表示する関数
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
    
    
    @IBAction func createQuestionButtonTapped(_ sender: UIButton) {
        
        // 問題作成画面に遷移するコードを追加
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil) 
            let createQuestionViewController = storyboard.instantiateViewController(withIdentifier: "CreateQuestionViewController") // 画面IDは適切に変更してください
            navigationController?.pushViewController(createQuestionViewController, animated: true)
        
    }
    
    
    
}

