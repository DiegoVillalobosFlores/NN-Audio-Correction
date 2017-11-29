function varargout = CorreccionGUI(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CorreccionGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @CorreccionGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function CorreccionGUI_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

guidata(hObject, handles);

function varargout = CorreccionGUI_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function ruta_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function examinar_Callback(hObject, eventdata, handles)
[f,~] = uigetfile({'*'});

[y,fs] = audioread(f);
cR = y(:,1);
cL = y(:,2);

n = length(y);

t = linspace(0, n/fs, n);

handles.y = y;
handles.fs = fs;
handles.cR = cR;
handles.cL = cL;
handles.n = n;
handles.t = t;

plot(handles.axes1,t,cL);

pN = 3;

nY = y;

for cont = 1:length(y)
    r = 100.*rand(1,1) + 1;
    if(r <= pN)
        nY(cont,1) = 0;
        nY(cont,2) = 0;
    end
end

plot(handles.axes2,t,nY(:,1))
plot(handles.axes3,t,cL);

handles.player = audioplayer(y,fs);
handles.nY = nY;
set(handles.ruta, 'String', f);
guidata(hObject,handles)

function rep1_Callback(hObject, eventdata, handles)

player = handles.player;
if(player.isplaying == 1)
    stop(player)
else
    player = audioplayer(handles.y,handles.fs);
    player.play;
    handles.player = player;
    guidata(hObject,handles)
end

function play2_Callback(hObject, eventdata, handles)
player = handles.player;
if(player.isplaying == 1)
    stop(player)
else
    player = audioplayer(handles.nY,handles.fs);
    player.play;
    handles.player = player;
    guidata(hObject,handles)
end


function play3_Callback(hObject, eventdata, handles)
player = handles.player;
if(player.isplaying == 1)
    stop(player)
else
    player = audioplayer(handles.y,handles.fs);
    player.play;
    handles.player = player;
    guidata(hObject,handles)
end