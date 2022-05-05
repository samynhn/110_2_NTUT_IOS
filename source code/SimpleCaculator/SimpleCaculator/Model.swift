//
//  Model.swift
//  SimpleCaculator
//
//  Created by 小王子 on 2022/4/25.
//

import Foundation

class Model{
    
    
    var nonNumArray = ["C", "+/-", "%", "/", "*", "-", "+","="]
    var caculationArray : Array<String> = [String]()
    var buttons : Array<Button> = [Button]()
    var caculationText = ""
    var clearFlag = 0 //當nonNum clear 被按第二次 = 1
    
    init(numOfButton: Int){
        for _ in 1...numOfButton{
            let button = Button()
            buttons.append(button)
        }
    }
    
    func isLegal()->Bool{
        if(!isNumber(text: caculationArray.first!)){
            caculationArray.insert("0", at: 0)
            Array2String(inputArray: caculationArray)
        }
        if(!isNumber(text: caculationArray.last!)){
            caculationArray.removeLast()
            Array2String(inputArray: caculationArray)
        }
        return true
    }
    func execute() -> String{
        
        // if "=" button isclicked==true, remove all text in Caculation Label
        if(isLegal()){ // ensure caculation label isLeagal to execute
            let caculation = caculationText
            let expression = NSExpression(format: caculation)
            let value = expression.expressionValue(with: nil, context: nil) as?Double
            var result = Array(value!.description)
            if(result.last=="0" && result[result.count-2]=="."){
                result.removeLast()
                result.removeLast()
            }
            
            caculationText = ""
            caculationArray.removeAll()
            setIsClicked(index: -1)
            
            
            
            return String(result)
        }
        return "ERROR"
    }
    func setType(index : Int){
        let text = buttons[index].text
        
        if(nonNumArray.contains(text!)){
            if(text=="/" || text=="*" || text=="-" || text=="+"){
                buttons[index].type = "opera"
            }else{
                buttons[index].type = "spec"
            }
            
        }else{
            buttons[index].type = "num"
        }
    
    }
    
    func setIsClicked(index : Int){
        for i in buttons.indices{
            buttons[i].isClicked = false
        }
        if(index < 0){
           
        }else{
            buttons[index].isClicked = true
        }
        
    }
    
    
    //###############
    
    func CheckLastZero(){
        if(!isNumber(text: caculationArray.last!)){
            //確保數字已經打完
            if(caculationArray.contains(".")){
                let lastNonNUmString = caculationArray.last
                caculationArray.removeLast()
                //暫時刪除非文字的最後一項
                for _ in 1...caculationArray.count-1{
                    if(caculationArray.last=="0"){
                        caculationArray.removeLast()
                    }
                }
                caculationArray.append(lastNonNUmString!)
            }
        }
    }
    func CheckLastDot(){
        if(!isNumber(text: caculationArray.last!)){
            //確保數字已經打完
            if(caculationArray.contains(".")){
                let lastNonNUmString = caculationArray.last
                caculationArray.removeLast()
                //暫時刪除非文字的最後一項
                if(caculationArray.last=="."){
                    caculationArray.remove(at: caculationArray.firstIndex(of: ".")!)
                }
                caculationArray.append(lastNonNUmString!)
                
            }
        }
            
    }
    func CheckOneDot(){
       
        if(caculationArray.last == "."){
            let lastDotIndex = caculationArray.count-1
            caculationArray.removeLast()
            
            var secLastDotIndex : Int = -1
            if(caculationArray.contains(".")){
                secLastDotIndex = caculationArray.lastIndex(of: ".")!
            }else{
            }
            caculationArray.append(".")
            var lastNonNumIndex : Int = 0
            
            for index in caculationArray.indices{
                if(!isNumber(text: caculationArray[caculationArray.count-1-index])){
                    lastNonNumIndex = caculationArray.count-1-index
                    break
                }else{
                }
            }
            if(lastDotIndex>lastNonNumIndex && secLastDotIndex<lastNonNumIndex){
             // 檢查最後一點 和 倒數第二個點 中間 有符號 => 2.3+2.3
            }else{
                caculationArray.removeLast()
            }
//            if(caculationArray.firstIndex(of: ".") != caculationArray.count-1){
//                //小數點在之前出現過
//                caculationArray.removeLast()
//            }
        }
        
        
    }
    func CheckFirstZero(){
        if(caculationArray[0]=="0" && caculationArray.count>1){
            if(isNumber(text: caculationArray[1]) && (caculationArray[1]) != "."){
                //小數點設定為num一部分 所以要另加條件
                for i in stride(from: 0, to: caculationArray.count-1, by: 1){
                    caculationArray[i] = caculationArray[i+1]
                }
                caculationArray.removeLast()
            }
            
        }
    }

    func Check(){
        CheckOneDot()
        CheckFirstZero()
        CheckLastZero()
        CheckLastDot()
    }
    
    //################
    
    
    func ClearStateIsC(state: String) -> Bool{
        if state=="C"{
            return true
        }else{
            return false
        }
    }
    
    func ClearHighlight(state: Int){
        if(state == 0){ // all isclicked = false
            setIsClicked(index: -1)
        }else{
            for index in buttons.indices {
                if(buttons[index].text == caculationArray.last){
                    setIsClicked(index: index)
                }
            }
        }
    }
    func ClearState(clearText : String) -> Int{ // 傳入AC/C
        if(caculationArray.count==0){
            return 0
        }
        if (clearText=="C"){
            if(!isNumber(text: caculationArray.last!)){
                return 1 //  c 且 last==nonNum
            }else{
                caculationArray.removeLast()//  最後一個為數字時
                ClearHighlight(state: 1)
//                setIsClicked(index: index)
                Array2String(inputArray: caculationArray)
                return 2
            }
            
        }else{
            ClearHighlight(state: 0)
            caculationArray.removeAll()
            Array2String(inputArray: caculationArray)
            return 3
        }
    }
    func isNumber(text : String) -> Bool{
        var flag = 0
        for item in nonNumArray{
            if(text == item){
                flag += 1 // if text is nonNum
            }
        }
        if(flag==0){
            return true
        }else{
            return false
        }
    }
    
    func CaculationShowText(currentTitle: String) {
        caculationText = ""
        if(caculationArray.count==0){
            //初始狀態直接append
            caculationArray.append(currentTitle)
            Check()
            Array2String(inputArray: caculationArray)
//            return caculationText;
        }else{
            //非初始狀態
            if(isNumber(text: caculationArray.last!)==isNumber(text: currentTitle) && isNumber(text: currentTitle)==false){ //
                //若前兩個元素皆不是num 則指替換最後項元素
                caculationArray[caculationArray.count-1] = currentTitle
                Check()
                // 更新last值
                Array2String(inputArray: caculationArray)
//                return caculationText;
                
            }else{
                caculationArray.append(currentTitle)
                Check()
                Array2String(inputArray: caculationArray)
//                return caculationText;
            }
        }
        
    }
    func Array2String(inputArray : [String]){
        caculationText = ""
        for text in inputArray{
            caculationText += text;
        }
    }
    
    
}
