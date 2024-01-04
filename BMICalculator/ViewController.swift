//
//  ViewController.swift
//  BMICalculator
//
//  Created by Greed on 1/3/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    
    @IBOutlet var mainImageView: UIImageView!
    
    @IBOutlet var heightMaskingView: UIView!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var heightTextField: UITextField!
    
    @IBOutlet var weightMaskingView: UIView!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var seePasswordButton: UIButton!
    
    @IBOutlet var randomBMIButton: UIButton!
    @IBOutlet var calculateButton: UIButton!
    
    var isSecretMode: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabels()
        setHeightTextField()
        setWeightTextField()
        setRandomButton()
        setCalculateButton()
    }
    
    
    @IBAction func calculateRandomBMI(_ sender: UIButton) {
        
        let randomDoubleHeight = Int.random(in: 120...210)
        heightTextField.text = "\(randomDoubleHeight)"
        
        let randomDoubleWeidht = Int.random(in: 40...120)
        weightTextField.text = "\(randomDoubleWeidht)"
        
        calculateButtonClicked(calculateButton)
    }
    
    @IBAction func calculateButtonClicked(_ sender: UIButton) {
        
        guard let height = heightTextField.text, let customHeight = Double(height), customHeight >= 120, customHeight <= 210 else {
            showError()
            print("height값이 올바르지 않습니다.")
            return
        }
        
        guard let weight = weightTextField.text, let customWeight = Double(weight), customWeight >= 40, customWeight <= 120 else {
            showError()
            print("weight값이 올바르지 않습니다.")
            return
        }
    
        showResult(result: calculateBMI(height: customHeight, weight: customWeight))
    }
    
    @IBAction func keyboardDismiss(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func seePasswordClicked(_ sender: UIButton) {
        
        isSecretMode.toggle()
        if isSecretMode {
//            seePasswordButton.backgroundImage(for: .normal) = UIImage(systemName: "eye")
            seePasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
            weightTextField.isSecureTextEntry = true
        } else {
            seePasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            weightTextField.isSecureTextEntry = false
        }
    }
    
    func setLabels() {
        let titleSize = CGFloat(20)
        let labelSize = CGFloat(12)
        
        titleLabel.text = "BMI Calculator"
        titleLabel.font = .boldSystemFont(ofSize: titleSize)
     
        descLabel.text = "당신의 BMI 지수를\n알려드릴게요."
        descLabel.numberOfLines = 2
        descLabel.font = .systemFont(ofSize: labelSize)
        
        heightLabel.text = "키가 어떻게 되시나요?(단위: cm)"
        heightLabel.font = .systemFont(ofSize: labelSize)
        weightLabel.text = "몸무게는 어떻게 되시나요?"
        weightLabel.font = .systemFont(ofSize: labelSize)
        
    }
    
    func setHeightTextField() {
        
        heightMaskingView.layer.cornerRadius = 15
        heightMaskingView.layer.borderColor = UIColor.systemGray.cgColor
        heightMaskingView.layer.borderWidth = 2
        heightMaskingView.layer.zPosition = 0
        heightTextField.borderStyle = .none
        heightTextField.layer.cornerRadius = 20
        heightTextField.keyboardType = .numberPad
        heightTextField.layer.zPosition = 1
        
    }
    
    func setWeightTextField() {
        
        weightMaskingView.layer.cornerRadius = 15
        weightMaskingView.layer.borderColor = UIColor.systemGray.cgColor
        weightMaskingView.layer.borderWidth = 2
        weightMaskingView.layer.zPosition = 0
        weightTextField.borderStyle = .none
        weightTextField.isSecureTextEntry = true
        weightTextField.layer.zPosition = 1
        weightTextField.keyboardType = .numberPad
        
    }
    
    func setRandomButton() {
        
        randomBMIButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomBMIButton.setTitleColor(.red, for: .normal)
        randomBMIButton.titleLabel?.font = .systemFont(ofSize: 10)

    }
    
    func setCalculateButton() {
        
        calculateButton.setTitle("결과 확인", for: .normal)
        calculateButton.setTitleColor(.white, for: .normal)
        calculateButton.backgroundColor = .purple
        calculateButton.layer.cornerRadius = 10
        
    }

    func calculateBMI(height: Double, weight: Double) -> Double {
        
        let cmHeight = height / 100
        let result = weight / pow(cmHeight, 2)
        return result
    }
    
    func BMIDivision(result:Double) -> String {
        
        var division: String
        
        switch result {
        case 0...18.5:
            division = "저체중"
        case 18.5...22.9:
            division = "정상"
        case 22.9...24.9:
            division = "위험체중"
        case 24.9...29.9:
            division = "비만"
        case 29.9...50:
            division = "고도비만"
        default:
            division = "범위 초과"
        }
        
        return division
    }
    
    func showResult(result: Double) {
        
        let division = BMIDivision(result: result)
        let alert = UIAlertController(title: "결과", message: "당신의 BMI 지수는 : \(result.rounded())입니다. \n당신은 \(division)입니다", preferredStyle: .alert)

        let cofirmButton = UIAlertAction(title: "확인", style: .default)

        alert.addAction(cofirmButton)
        
        present(alert, animated: true)
    }
    
    func showError() {
        
        let alert = UIAlertController(title: "경고", message: "키와 몸무게에 적절한 숫자만 입력해주세요!", preferredStyle: .alert)

        let cofirmButton = UIAlertAction(title: "확인", style: .default)

        alert.addAction(cofirmButton)
        
        present(alert, animated: true)
    }

}
