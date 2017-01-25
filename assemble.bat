@echo GraphicsMagick-X.X.XX-Q8-win32-dll.exe
@echo ftp://ftp.graphicsmagick.org/pub/GraphicsMagick/windows/
@echo off
set PLUGIN_FOLDER = {{af}}
set PNGASM=apngasm
set MAGICK=magick
set PROJPATH ={{projPath}}
set SANDBOXPATH={{sandboxPath}}

{{#AGIF}}
%MAGICK% -loop {{loop} -delay {{delay}} %SANDBOXPATH%\\{{filename}}_*.png %PROJPATH%\\temp\\{{filename}}.gif
{{/AGIF}}

cd %PLUGIN_FOLDER%
{{#APNG}}
%PNGASM% %PROJPATH%\\temp\\{{filename}}.png %SANDBOXPATH%\\{{filename}}_*.png 1 {{frameRate}} -l{{loop}} -z2
{{/APNG}}

