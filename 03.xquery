(:03 -- azon elkövetők listája akik neme nő, illetve hollétük behatárolható (map-elve), publikáció szerint rendezve:)

xquery version "3.1";

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:media-type "application/json";


declare function local:women-with-unknown-countries($path as xs:string?){

    let $source := json-doc($path)
    
    return array{
            
            for $w in $source?*
                where $w?sex eq "Female" and exists($w?possible_countries) 
                order by $w?publication
               
                
            return map{
                  "name" : $w?title,
                  "person_classification" : $w?person_classification,
                  "status": $w?status,
                  "publication": $w?publication,
                  "possible_countries":$w?possible_countries
                    
                }
    }

};


let $res := local:women-with-unknown-countries("exports/01.json")
return $res