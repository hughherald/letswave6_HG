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

% Last Modified by GUIDE v2.5 09-Apr-2015 01:06:20

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

rootNode = xmlread('LW_baseline.xml');
%xmlwrite('LW_baseline.xml',rootNode);
theNode = rootNode.getElementsByTagName('item');
handles.tab_fun.Data=cell(theNode.getLength,2);
for k=1:theNode.getLength
    item=theNode.item(k-1);
    handles.tab_fun.Data(k,1)=item.getAttribute('name');
    handles.tab_fun.Data(k,2)=item.getAttribute('default');
end
handles.table_temp.Data=cell(1,1);
handles.theNode=theNode;
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


% --- Executes on selection change in listbox_fun.
function listbox_fun_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_fun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_fun contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_fun


% --- Executes during object creation, after setting all properties.
function listbox_fun_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_fun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected cell(s) is changed in tab_fun.
function tab_fun_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tab_fun (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
table_temp_CellEditCallback(hObject, eventdata, handles)
if(size(eventdata.Indices,1)>0 && eventdata.Indices(2)==2);
    item=handles.theNode.item(eventdata.Indices(1)-1);
    if ~strcmp(item.getAttribute('default'),'')
        handles.focus=eventdata.Indices;
        hObject.Units='pixels';
        handles.table_temp.Units='pixels';
        dp_position=hObject.Extent(4)/size(handles.tab_fun.Data,1)-0.15;
        position(1)=hObject.Position(1)+hObject.ColumnWidth{1};
        position(2)=hObject.Position(2)+hObject.Position(4)-eventdata.Indices(1)*dp_position;
        position(3)=hObject.Position(3)-hObject.ColumnWidth{1};
        position(4)=dp_position;
        handles.table_temp.Position=position;
        handles.table_temp.Visible='on';
        uicontrol(handles.table_temp.Parent);
        guidata(hObject, handles);
    end
end


% --- Executes when entered data in editable cell(s) in table_temp.
function table_temp_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to table_temp (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
x=str2double(handles.table_temp.Data);
if ~isnan(x)
    handles.table_fun.Data(handles.focus(1),handles.focus(2))=x;
    handles.table_temp.Visible='off';
end
