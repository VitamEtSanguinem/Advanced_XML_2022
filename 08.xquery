(:08 -- HTML dokumentum készítése a 09-es lekérdezés kimenete alapján, a HTML oldalon szerepeljen egy sorszámozás, a személyek neve, státusza, osztályozása, a fényképük, valamint a publikáció ideje:)

xquery version "3.1";

declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace op = "http://www.w3.org/2002/08/xquery-operators";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "html";
declare option output:html-version "5.0";
declare option output:indent "yes";



let $src := json-doc("exports/results_for_html_from_09.json")?*

return document {

    <html>
        <head>
            <title>Rémiás Dávid - Y04PD8 - FBI Wanted Api XQuery Projektmunka</title>
        </head>
        <body>
            <div>
                <table>
                    <thead>
                        <tr>
                            <th>Num</th>
                            <th>Name</th>
                            <th>Status</th>
                            <th>Classification</th>
                            <th>Image</th>
                            <th>Publication</th>
                        </tr>
                    </thead>
                    <tbody>
                          {
                             for $p in $src
                             count $i
                             return
                              <tr>
                                <td>{$i}</td>
                                <td>{$p?name}</td>
                                <td>{$p?status}</td>
                                <td>{$p?person_classification}</td>
                                <td>
                                  <a href="{$p?original}"><img src="{$p?thumb}"/></a>
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

