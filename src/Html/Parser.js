import { load } from 'cheerio';
import _prettify from 'pretty'

const createModifier = (f) => ($) => {
    f($)
    return $
}

// read :: String -> HtmlParser
export const read = s => load(s, null, true);

// parseHtml :: HtmlParser -> String
export const parseHtml = $ => $.root().html();

// prepend :: String -> String -> HtmlParser -> HtmlParser
export const prepend = (selector) => element => createModifier(($) => $(selector).prepend(element));

// prettify :: String -> String
export const prettify = s => _prettify(s)
