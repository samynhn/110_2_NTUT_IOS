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
                caculationArray.remove(at: caculationArray.firstIndex(of: ".")!)
            }
        }
            
    }
    func CheckOneDot(){
        if(caculationArray.last == "."){
            if(caculationArray.firstIndex(of: ".") != caculationArray.count-1){
                //小數點在之前出現過
                caculationArray.removeLast()
            }
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
     
    func ClearState(clearText : String) -> Int{ // 傳入AC/C
        if(caculationArray.count==0){
            return 0
        }
        if (clearText=="C"){
            if(!isNumber(text: caculationArray.last!)){
                return 1 //  c 且 last==nonNum
            }else{
                caculationArray.removeLast()//  最後一個圍數字時
                Array2String(inputArray: caculationArray)
                return 2
            }
            
        }else{
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
