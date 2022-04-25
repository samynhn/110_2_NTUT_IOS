//
//  ViewController.swift
//  SimpleCaculator
//
//  Created by kao on 2022/3/21.
//

import UIKit

class ViewController: UIViewController {

    lazy var model:Model = Model(numOfButton: 19)
    
    var buttonArray : Array<Button> = [Button]()
    var caculationArray : Array<String> = [String]()
    var fItem = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var Caculation: UILabel!
    @IBOutlet weak var Answer: UILabel!
    
    @IBAction func clean(_ sender: UIButton) {
        if(model.ClearState(clearText: sender.currentTitle!)==1){//  c 且 last==nonNum
            sender.setTitle("AC", for: UIControl.State.normal)
            sender.backgroundColor =  #colorLiteral(red: 0.9371655583, green: 0.2847693861, blue: 0.5117737055, alpha: 1);
        }else{
            sender.setTitle("C", for: UIControl.State.normal)
            sender.backgroundColor =  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1);
        }
        
        updateView()
        //##########
//        Caculation.text = "";
//        Answer.text = "";
//        if(Caculation.text == ""){
//            sender.setTitle("AC", for: UIControl.State.normal);
//            sender.backgroundColor =  #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1);
//        }
//        if(model.isNumber(text: model.caculationArray.last!)){
//            //last is num
//            model.caculationArray.removeLast()
//        }else{
//            //last not num
//            sender.setTitle("AC", for: UIControl.State.normal);
//            sender.backgroundColor =  #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1);

//        }
        
    }
//    func ClearState(_ sender: UIButton){
//        if(!model.isNumber(text: model.caculationArray.last!)){
//            //last element is nonNum
//            sender.setTitle("AC", for: UIControl.State.normal);
//        }else{
//            sender.setTitle("C", for: UIControl.State.normal);
//        }
//    }
    
    @IBAction func buttonclick(_ sender: UIButton) {
        model.CaculationShowText(currentTitle: sender.currentTitle!)
        updateView()
        //
//        Caculation.text = Caculation.text! + sender.currentTitle!
        
        sender.backgroundColor =  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1);
    }
    
    
    @IBAction func execute(_ sender: Any) {
        let _caculation = Caculation.text!
        let expression = NSExpression(format: _caculation)
        let value = expression.expressionValue(with: nil, context: nil) as?Int
        Answer.text = value?.description
    }
    
    func updateView(){
       
        Caculation.text = model.caculationText
    }
    
//    func CaculationShowText(_ sender: UIButton){
//        fItem = ""
//        if(caculationArray.count==0){
//            //初始狀態直接append
//            caculationArray.append(sender.currentTitle!)
//            for item in caculationArray{
//                fItem += item;
//            }
//            Caculation.text! = fItem;
//        }else{
//            //非初始狀態
//            if(!model.isNumber(text: caculationArray.last!) && !model.isNumber(text: sender.currentTitle!) ){ //
//                //若前兩個元素皆不是num 則指替換最後項元素
//                let _lastElement = caculationArray.last!
//                if let lastElement = caculationArray.firstIndex(of: _lastElement) {
//                    caculationArray[lastElement] = sender.currentTitle!
//                }
//                // 更新last值
//                for item in caculationArray{
//                    fItem += item;
//                }
//                Caculation.text! = fItem;
//
//            }else{
//                caculationArray.append(sender.currentTitle!)
//                for item in caculationArray{
//                    fItem += item;
//                }
//                Caculation.text! = fItem;
//            }
//        }
//
//
//    }
}


/*
var line = Caculation.text!
var result = 0
var numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
var operation = ["+", "-", "*", "/"]
var num: [Int]
var op: []
for _line in line{
    if numbers.contain(_line){
     num
    }
}
*/
