@echo GraphicsMagick-X.X.XX-Q8-win32-dll.exe
@echo ftp://ftp.graphicsmagick.org/pub/GraphicsMagick/windows/
@echo off
set PLUGIN_FOLDER = {{af}}
set PNGASM=apngasm
set MAGICK=magick
set PROJPATH ={{projPath}}
set SANDBOXPATH={{sandboxPath}}

{{#AGIF}}
%MAGICK% -loop {{loop} -delay {{delay}} %SANDBOXPATH%\\{{fileName}}_*.png %PROJPATH%\\temp\\{{fileName}}.gif
{{/AGIF}}

cd %PLUGIN_FOLDER%
{{#APNG}}
%PNGASM% %PROJPATH%\\temp\\{{fileName}}.png %SANDBOXPATH%\\{{fileName}}_*.png 1 {{frameRate}} -l{{loop}} -z2
{{/APNG}}

