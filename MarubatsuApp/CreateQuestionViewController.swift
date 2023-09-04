//
//  CreateQuestionViewController.swift
//  MarubatsuApp
//
//  Created by USER on 2023/09/04.
//

import UIKit

class CreateQuestionViewController: UIViewController {
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerSegmentedControl: UISegmentedControl!
    
    
    var onQuestionCreated: ((String, Bool) -> Void)?
    var onAllQuestionsDeleted: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveQuestionButtonTapped(_ sender: UIButton) {
        
        guard let questionText = questionTextField.text, !questionText.isEmpty else {
            showAlert(message: "問題文を入力してください")
            return
        }
        
        let isCorrectAnswer = answerSegmentedControl.selectedSegmentIndex == 0
        
        onQuestionCreated?(questionText, isCorrectAnswer)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func returnToTopButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func deleteAllQuestionsButton(_ sender: UIButton) {
        showAlert(message: "問題をすべて削除しました")
        onAllQuestionsDeleted?()
    }
}
