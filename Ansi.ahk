/**
 * Ansi Styling and Coloring
 * Written by KR1ZZ1 @ github
 * Date: 30.09.2023
 *
 * Ansi codes found here:
 * https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences
 *
 * @property {string}  rgb                Sets up for rgb on text with the next following params being red, green, blue (If additional settings, double wrap the string with a second Ansi Modify)
 * @property {string}  rgb_background     Sets up for rgb on background with the next following params being red, green, blue (If additional settings, double wrap the string with a second Ansi Modify)
 * @property {integer} black              Text color
 * @property {integer} red                Text color
 * @property {integer} green              Text color
 * @property {integer} yellow             Text color
 * @property {integer} blue               Text color
 * @property {integer} purple             Text color
 * @property {integer} cyan               Text color
 * @property {integer} white              Text color
 * @property {integer} black_background   Background color
 * @property {integer} red_background     Background color
 * @property {integer} green_background   Background color
 * @property {integer} yellow_background  Background color
 * @property {integer} blue_background    Background color
 * @property {integer} purple_background  Background color
 * @property {integer} cyan_background    Background color
 * @property {integer} white_background   Background color
 * @property {integer} bold               Text style
 * @property {integer} italic             Text style
 * @property {integer} underline          Text style
 * @property {integer} double_underline   Text style
 * @property {integer} linethrough        Text style
 * @property {integer} slow_blinking      Text style
 * @property {integer} blinking           Text style
 * @property {integer} low_intensity      Text style (Affects color)
 */
class Ansi {
    ; Text colors
        static rgb := "38;2"
        static black := 30
        static red := 31
        static green := 32
        static yellow := 33
        static blue := 34
        static purple := 35
        static cyan := 36
        static white := 37
    ; Background colors
        static rgb_background := "48;2"
        static black_background := 40
        static red_background := 41
        static green_background := 42
        static yellow_background := 43
        static blue_background := 44
        static purple_background := 45
        static cyan_background := 46
        static white_background := 47
    ; Text styles
        static bold := 1
        static low_intensity := 2
        static italic := 3
        static underline := 4
        static slow_blinking := 5
        static blinking := 6
        static linethrough := 9
        static double_underline := 21
    ; Discord wrap
        static discord := 1337

    /**
     * Wraps the incoming string with the parameters specified in an ansi format
     * @param   {string}                string
     * @param   {...(integer|string)}   params*
     * @return  {Ansi}                  string
     */
    wrap(string, params*) {
        mod := ""
        For _, param in params {
            if (this[param] = this.discord || param = 1337) {
                mod := "``````ansi`n" mod
                continue
            }
            if (!this[param] && !(param >= 0 && param <= 255) && param != this.rgb && param != this.rgb_background) {
                throw Exception("""" param """ is not a valid parameter.")
            }
            mod .= (!mod || mod = "``````ansi`n" ? "[" : ";") (this.type(param, "digit") ? param : (param = this.rgb || param = this.rgb_background ? param : this[param]))
        }
        mod .= (mod ? "m" : "") string (mod ? "[" 0 "m" : "") (InStr(mod, "``````ansi") ? "`n``````" : "")
        return mod
    }

    /**
     * Check if variable is given type
     * @param   {variable}    variable
     * @param   {string}      [type] "integer"|"float"|"number"|"digit"|"xdigit"|"alpha"|"upper"|"lower"|"alnum"|"space"|"time"
     * @return  {boolean}
     */
    type(variable, type := "integer") {
        If type not in integer,float,number,digit,xdigit,alpha,upper,lower,alnum,space,time
            throw Exception("Not a valid type")

        If variable is %type%
            return true
    }
}
