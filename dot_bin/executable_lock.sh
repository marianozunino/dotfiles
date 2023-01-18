#!/bin/bash
TMPBG=/tmp/screen.png
scrot $TMPBG
convert $TMPBG -scale 10% -scale 1000%  -fill "rgba( 0, 0, 0 , 0.7 )" none \
    -strokewidth 3 -draw "rectangle 5,780 180,890" $TMPBG

i3lock -n -i $TMPBG --insidecolor=373445ff --ringcolor=ffffffff --line-uses-inside \
    --keyhlcolor=d23c3dff --bshlcolor=d23c3dff --separatorcolor=00000000 \
    --insidevercolor=fecf4dff --insidewrongcolor=d23c3dff \
    --ringvercolor=ffffffff --ringwrongcolor=ffffffff --indpos="x+86:y+800" \
    --radius=15 --veriftext="" --wrongtext="" -f -S 2 \
    -k --timepos="x+86:y+850" --timestr="%H:%M" --timecolor=ffffffff \
    --datecolor=ffffffff --indicator

rm -fr $TMPBG
