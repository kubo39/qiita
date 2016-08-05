import std.stdio;
import std.json;
import std.conv : to;
import qiita : searchItems;

void main()
{
   auto resp = searchItems(["query": "dlang"]);
   auto content = parseJSON(resp.to!string);
   foreach (i; 0 .. 5)
       content.array[i]["title"].str.writeln;
}
