APNGASM="/Library/Application Support/Adobe/CEP/extensions/com.kwiksher.kwik4/ext/Mac/apngasm"
SANDBOXPATH="{{sandboxPath}}"
PROJPATH="{{projPath}}"

chmod a+x "$APNGASM"

{{#APNG}}
"$APNGASM" $PROJPATH/temp/{{filename}}.png "$SANDBOXPATH"/{{filename}}_*.png 1 {{frameRate}} -l{{loop}} -z2
{{/APNG}}

{{#AGIF}}
gm convert -loop {{loop} -delay {{delay}} "$SANDBOXPATH"/{{filename}}_*.png $PROJPATH/temp/{{filename}}.gif
{{/AGIF}}
