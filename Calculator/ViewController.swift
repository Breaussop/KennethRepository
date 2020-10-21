//
//  ViewController.swift
//  Calculator
//
//  Created by Field Employee on 10/20/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var holder : UIView!
    var firstNum = Double( 0)
    var resNum = Double (0)
    var currentOperations :  Operation?
    
    enum Operation {
        case add,subtract, multiply, divide
    }
    
    private var resultLabel:UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica", size: 90)
        return label
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupNumberPad()
    }
    
    private func setupNumberPad(){
        let buttonSize : CGFloat = view.frame.size.width / 4
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-buttonSize, width: buttonSize*2, height: buttonSize))
        zeroButton.tag = 1
        zeroButton.setTitleColor(.black, for: .normal)
        zeroButton.backgroundColor = .white
        zeroButton.setTitle("0", for: .normal)
        holder.addSubview(zeroButton)
        
        let clearButton = UIButton(frame: CGRect(x: buttonSize*CGFloat(2), y: holder.frame.size.height-buttonSize, width: buttonSize, height: buttonSize))
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.backgroundColor = .white
        clearButton.setTitle("C", for: .normal)
        holder.addSubview(clearButton)
        
        
        
        
        for x in 0..<3 {
            let button1 = UIButton(frame: CGRect(x: buttonSize*CGFloat(x), y: holder.frame.size.height-(buttonSize*2), width: buttonSize, height: buttonSize))
            button1.setTitleColor(.black, for: .normal)
            button1.backgroundColor = .white
            button1.setTitle("\(x+1)", for: .normal)
            button1.tag = x + 2
            holder.addSubview(button1)
            button1.addTarget(self, action: #selector(numberPressed(_ : )), for: .touchUpInside)        }
        
        for x in 0..<3 {
            let button2 = UIButton(frame: CGRect(x: buttonSize*CGFloat(x), y: holder.frame.size.height-(buttonSize*3), width: buttonSize, height: buttonSize))
            button2.setTitleColor(.black, for: .normal)
            button2.backgroundColor = .white
            button2.setTitle("\(x+4)", for: .normal)
            button2.tag = x + 5
            holder.addSubview(button2)
            button2.addTarget(self, action: #selector(numberPressed(_ : )), for: .touchUpInside)
        }
        
        for x in 0..<3 {
            let button3 = UIButton(frame: CGRect(x: buttonSize*CGFloat(x), y: holder.frame.size.height-(buttonSize*4), width: buttonSize, height: buttonSize))
            button3.setTitleColor(.black, for: .normal)
            button3.backgroundColor = .white
            button3.setTitle("\(x+7)", for: .normal)
            button3.tag = x + 8
            holder.addSubview(button3)
            button3.addTarget(self, action: #selector(numberPressed(_ : )), for: .touchUpInside)
        }
        
        let buttLabels :[String] = [".","+/-", "%"]
        let buttLabels2 :[String] = ["=","+", "-", "x","/"]
        
        for x in 0..<3 {
            let button4 = UIButton(frame: CGRect(x: buttonSize*CGFloat(x), y: holder.frame.size.height-(buttonSize*5), width: buttonSize, height: buttonSize))
            button4.setTitleColor(.white, for: .normal)
            button4.backgroundColor = .gray
            button4.setTitle("\(buttLabels[x])", for: .normal)
            holder.addSubview(button4)
            button4.addTarget(self, action: #selector(addDecimalPoint(_:)), for: .touchUpInside)
        }
        
        for x in 0..<5 {
            let button5 = UIButton(frame: CGRect(x: buttonSize*3, y: holder.frame.size.height-buttonSize*CGFloat(x+1), width: buttonSize, height: buttonSize))
            button5.setTitleColor(.white, for: .normal)
            button5.backgroundColor = .orange
            button5.setTitle("\(buttLabels2[x])", for: .normal)
            holder.addSubview(button5)
            button5.tag = x + 1
            button5.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
        }
        
        resultLabel.frame = CGRect(x: 20, y: holder.frame.size.height - buttonSize*6, width: view.frame.size.width - 40, height: buttonSize)
        holder.addSubview(resultLabel)
        
        clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
    }
    
    @objc func addDecimalPoint (_ sender: UIButton){
        
        let buttonTitle = sender.title(for: .normal)!
        let text = resultLabel.text!
        
        if buttonTitle == "." {
            resultLabel.text = "\(String(describing: text))\(String(describing: buttonTitle))"
            
        }
        
    }
    
    @objc func clearResult() {
        resultLabel.text = "0"
    }
    
    @objc func numberPressed(_ sender: UIButton) {
        let tag = sender.tag - 1
        if resultLabel.text == "0" {
            resultLabel.text = "\(tag)"
        }
        else if let text = resultLabel.text {
            resultLabel.text = "\(text)\(tag)"
        }
    }
    
    @objc func operationPressed(_ sender: UIButton) {
        let tag = sender.tag
        if let text = resultLabel.text, let value = Double(text), firstNum == 0 {
            firstNum = value
            resultLabel.text = "0"
        }
        
        if tag == 1 {
            if let operation = currentOperations {
                var secondNum = Double(0)
                if let text = resultLabel.text, let value = Double(text) {
                    secondNum = value
                }
                switch operation {
                case .add:
                    let result = firstNum + secondNum
                    resultLabel.text = "\(result)"
                    break
                case .subtract:
                    let result = firstNum - secondNum
                    resultLabel.text = "\(result)"
                    break
                case .multiply:
                    let result = firstNum * secondNum
                    resultLabel.text = "\(result)"
                    break
                case .divide:
                    let result = firstNum / secondNum
                    resultLabel.text = "\(result)"
                    break


                }
            }
        }
        else if tag == 2{
            currentOperations = .add
        }
        else if tag == 3{
            currentOperations = .subtract
        }
        else if tag == 4{
            currentOperations = .multiply
        }
        else if tag == 5 {
            currentOperations = .divide
        }

         
    }
}

