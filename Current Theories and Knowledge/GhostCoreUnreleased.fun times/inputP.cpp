#include <iostream>
#include <string>
#include <vector>
#include <regex>
#include <windows.h>

enum TSymbolType {
    PLAINTEXT,
    A_TAG, B_TAG, H1_TAG, H2_TAG, H3_TAG, H4_TAG, H5_TAG, H6_TAG,
    P_TAG, UL_TAG, OL_TAG, LI_TAG, OTHER_TAG
};

struct TSymbol {
    TSymbolType Symbol;
    std::string URL;
    std::string Text;
    std::string TagName;
};

TSymbol parseAnchor(const std::string &tag) {
    TSymbol symbol;
    symbol.Symbol = A_TAG;
    symbol.TagName = "a";

    std::regex hrefRegex(R"(href=\"([^\"]*)\")");
    std::smatch match;
    if (std::regex_search(tag, match, hrefRegex)) {
        symbol.URL = match[1];
    }

    return symbol;
}

TSymbol parseTag(const std::string &tag) {
    TSymbol symbol;

    if (tag.find("<a") != std::string::npos) {
        symbol = parseAnchor(tag);
    } else if (tag.find("<b>") != std::string::npos || tag.find("</b>") != std::string::npos) {
        symbol.Symbol = B_TAG;
        symbol.TagName = "b";
    } else if (tag.find("<p>") != std::string::npos || tag.find("</p>") != std::string::npos) {
        symbol.Symbol = P_TAG;
        symbol.TagName = "p";
    } else if (tag.find("<ul>") != std::string::npos || tag.find("</ul>") != std::string::npos) {
        symbol.Symbol = UL_TAG;
        symbol.TagName = "ul";
    } else if (tag.find("<ol>") != std::string::npos || tag.find("</ol>") != std::string::npos) {
        symbol.Symbol = OL_TAG;
        symbol.TagName = "ol";
    } else if (tag.find("<li>") != std::string::npos || tag.find("</li>") != std::string::npos) {
        symbol.Symbol = LI_TAG;
        symbol.TagName = "li";
    } else {
        symbol.Symbol = OTHER_TAG;
        symbol.TagName = tag;
    }

    return symbol;
}

TSymbol parseText(const std::string &text) {
    TSymbol symbol;
    symbol.Symbol = PLAINTEXT;
    symbol.Text = text;
    return symbol;
}

std::vector<TSymbol> parseHTML(const std::string &html) {
    std::vector<TSymbol> symbols;
    std::regex tagRegex(R"(<[^>]*>)");
    std::sregex_token_iterator iter(html.begin(), html.end(), tagRegex, {-1, 0});
    std::sregex_token_iterator end;

    while (iter != end) {
        std::string part = *iter++;
        if (part.empty()) continue;

        if (part[0] == '<') {
            TSymbol symbol = parseTag(part);
            symbols.push_back(symbol);
        } else {
            TSymbol symbol = parseText(part);
            symbols.push_back(symbol);
        }
    }
    return symbols;
}

void printSymbols(const std::vector<TSymbol> &symbols) {
    for (const auto &symbol : symbols) {
        if (symbol.Symbol == PLAINTEXT) {
            std::cout << "Text: " << symbol.Text << "\n";
        } else {
            std::cout << "Tag: <" << symbol.TagName << ">";
            if (!symbol.URL.empty()) {
                std::cout << " (URL: " << symbol.URL << ")";
            }
            std::cout << "\n";
        }
        Sleep(500);
    }
}

int main() {
    std::string html = R"(
        <html>
            <head><title>Sample HTML</title></head>
            <body>
                <h1>Welcome</h1>
                <p>This is a <b>bold</b> paragraph.</p>
                <a href="http://example.com">Click here</a>
                <ul><li>Item 1</li><li>Item 2</li></ul>
            </body>
        </html>
    )";

    std::vector<TSymbol> symbols = parseHTML(html);
    printSymbols(symbols);

    return 0;
}