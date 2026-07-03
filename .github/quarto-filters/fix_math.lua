-- Pandoc Lua filter: fix_math.lua
-- Fixes common LaTeX math mode issues and ensures proper escaping
-- Runs when rendering to PDF/LaTeX format

function Math(el)
  if FORMAT:match("latex") or FORMAT:match("pdf") then
    local text = el.text
    
    -- Ensure proper escaping of problematic characters in math mode
    -- Don't double-escape already escaped characters
    if not text:match("\\\\") then
      -- Fix common operators that might cause issues
      text = text:gsub("([^\\])#", "%1\\#")
    end
    
    el.text = text
  end
  return el
end

function RawInline(el)
  if FORMAT:match("latex") or FORMAT:match("pdf") then
    if el.format == "tex" or el.format == "latex" then
      local text = el.text
      -- In LaTeX context, be careful with escaping
      -- Only escape # if not already escaped
      if not text:match("\\#") then
        text = text:gsub("([^\\])#", "%1\\#")
      end
      el.text = text
    end
  end
  return el
end

function RawBlock(el)
  if FORMAT:match("latex") or FORMAT:match("pdf") then
    if el.format == "tex" or el.format == "latex" then
      local text = el.text
      -- Be careful with block-level LaTeX
      if not text:match("\\#") then
        -- Only escape # that are not parameter references in commands
        text = text:gsub("([^\\#])#([^%d])", "%1\\#%2")
      end
      el.text = text
    end
  end
  return el
end
