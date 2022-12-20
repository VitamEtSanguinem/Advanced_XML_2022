(:07 -- az összes Férfi elkövető listázása [name, race, possible countries, publication (ez utóbbi szerint rendezve)] az első feladat outputjából, majd ebből XML dokumentum készítése és validálása:)

xquery version "3.1";

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "xml";
declare option output:indent "yes";


let $src := json-doc("exports/01.json")
let $sex := "Male"



return validate {document {
    
    <maleWanted xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="schema/07.xsd">
        
        {for $p in $src?*
            where $p?sex eq $sex
            order by $p?publication
         return 
         <person>
            <name>{$p?title}</name>
            <race>{$p?race}</race>
            <possibleCountries>{$p?possible_countries}</possibleCountries>
            <publication>{$p?publication}</publication>
         </person>}
    </maleWanted>

}
}