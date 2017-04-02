set nsigs [ gtkwave::getNumFacs ]
set sigs [list]
# fix a strange bug where addSignalsFromList doesn't seem to work
# if the 1st signal to be added is not a single bit
lappend sigs "__bug_marker__"
for {set i 0} {$i < $nsigs} {incr i} {
set name [ gtkwave::getFacName $i ]
lappend sigs $name
}
