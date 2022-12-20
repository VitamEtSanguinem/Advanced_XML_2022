(:04 -- XML dokumentum készítése és validálása, az elkövetők kategorizálása hajszín alapján, és hány elkövető tartozik az így alkotott kategóriákba. :)

xquery version "3.1";

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "xml";
declare option output:indent "yes";


let $src := json-doc("exports/01.json")


return validate{ document {
                
       <groupingByHairColor xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="schema/04.xsd">{
                  for $h in $src?*
                      let $group := $h?hair
                          where exists($h?hair)
                          group by $group
                          order by count($h)
                  return <hairColor haircolor="{$group}" number="{count($h)}" ></hairColor>
                  }
        </groupingByHairColor>
        


        
}}