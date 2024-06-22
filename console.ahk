#Include, Ansi.ahk

class console {
    /**
     * Prints string or array to OutputDebug
     * @param   {string|array|object} params*
     * @return  {void}
     */
    log(params*) {
        For _,data in params {
            OutputDebug(data)
        }
    }

    /**
     * Prints to OutputDebug in green
     * @param   {string|integer} params*
     * @return  {void}
     */
    success(params*) {
        Color := new Ansi()
        For _,string in params {
            if (IsObject(string)) {
                throw Exception("this function requires text, use print instead.")
            }
            OutputDebug, % Color.Wrap(string, "green", "bold")
        }
    }

    /**
     * Prints to OutputDebug in yellow italic
     * @param   {string|integer} params*
     * @return  {void}
     */
    info(params*) {
        Color := new Ansi()
        For _,string in params {
            if (IsObject(string)) {
                throw Exception("this function requires text, use print instead.")
            }
            OutputDebug, % Color.Wrap(string, "yellow", "italic")
        }
    }

    /**
     * Accepts multiple params using the first as a blinking highlighted message and any preceding ones as red bold
     * @param   {string|integer} params*
     * @return  {void}
     */
    error(params*) {
        Color := new Ansi()
        For index, string in params {
            if (IsObject(string)) {
                throw Exception("this function requires text, use print instead.")
            }
            str := " " string " "
            OutputDebug, % index < 2 ? Color.Wrap(str, "white", "red_background", "blinking")
                                     : Color.Wrap(str, "red", "bold")
        }

    }
}

/**
 * OutputDebug wrapping to allow for strings and arrays to be sent to a debugger
 * In addition uses Ansi color coding (tested on Visual Studio Code Debug Console)
 *
 * Written by krizzi @ discord
 * Date: 30.09.2023
 * 
 * @param   {string|array}  content
 * @param   {bool}          print   primarily used by this function to control when to construct the string and when to print the constructed string
 * @param   {integer}       indent  primarily used to control array indentations during construction of the string
 * @return  {string}        string  output of the constructed string
 */
OutputDebug(content, print := true, indent := 0) {
    static Color := new Ansi()

    ; Print when receiving string
    If (!IsObject(content) && print) {
        OutputDebug, % content
        return
    }

    ; Object / Array string construction
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

StrRepeat(string, count) {
    Loop, % count {
        str .= string
    }
    return str ? str : string
}

/**
 * Check if variable is given type
 * @param {variable}    variable
 * @param {string}      [type] "integer"|"float"|"number"|"digit"|"xdigit"|"alpha"|"upper"|"lower"|"alnum"|"space"|"time"
 * @return {boolean}
 */
type(variable, type := "integer") {
    If type not in integer,float,number,digit,xdigit,alpha,upper,lower,alnum,space,time
        throw Exception("Not a valid type")

    If variable is %type%
        return true
}