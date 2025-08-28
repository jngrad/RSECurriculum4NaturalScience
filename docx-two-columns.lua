-- Forces two-column layout for DOCX output while keeping styles from reference-doc
-- Usage: add this filter only for docx in your Quarto/Pandoc config.

function Pandoc(doc)
  -- Only act for docx targets
  if not FORMAT or not FORMAT:match("docx") then
    return doc
  end

  -- Insert a continuous section break at the *start* that sets two columns.
  -- Word uses the most recent <w:sectPr> to define section properties from
  -- that point forward, so doing this up-front makes the whole document 2-col.
  local two_col_openxml = [[
<w:p>
  <w:pPr>
    <w:sectPr>
      <w:type w:val="continuous"/>
      <w:cols w:num="2" w:sep="1" w:space="720"/>
    </w:sectPr>
  </w:pPr>
</w:p>
]]

  table.insert(doc.blocks, 1, pandoc.RawBlock("openxml", two_col_openxml))

  return doc
end
