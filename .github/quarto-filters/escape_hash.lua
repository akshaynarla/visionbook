-- Pandoc Lua filter: escape_hash.lua
-- Escapes literal '#' characters when rendering to LaTeX output so TeX doesn't treat them
-- as macro parameter tokens. This runs only when FORMAT matches latex.
-- It handles Str, RawInline, and RawBlock nodes.

function Str(el)
  if FORMAT:match("latex") then
    -- Only escape # if not inside math mode or other special contexts
    -- Simple check: don't escape if surrounded by math delimiters
    if not el.text:match("^%$.*%$$") then
      el.text = el.text:gsub("#", "\\#")
    end
  end
  return el
end

function RawInline(el)
  if FORMAT:match("latex") then
    -- Skip escaping for LaTeX and math formats
    if el.format == "html" or el.format == "" then
      el.text = el.text:gsub("#", "\\#")
    end
    -- Never escape content in latex or math format
  end
  return el
end

function RawBlock(el)
  if FORMAT:match("latex") then
    if el.format == "html" or el.format == "" then
      el.text = el.text:gsub("#", "\\#")
    end
    -- Never escape content in latex or math format
  end
  return el
end
