#Requires AutoHotkey <1.1.37
#Include, Ansi.ahk

class console {
    /**
     * Prints string or array to OutputDebug
     * @param   {*} params* - Eg: `console.log("text", 123, [1, 2, 3])`
     * @return  {void}
     */
    log(params*) {
        For _,data in params {
            OutputDebug(data)
        }
    }

    /**
     * Prints to OutputDebug
     * - All parameters: **Bold, Green Text**
     * 
     * @param   {string|integer} params* - Eg: `console.success(1, 2, 3)`
     * @return  {void}
     */
    success(params*) {
        Color := new Ansi()
        For _,string in params {
            if (IsObject(string)) {
                throw Exception("This function requires strings or integers, use `console.log()` instead.")
            }
            OutputDebug, % Color.Wrap(string, "green", "bold")
        }
    }

    /**
     * Prints to OutputDebug
     * - All parameters: **Italic, Yellow Text**
     * 
     * @param   {string|integer} params* - Eg: `console.info(1, 2, 3)`
     * @return  {void}
     */
    info(params*) {
        Color := new Ansi()
        For _,string in params {
            if (IsObject(string)) {
                throw Exception("This function requires strings or integers, use `console.log()` instead.")
            }
            OutputDebug, % Color.Wrap(string, "yellow", "italic")
        }
    }

    /**
     * Accepts multiple params to print to OutputDebug
     * - First parameter: **White Text, Red Blinking Background**
     * - Additional parameters: **Bold, Red Text**
     * 
     * @param   {string|integer} params* - Eg: `console.error("Title", "Content")`
     * @return  {void}
     */
    error(params*) {
        ; Get max length for center padding
        lengths := []
        for _,string in params {
            lengths.Push(StrLen(string))
        }
        maxLength := Round(Max(lengths*) * 10) / 10 + 10

        Color := new Ansi()
        For index, string in params {
            if (IsObject(string)) {
                throw Exception("This function requires strings or integers, use `console.log()` instead.")
            }
            str := PadCenter(string, maxLength)
            OutputDebug, % index < 2 
                ? Color.Wrap(str, "white", "red_background", "blinking")
                : Color.Wrap(str, "red", "bold")
        }

        ; Append new line
        OutputDebug, % ""
    }

    /**
     * Accepts multiple params to print to OutputDebug
     * - First parameter: **Black Text, Yellow Background, Bold**
     * - Additional parameters: **Bold, Yellow Text**
     * 
     * @param   {string|integer} params* - Eg: `console.warn("Title", "Content")`
     * @return  {void}
     */
    warn(params*) {
        ; Get max length for center padding
        lengths := []
        for _,string in params {
            lengths.Push(StrLen(string))
        }
        maxLength := Round(Max(lengths*) * 10) / 10 + 10

        Color := new Ansi()
        For index, string in params {
            if (IsObject(string)) {
                throw Exception("This function requires strings or integers, use `console.log()` instead.")
            }
            str := PadCenter(string, maxLength)
            OutputDebug, % index < 2 
                ? Color.Wrap(str, "black", "yellow_background", "bold")
                : Color.Wrap(str, "yellow", "bold")
        }

        ; Append new line
        OutputDebug, % ""
    }
}

/**
 * OutputDebug wrapping to allow for strings and arrays to be sent to a debugger
 * In addition uses Ansi color coding (tested on Visual Studio Code Debug Console)
 *
 * Written by krizzi @ discord
 * Date: 30.09.2023
 * Modified: 27.06.2024
 * 
 * @param   {string|integer|array}  content
 * @param   {bool?}                 print   primarily used by this function to control when to construct the string and when to print the constructed string
 * @param   {integer?}              indent  primarily used to control array indentations during construction of the string
 * @return  {string}                string  output of the constructed string
 */
OutputDebug(content, print := true, indent := 0) {
    static Color := new Ansi()

    ; Print when receiving string
    If (!IsObject(content) && print) {
        OutputDebug, % content
        return
    }

    ; Object / Array string construction
    index := 0, string := ""
    For key, value in content {
        index++
        string .= (string ? "`n" : (print ? Color.Wrap("array:" content.Count(), "white") " [`n" : "")) . (!print ? StrRepeat("    ", indent) : "") . "    " Color.Wrap(key, "blue") " => " (IsObject(value) ? Color.Wrap("array:" value.Count(), "white") " [`n" OutputDebug(value, 0, indent + 1) "`n"  (!print ? StrRepeat("    ", indent) : "") "    ]" (Content.Count() > Index ? ",":"") : type(value) ? Color.Wrap(value, "cyan") (Content.Count() > Index ? ",":"") : """" Color.Wrap(StrReplace(value, "`n", " - "), "rgb", 175, 175, 175) """" (Content.Count() > Index ? ",":""))
    }

    If (print) {
        string .= "`n]"
        OutputDebug, % string
    }

    return string
}

PadCenter(string, length, cornerChar := "") {
    ; Calculate the total padding needed
    totalPadding := length - StrLen(string) - (StrLen(cornerChar) * 2)
    if (totalPadding <= 0) {
        return string
    }
    
    ; Calculate padding for the left and right sides
    leftPadding := Floor(totalPadding / 2)
    rightPadding := Ceil(totalPadding / 2)
    
    ; Create the padded string
    paddedString := Format("{1:" leftPadding "}", "") . string . Format("{1:-" rightPadding "}", "")
    
    return cornerChar . paddedString . cornerChar
}

StrRepeat(string, count) {
    str := ""
    Loop, % count {
        str .= string
    }
    return str ? str : string
}

/**
 * Check if variable is given type
 * 
 * @param   {variable}  variable
 * @param   {string?}   type: ["integer"|"float"|"number"|"digit"|"xdigit"|"alpha"|"upper"|"lower"|"alnum"|"space"|"time"]
 * @return  {boolean}
 */
type(variable, type := "integer") {
    If type not in integer,float,number,digit,xdigit,alpha,upper,lower,alnum,space,time
        throw Exception("Not a valid type")

    If variable is %type%
        return true
}
