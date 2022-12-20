(:06 -- a legfrissebb elkövető az adatállományban, az illető tulajdonságai [name, sex, hairColor, placeOfBirth, subjects, possibleCountries, possibleStates, publication] XML dokumentumként visszaadva, valamint ez a dokumentum validálva :)

xquery version "3.1";

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "xml";
declare option output:indent "yes";

declare function local:get-all-publication($wanted, $class) {
    for $w in $wanted?*
        where $w?person_classification eq $class
    return map { "publication" : $w?publication }
};

declare function local:get-max-publication($wanted, $class) {
    let $publications := local:get-all-publication($wanted, $class)
    return max($publications?publication)
};



let $src := json-doc("exports/01.json")

return validate {document {

        <freshMeat xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="schema/06.xsd">
            {for $s in $src?*
                where $s?publication eq local:get-max-publication($src, "Main")
             return
             <person>
                <name>{$s?title}</name>
                <sex>{$s?sex}</sex>
                <hairColor>{$s?hair}</hairColor>
                 <placeOfBirth>{$s?place_of_birth}</placeOfBirth>
                 <subjects>
                        {for $i in $s?subjects?*
                            return <subject> {$i} </subject>}
                    </subjects>
                 <possibleCountries>{$s?possible_countries}</possibleCountries>
                 <possibleStates>{$s?possible_states}</possibleStates>
                 <publication>{$s?publication}</publication>
             </person>}
        </freshMeat>
}
}