(:09 -- a 08-as feladat HTML dokumentumához lekérni a Wanted Api 3. oldalából elkészített map-et [name, status, publication, image orginial , image thumb, , person_classification], amely azokat a személyeket tartalmazza, kiknek publikációja 2017-es évű:)

xquery version "3.1";

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:media-type "application/json";


declare function local:get-everyone-from-page($url){

    let $page := $url    
    return $page?items    
    
};



let $loc := json-doc("exports/09.json")



return
    array {
        for $p in $loc?*
            where exists($p?publication) and (tokenize($p?publication, "-")[1] = "2017")
            order by $p?publication
        return
            map {
                "name": $p?title,
                "person_classification": $p?person_classification,
                "status": $p?status,
                "publication": $p?publication, 
                "thumb": $p?images?*[1]?thumb,
                "original": $p?images?*[1]?original
            }
    }


(:let $res := local:get-everyone-from-page(json-doc("https://api.fbi.gov/wanted/v1/list?page=3"))    

return $res   -  a 3. oldal lekéréséhez használtam:)