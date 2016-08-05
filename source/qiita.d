module qiita;

import requests;
import url : percentEncode;
import std.string : join;
import std.array : Appender;

static endpoint = "http://qiita.com/api/v2/";

auto get(string path, string[string] options)
{
    Appender!string url;
    url ~= endpoint;
    url ~= path;
    url ~= '?';
    url ~= buildQuery(options);
    return getContent(url.data); 
}

auto searchItems(string[string] options)
{
    return get("items", options);
}

private:

string buildQuery(string[string] options)
{
    Appender!string s;
    bool first = true;
    foreach (k, v; options)
    {
        if (!first)
            s ~= '&';
        first = false;
        s ~= percentEncode(k);
        s ~= '=';
        s ~= percentEncode(v);
    }
    return s.data;
}

unittest
{
    {
        string[string] aa = ["aa": "1", "bb": "2"];
        assert(buildQuery(aa) == "aa=1&bb=2");
    }
    {
        string[string] aa = ["query": "dlang"];
        assert(buildQuery(aa) == "query=dlang");
    }
}
