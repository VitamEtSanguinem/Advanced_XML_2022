(:05 -- XML dokumentum készítése és validálása azon Férfi elkövetőkre akik emberrablás bűntett miatt állnak körözés alatt. [körözés tárgya(i) , név, nem, publikáció] :)

xquery version "3.1";

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "xml";
declare option output:indent "yes";


let $url := json-doc("exports/01.json")


        
return validate{  document {

    <maleKidnappers xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="schema/05.xsd">
        
        {for $s in $url?*
            where tokenize($s?path, "/")[3] eq "kidnap" and $s?sex eq "Male"
            order by $s?publication
         return <person> 
                    <subjects>
                        {for $i in $s?subjects?*
                            return <subject> {$i} </subject>}
                    </subjects>
                    <name>{$s?title}</name>
                    <sex>{$s?sex}</sex>
                    <publication>{$s?publication}</publication>
                </person>}
    
    </maleKidnappers>


}
}
        


