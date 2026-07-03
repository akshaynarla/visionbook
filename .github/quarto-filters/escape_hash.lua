-- Pandoc Lua filter: escape_hash.lua
-- Escapes literal '#' characters when rendering to LaTeX output so TeX doesn't treat them
-- as macro parameter tokens. This runs only when FORMAT matches latex.
-- It handles Str, RawInline, and RawBlock nodes.

function Str(el)
  if FORMAT:match("latex") then
    el.text = el.text:gsub("#", "\\#")
  end
  return el
end

function RawInline(el)
  if FORMAT:match("latex") then
    -- Only modify HTML/raw content that will be passed through
    if el.format == "html" or el.format == "" then
      el.text = el.text:gsub("#", "\\#")
    end
  end
  return el
end

function RawBlock(el)
  if FORMAT:match("latex") then
    if el.format == "html" or el.format == "" then
      el.text = el.text:gsub("#", "\\#")
    end
  end
  return el
end
