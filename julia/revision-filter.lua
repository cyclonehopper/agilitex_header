function Meta(meta)
    -- Check if revisions exist in metadata
    if meta.revisions then
        -- Initialize LaTeX commands string
        local tex_commands = "\\usepackage{colortbl}\n\\usepackage{array}\n"
        tex_commands = tex_commands .. "\\def\\revisionData{\n"
        
        -- Process each revision
        for _, rev in ipairs(meta.revisions) do
            -- Add revision data, escaping special characters
            tex_commands = tex_commands .. "\\hline\n"
            tex_commands = tex_commands .. string.format(
                "\\multicolumn{1}{|p{8mm}|}{\\fontsize{9}{11}\\selectfont %s} & \n" ..
                "\\multicolumn{1}{p{15mm}|}{\\fontsize{9}{11}\\selectfont %s} & \n" ..
                -- "\\multicolumn{1}{l@{\\extracolsep{\\fill}}|}{\\fontsize{9}{11}\\selectfont %s} & \n" ..
                "\\multicolumn{1}{X|}{\\fontsize{9}{11}\\selectfont %s} & \n" ..
                "\\multicolumn{1}{p{20mm}|}{\\fontsize{9}{11}\\selectfont %s} & \n" ..
                "\\multicolumn{1}{p{20mm}|}{\\fontsize{9}{11}\\selectfont %s} & \n" ..
                "\\multicolumn{1}{p{20mm}|}{\\fontsize{9}{11}\\selectfont %s} \\\\\n",
                pandoc.utils.stringify(rev.revNo or ""), 
                pandoc.utils.stringify(rev.revDate or ""),
                pandoc.utils.stringify(rev.revDesc or ""),
                pandoc.utils.stringify(rev.revAuthor or ""),
                pandoc.utils.stringify(rev.revCheck or ""),
                pandoc.utils.stringify(rev.revApp or "")
            )
        end
        tex_commands = tex_commands .. "\\hline\n}\n"

        -- insert commands into header-includes that bottomMargin is calculated based on number of revisions    
        tex_commands = tex_commands .. "\\newlength{\\revisionTableHeight}\n"
        tex_commands = tex_commands .. string.format("\\setlength{\\revisionTableHeight}{%dmm}\n", revtableht(meta))
        tex_commands = tex_commands .. "\\setlength{\\revisionTableHeight}{\\dimexpr\\revisionTableHeight + 25mm\\relax}\n"
        
        -- insert \def\revNo{B} into tex_commands, where B is the last revision number
        tex_commands = tex_commands .. "\\def\\revNo{" .. pandoc.utils.stringify(meta.revisions[#meta.revisions].revNo) .. "}\n"    
        
        -- insert \def\calcDate into tex_commands, where calcDate is the date of the last revision
        tex_commands = tex_commands .. "\\def\\calcDate{" .. pandoc.utils.stringify(meta.revisions[#meta.revisions].revDate) .. "}\n"   
        
        -- Insert commands into header-includes
        if not meta["header-includes"] then
            meta["header-includes"] = {}
        end
        table.insert(meta["header-includes"], 1, pandoc.RawBlock("tex", tex_commands))


        
    end
    return meta
end

-- function to calculate the bottom margin based on the number of revisions, in mm
function revtableht(meta)
    if meta.revisions then
        local numRevisions = #meta.revisions
        return (numRevisions +1) * 10
    end
    return 0
end 

