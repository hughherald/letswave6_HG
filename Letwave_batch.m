function varargout = Letwave_batch(varargin)
% LETWAVE_BATCH MATLAB code for Letwave_batch.fig
%      LETWAVE_BATCH, by itself, creates a new LETWAVE_BATCH or raises the existing
%      singleton*.
%
%      H = LETWAVE_BATCH returns the handle to a new LETWAVE_BATCH or the handle to
%      the existing singleton*.
%
%      LETWAVE_BATCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LETWAVE_BATCH.M with the given input arguments.
%
%      LETWAVE_BATCH('Property','Value',...) creates a new LETWAVE_BATCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Letwave_batch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Letwave_batch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Letwave_batch

% Last Modified by GUIDE v2.5 08-Apr-2015 22:30:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Letwave_batch_OpeningFcn, ...
                   'gui_OutputFcn',  @Letwave_batch_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before Letwave_batch is made visible.
function Letwave_batch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Letwave_batch (see VARARGIN)

% Choose default command line output for Letwave_batch
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Letwave_batch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Letwave_batch_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
