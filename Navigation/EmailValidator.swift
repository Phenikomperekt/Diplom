//
//  EmailValidator.swift
//  Navigation
//
//  Created by Evgeny Mastepan on 23.04.2022.
//

import UIKit

class EmailValidator {
    var isValid: Bool = true

    var input: String

    init(input: String) {
        self.input = input
        self.isValid = validator()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private var state: Int = 0
    private var ch: Character = "a"
    private var index: Int = 0
    private var mark: Int = 0
    private var local: String = ""
    private var domainCount: Int = 1


    func validator() -> Bool {
//        print("Вход: ", input)
        while index <= input.count && state != -1 {
//            print("начало:", ch, state, index, input.count)

            if index == input.count {
                ch = "\0"

            } else {
                ch = Array(input)[index]

            }


    switch state {
        case 0:
                if (ch >= "a" && ch <= "z") || (ch >= "A" && ch <= "Z") ||
                   (ch >= "0" && ch <= "9") || ch == "_" || ch == "-" ||
                    ch == "+" {

//                    print("case 0:", ch, state, index)
                    state = 1
                    break
                }// if
                state = -1
                break
        case 1:
                if (ch >= "a" && ch <= "z") || (ch >= "A" && ch <= "Z") ||
                   (ch >= "0" && ch <= "9") || ch == "_" || ch == "-" ||
                    ch == "+" {
                break
                }// if
                if ch == "." {
                    state = 2
                    break
                }//if
                if ch == "@" {
                    local = String(input) + "0" + String(index - mark)
                    mark = index + 1
                    state = 3
                    break
                }
                state = -1
//                print("case 1:", ch, state, index)
                break

        case 2:
                if (ch >= "a" && ch <= "z") || (ch >= "A" && ch <= "Z") ||
                   (ch >= "0" && ch <= "9") || ch == "_" || ch == "-" ||
                    ch == "+" {
                state = 1
                break
                }// if
                state = -1
//                print("case 2:", ch, state, index)
                break

        case 3:
                if (ch >= "a" && ch <= "z") || (ch >= "A" && ch <= "Z") ||
                   (ch >= "0" && ch <= "9") {
                state = 4
                break
                }// if
                state = -1
//                print("case 3:", ch, state, index)
                break

        case 4:
                if (ch >= "a" && ch <= "z") || (ch >= "A" && ch <= "Z") ||
                   (ch >= "0" && ch <= "9") {
                domainCount += 1
                break
                }// if
                if ch == "-" {
                    domainCount += 1
                    state = 5
                    break
                }
                if ch == "." {
//                    print("domain :", domainCount, ch, state, index)
                    state = 6
                    break
                }//if
                state = -1
//                print("case 4:", ch, state, index)
                break

        case 5:
                if (ch >= "a" && ch <= "z") || (ch >= "A" && ch <= "Z") ||
                   (ch >= "0" && ch <= "9") {
                state = 4
                break
                }// if
                if ch == "-" {
                    state = 5
                    break
                }
                state = -1
//                print("case 5:", ch, state, index)
                break

        case 6: break

       default: break
        }// switch

    index += 1
    }// while

        if state != 6 { return false }



        if domainCount < 2 {
//            print("<2 :", domainCount, ch, state, index)
            return false }

        if local.count > 64 {
//            print(" 64:", ch, state, index)
            return false }

        if input.count > 254 {
//            print("254:", ch, state, index)
            return false }

        index = input.count - 1

        while index > 0 {
            ch = Array(input)[index]
//            ch = input[index]
            if ch == "." && ((input.count - index) > 2) {
                return true
            }
            if !(ch >= "a" && ch <= "z" || ch >= "A" && ch <= "Z") {
//                print("final error:", ch, state, index)
                return false
            }
            index -= 1
        }

        return true
    } //Func


}

