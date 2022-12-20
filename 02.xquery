(:02 -- a Main classification-nel rendelkező személyek neveinek listázása az első feladat outputját felhasználva :)

xquery version "3.1";

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:media-type "application/json";




declare function local:get-main-class($url as xs:string?){
    let $prev := json-doc($url)      
    return array {for $m in $prev?*
                        where contains($m?person_classification, "Main")  
                  return $m?title}
};



let $res := local:get-main-class("exports/01.json")
return $res