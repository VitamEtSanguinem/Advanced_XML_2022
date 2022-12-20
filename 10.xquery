(:10 -- HTML oldal készítése az első feladat json állománya alapján, az oldalon megjelenítendő tartalom : [sorszám, személy neve, a személyhez tartozó PDF fájl linkje, publikáció]:)

xquery version "3.1";

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "html";
declare option output:html-version "5.0";
declare option output:indent "yes";


let $src := json-doc("exports/01.json")?*

return document {

    <html>
        <head><title>Rémiás Dávid - Y04PD8 - FBI Wanted Api XQuery Projektmunka</title></head>
        <body>
            <div>
                <table>
                    <thead>
                        <tr>
                            <th>Num</th>
                            <th>Name</th>
                            <th>PDF document</th>
                            <th>Publication</th>
                        </tr>
                    </thead>
                    <tbody>
                        {for $p in $src
                             count $i
                             return
                             <tr>
                             <td>{$i}</td>
                             <td>{$p?title}</td>
                             <td>
                                <a href="{$p?files?*[1]?url}">{$p?files?*[1]?url}</a>
                             </td>
                             <td>{$p?publication}</td>
                             </tr>
                            }
                    </tbody>
                </table>
            </div>
        </body>
        <footer></footer>
    </html>

}

