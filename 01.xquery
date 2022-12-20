(:01 -- az összes körözött személy lekérdezése:)


xquery version "3.1";

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:media-type "application/json";



declare function local:getResult($n as xs:integer?, $url as xs:string?) {
    let $page := json-doc(concat($url,$n))    
    return $page?items
};

let $url := "https://api.fbi.gov/wanted/v1/list?page="
let $res := local:getResult(2, $url)

return $res
    